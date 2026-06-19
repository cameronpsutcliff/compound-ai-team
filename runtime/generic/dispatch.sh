#!/usr/bin/env bash
set -u

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
STANDARDS_DIR="${CAOS_STANDARDS_DIR:-$(cd "$SCRIPT_DIR/../.." && pwd)}"
RUNTIME_NAME="${CAOS_RUNTIME_NAME:-generic}"
AGENT_CMD="${CAOS_AGENT_CMD:-}"
INPUT_FILE=""

usage() {
  cat <<'EOF'
Usage: dispatch.sh [--runtime NAME] [--agent-cmd CMD] [--input FILE]

Reads an adapter-contract task JSON object and returns a result JSON object.
If no agent command is supplied, the wrapper prepares the routed prompt and
returns it as the output for manual or GUI dispatch.
EOF
}

while [ "$#" -gt 0 ]; do
  case "$1" in
    --runtime)
      RUNTIME_NAME="${2:-generic}"
      shift 2
      ;;
    --agent-cmd)
      AGENT_CMD="${2:-}"
      shift 2
      ;;
    --input)
      INPUT_FILE="${2:-}"
      shift 2
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      printf '{"id":"unknown","status":"error","output":"","halt_reason":"unknown argument: %s"}\n' "$1"
      exit 2
      ;;
  esac
done

if ! command -v python3 >/dev/null 2>&1; then
  printf '{"id":"unknown","status":"error","output":"","halt_reason":"python3 is required for task JSON parsing"}\n'
  exit 1
fi

TASK_FILE="$(mktemp "${TMPDIR:-/tmp}/caos-task.XXXXXX")"
ROUTE_FILE="$(mktemp "${TMPDIR:-/tmp}/caos-route.XXXXXX")"
USAGE_FILE="$(mktemp "${TMPDIR:-/tmp}/caos-usage.XXXXXX")"
AGENT_OUTPUT_FILE="$(mktemp "${TMPDIR:-/tmp}/caos-agent-output.XXXXXX")"
ENV_FILE="$(mktemp "${TMPDIR:-/tmp}/caos-task-env.XXXXXX")"
trap 'rm -f "$TASK_FILE" "$ROUTE_FILE" "$USAGE_FILE" "$AGENT_OUTPUT_FILE" "$ENV_FILE"' EXIT

if [ -n "$INPUT_FILE" ]; then
  cat "$INPUT_FILE" > "$TASK_FILE" 2>/dev/null || {
    printf '{"id":"unknown","status":"error","output":"","halt_reason":"input file cannot be read"}\n'
    exit 1
  }
else
  cat > "$TASK_FILE"
fi

python3 - "$TASK_FILE" "$ENV_FILE" <<'PY' >/dev/null
import json
import shlex
import sys

task_path, env_path = sys.argv[1], sys.argv[2]
try:
    raw = open(task_path, "r", encoding="utf-8").read()
    data = json.loads(raw)
except Exception as exc:
    with open(env_path, "w", encoding="utf-8") as handle:
        handle.write("TASK_ID=unknown\n")
        handle.write("TASK_PARSE_OK=0\n")
        handle.write("TASK_ERROR=" + shlex.quote(f"unparsable task JSON: {exc}") + "\n")
    raise SystemExit(0)

if not isinstance(data, dict):
    with open(env_path, "w", encoding="utf-8") as handle:
        handle.write("TASK_ID=unknown\n")
        handle.write("TASK_PARSE_OK=0\n")
        handle.write("TASK_ERROR='task must be a JSON object'\n")
    raise SystemExit(0)

task_id = str(data.get("id") or "manual")
prompt = data.get("prompt")
if not isinstance(prompt, str) or not prompt.strip():
    parse_ok = "0"
    task_error = "task prompt is required"
else:
    parse_ok = "1"
    task_error = ""

budget = data.get("budget") if isinstance(data.get("budget"), dict) else {}
goal = data.get("goal") if isinstance(data.get("goal"), dict) else {}
context = data.get("context") if isinstance(data.get("context"), list) else []
validation = goal.get("validation") if isinstance(goal.get("validation"), list) else []

with open(env_path, "w", encoding="utf-8") as handle:
    def write(name, value):
        handle.write(f"{name}={shlex.quote(str(value))}\n")
    write("TASK_ID", task_id)
    write("TASK_PARSE_OK", parse_ok)
    write("TASK_ERROR", task_error)
    write("TASK_PROMPT", prompt or "")
    write("TASK_CONTEXT", "\n".join(str(item) for item in context))
    write("BUDGET_PCT", budget.get("pct_ceiling", ""))
    write("BUDGET_ITERATIONS", budget.get("iterations", ""))
    write("GOAL_OBJECTIVE", goal.get("objective", ""))
    write("GOAL_CONDITION", goal.get("completion_condition", ""))
    write("GOAL_VALIDATION", "\n".join(str(item) for item in validation))
PY

. "$ENV_FILE"

json_result() {
  python3 - "$TASK_ID" "$1" "$2" "${3:-}" "${4:-}" "${5:-}" <<'PY'
import json
import sys

task_id, status, output, halt_reason, usage_pct, memory_update = sys.argv[1:7]
result = {"id": task_id, "status": status, "output": output}
if halt_reason:
    result["halt_reason"] = halt_reason
if usage_pct:
    try:
        result["usage"] = {"pct_used": int(float(usage_pct))}
    except Exception:
        result["usage"] = {"pct_used": -1}
if memory_update:
    result["memory_update"] = memory_update
print(json.dumps(result, separators=(",", ":")))
PY
}

if [ "${TASK_PARSE_OK:-0}" != "1" ]; then
  json_result error "" "${TASK_ERROR:-unparsable or empty task}" "" ""
  exit 1
