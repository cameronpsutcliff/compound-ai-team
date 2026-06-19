#!/usr/bin/env bash
set -u

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
STANDARDS_DIR="$(cd "$SCRIPT_DIR/../.." && pwd)"
FRAGMENT="$STANDARDS_DIR/runtime/claude-code/settings.fragment.json"
TARGET="${CLAUDE_SETTINGS:-${HOME:-}/.claude/settings.json}"
MODE="dry-run"
TARGET_EXPLICIT="0"

usage() {
  cat <<'EOF'
Usage: install-adapter.sh [--dry-run|--install] [--settings PATH] [--fragment PATH]

--dry-run        Print the merged Claude settings JSON. Default.
--install        Write the merged JSON to the settings path after a backup.
--settings PATH  Settings file to merge into.
--fragment PATH  Runtime settings fragment to merge.
EOF
}

while [ "$#" -gt 0 ]; do
  case "$1" in
    --dry-run)
      MODE="dry-run"
      shift
      ;;
    --install)
      MODE="install"
      shift
      ;;
    --settings)
      TARGET="${2:-}"
      TARGET_EXPLICIT="1"
      shift 2
      ;;
    --fragment)
      FRAGMENT="${2:-}"
      shift 2
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      printf 'install-adapter: unknown argument: %s\n' "$1" >&2
      usage >&2
      exit 2
      ;;
  esac
done

if [ ! -f "$FRAGMENT" ]; then
  printf 'install-adapter: missing settings fragment: %s\n' "$FRAGMENT" >&2
  exit 1
fi

if ! command -v python3 >/dev/null 2>&1; then
  printf 'install-adapter: python3 required for JSON merge\n' >&2
  exit 1
fi

merged="$(mktemp "${TMPDIR:-/tmp}/claude-settings-merge.XXXXXX")"
trap 'rm -f "$merged"' EXIT

BASE_TARGET="$TARGET"
if [ "$MODE" = "dry-run" ] && [ "$TARGET_EXPLICIT" = "0" ]; then
  BASE_TARGET=""
fi

python3 - "$BASE_TARGET" "$FRAGMENT" > "$merged" <<'PY'
import json
import os
import sys

target, fragment = sys.argv[1], sys.argv[2]

def load_json(path, default):
    if not path or not os.path.exists(path):
        return default
    with open(path, "r", encoding="utf-8") as handle:
        return json.load(handle)

base = load_json(target, {})
patch = load_json(fragment, {})
if not isinstance(base, dict) or not isinstance(patch, dict):
    raise SystemExit("settings and fragment must be JSON objects")

merged = dict(base)
hooks = dict(merged.get("hooks", {}))
for event, entries in patch.get("hooks", {}).items():
    hooks[event] = entries
merged["hooks"] = hooks

for key, value in patch.items():
    if key.startswith("_"):
        continue
    if key != "hooks":
        merged[key] = value

print(json.dumps(merged, indent=2, sort_keys=True))
PY

case "$MODE" in
  dry-run)
    if [ "$TARGET_EXPLICIT" = "1" ]; then
      printf 'DRY RUN: merged Claude settings for %s\n' "$TARGET"
    else
      printf 'DRY RUN: merged Claude settings fragment with empty base\n'
    fi
    cat "$merged"
    ;;
  install)
    mkdir -p "$(dirname "$TARGET")"
    if [ -f "$TARGET" ]; then
      cp "$TARGET" "$TARGET.bak"
      printf 'Backup written: %s.bak\n' "$TARGET"
    fi
    cp "$merged" "$TARGET"
    printf 'Installed merged Claude settings: %s\n' "$TARGET"
    ;;
esac
