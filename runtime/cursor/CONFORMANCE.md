# Cursor adapter conformance

Cursor conforms through two surfaces:

- `.cursor/rules/compound-ai.mdc` supplies always-on prompt discipline.
- `dispatch.sh` wraps task dispatch with the shared generic shell adapter and
  sets `CAOS_RUNTIME_NAME=cursor`.

## Capability mapping

- Session routing: the wrapper calls the shared session router and injects the
  tier directive.
- Usage discipline: the wrapper calls the shared usage guard when a budget
  ceiling is supplied.
- Goal loop: the wrapper checks simple machine-readable completion conditions
  after dispatch.

GUI-only Cursor use is advisory. Shell dispatch is mechanically checked.