fi

if [ "${BUDGET_ITERATIONS:-}" = "0" ]; then
  json_result halted "" "iteration budget exhausted before dispatch" "" "Dispatch halted before execution by goal-loop budget."
  exit 0
fi

router_payload="$(python3 - "$TASK_PROMPT" <<'PY'
import json
import sys
print(json.dumps({"prompt": sys.argv[1]}, separators=(",", ":")))
PY
)"

if printf '%s' "$router_payload" | "$STANDARDS_DIR/runtime/claude-code/hooks/session-router.sh" > "$ROUTE_FILE" 2>/dev/null; then
  :
else
  printf '{"hookSpecificOutput":{"additionalContext":"Routing unavailable; fail-open to LIGHT."}}\n' > "$ROUTE_FILE"
fi

ROUTE_CONTEXT="$(python3 - "$ROUTE_FILE" <<'PY'
import json
import sys
try:
    data = json.load(open(sys.argv[1], "r", encoding="utf-8"))
    print(data.get("hookSpecificOutput", {}).get("additionalContext", "Routing tier: LIGHT."))
except Exception:
    print("Routing tier: LIGHT. Router output could not be parsed.")
PY
)"

usage_payload="$(python3 - "$TASK_PROMPT" "$BUDGET_PCT" <<'PY'
import json
import sys
prompt, pct = sys.argv[1], sys.argv[2]
value = 0 if pct == "0" else ""
print(json.dumps({
    "tool_name": "Workflow",
    "tool_input": {
        "prompt": prompt,
        "estimated_usage_pct": value,
    },
}, separators=(",", ":")))
PY
)"

if [ -n "${BUDGET_PCT:-}" ]; then
  if printf '%s' "$usage_payload" | USAGE_GUARD_BLOCK_PCT="$BUDGET_PCT" "$STANDARDS_DIR/runtime/claude-code/hooks/usage-guard.sh" block > "$USAGE_FILE" 2>/dev/null; then
    :
  else
    halt_reason="$(python3 - "$USAGE_FILE" <<'PY'
import json
import sys
try:
    data = json.load(open(sys.argv[1], "r", encoding="utf-8"))
    print(data.get("reason") or "usage discipline blocked dispatch")
except Exception:
    print("usage discipline blocked dispatch")
PY
)"
    usage_pct="$(python3 - "$USAGE_FILE" <<'PY'
import json
import sys
try:
    data = json.load(open(sys.argv[1], "r", encoding="utf-8"))
    print(data.get("usage_pct", ""))
except Exception:
    print("")
PY
)"
    json_result halted "" "$halt_reason" "$usage_pct" "Dispatch halted before execution by usage discipline."
    exit 0
  fi
else
  printf '{"decision":"allow","reason":"no pct ceiling supplied","usage_pct":-1}\n' > "$USAGE_FILE"
fi

prelude_path="$STANDARDS_DIR/runtime/generic/prompt-prelude.md"
if [ -f "$prelude_path" ]; then
  prelude="$(cat "$prelude_path")"
else
  prelude="Follow the Compound AI adapter contract."
fi

DISPATCH_PROMPT="$prelude

$ROUTE_CONTEXT

Runtime: $RUNTIME_NAME
Task id: $TASK_ID

Context:
$TASK_CONTEXT

Task:
$TASK_PROMPT"

if [ -n "$AGENT_CMD" ]; then
  if printf '%s\n' "$DISPATCH_PROMPT" | sh -c "$AGENT_CMD" > "$AGENT_OUTPUT_FILE" 2>&1; then
    :
  else
    output="$(cat "$AGENT_OUTPUT_FILE")"
    json_result error "$output" "agent command failed" "" "Dispatch failed after capability prechecks."
    exit 1
  fi
else
  printf '%s\n' "$DISPATCH_PROMPT" > "$AGENT_OUTPUT_FILE"
fi

python3 - "$TASK_ID" "$AGENT_OUTPUT_FILE" "$GOAL_CONDITION" "$GOAL_VALIDATION" <<'PY'
import json
import os
import subprocess
import sys

task_id, output_path, condition, validations = sys.argv[1:5]
output = open(output_path, "r", encoding="utf-8", errors="replace").read()
status = "done"
halt_reason = ""
completion_met = None

def fail(reason):
    global status, halt_reason
    status = "halted"
    halt_reason = reason

if condition:
    stripped = condition.strip()
    completion_met = False
    if stripped.startswith("output_contains:"):
        needle = stripped.split(":", 1)[1].strip()
        completion_met = needle in output
    elif stripped.startswith("contains:"):
        needle = stripped.split(":", 1)[1].strip()
        completion_met = needle in output
    elif stripped.startswith("file_exists:"):
        path = stripped.split(":", 1)[1].strip()
        completion_met = os.path.exists(path)
    elif stripped.startswith("command:"):
        command = stripped.split(":", 1)[1].strip()
        completion_met = subprocess.call(command, shell=True) == 0
    elif stripped in output:
        completion_met = True
    else:
        fail("completion condition not met or not machine evaluable")

    if completion_met is False and not halt_reason:
        fail("completion condition not met")

if status == "done" and validations:
    for line in validations.splitlines():
        command = line.strip()
        if not command:
            continue
        if subprocess.call(command, shell=True) != 0:
            fail("validation command failed: " + command)
            break

result = {"id": task_id, "status": status, "output": output}
if halt_reason:
    result["halt_reason"] = halt_reason
if condition:
    result["completion_met"] = bool(completion_met)
result["iterations_run"] = 1
result["no_progress_halt"] = False
print(json.dumps(result, separators=(",", ":")))
PY
