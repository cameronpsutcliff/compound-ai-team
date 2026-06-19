# Codex adapter conformance

Codex conforms through two surfaces:

- `AGENTS.md` supplies native runtime directives for manual or hosted Codex use.
- `dispatch.sh` wraps task dispatch with the shared generic shell adapter and
  sets `CAOS_RUNTIME_NAME=codex`.

## Capability mapping

- Session routing: `dispatch.sh` calls `runtime/claude-code/hooks/session-router.sh`
  and injects the resulting tier directive into the prompt.
- Usage discipline: `dispatch.sh` calls `runtime/claude-code/hooks/usage-guard.sh`
  before execution when a budget ceiling is supplied.
- Goal loop: `dispatch.sh` evaluates simple machine-readable completion
  conditions after execution and halts when unmet.

This adapter has no special authority relative to other runtimes.
