# Generic adapter conformance

This runtime is the graceful-degradation adapter for any agent, including
GUI-only tools.

## Mechanism

- `prompt-prelude.md` injects session-routing, usage-discipline, goal-loop, and
  result-shape instructions into any agent prompt.
- `dispatch.sh` is an optional shell wrapper that reads the
  `dispatch(task) -> result` JSON shape.
- The wrapper calls the shared `session-router.sh` before dispatch.
- The wrapper calls the shared `usage-guard.sh` before dispatch when
  `budget.pct_ceiling` is supplied.
- The wrapper performs a minimal post-dispatch goal check for machine-readable
  completion conditions.

## Contract mapping

- CT-AC-1: `dispatch.sh` always returns `id`, `status`, and `output`.
- CT-AC-2: `budget.pct_ceiling=0` returns `status=halted`.
- CT-AC-3: missing GoalContract skips goal evaluation without error.
- CT-AC-4: unmet machine-readable completion conditions return `halted`.
- CT-AC-5: routing context is injected into the dispatched prompt.
- CT-AC-6: empty or unparsable task JSON returns `status=error`.

When only `prompt-prelude.md` is used, conformance is advisory rather than
mechanically enforced.
