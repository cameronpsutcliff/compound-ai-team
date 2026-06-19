# Enforcement provenance

This kit has two authors and two lineages. This note records where the enforced
runtime came from and why it works the way it does, in neutral terms. It carries
no private paths, no vault names, and no personal framing.

## Two systems, one kit

- The **doctrine** (Layer A) is the portable Compound AI operating standard:
  vendor-neutral prose and data covering routing, token economics, goal and loop
  contracts, provenance, and memory. Authored by Cameron Sutcliff.
- The **enforced runtime** (Layer B) is a hook-enforced Claude Code runtime that
  already implements the controls the doctrine could only advise. Authored by
  Joshua Sutcliff. Public reference: `github.com/brass458/claude-config-public`.

The doctrine describes what good operation is. The runtime makes parts of it
mechanical. The two were built independently and merged into this co-owned kit.

## Why the enforcement layer exists

The runtime was hardened by a real operating incident. A multi-agent run was
allowed to fan out without a usage ceiling and ran its budget to exhaustion
before it was stopped. The lesson was direct: a budget limit that an agent is
merely asked to honor is not a limit. The response was to add a real control,
`usage-guard.sh`, that blocks delegation and workflow spawns at a configurable
usage threshold rather than trusting the agent to stop on its own.

That history is why this kit can claim incident-hardened enforcement rather than
an untested design. The control exists because the failure it prevents actually
happened.

## What the runtime enforces

- `usage-guard.sh` (PreToolUse): denies conductor-model subagents that are not on
  a cheap worker tier, and blocks `Agent` and `Workflow` spawns once a usage-cap
  proxy crosses a configurable block threshold. It fails open: a broken probe,
  stale cache, or parse error yields no block, so it never stops legitimate work.
- `session-router.sh` (UserPromptSubmit): classifies each prompt LIGHT, MEDIUM,
  or HEAVY and injects a routing prior. It is behavioral only. A documented hard
  limit is that a hook cannot change the main-loop model or effort.
- `phased-review.js`: a capped fan-out workflow that checks usage between waves
  and halts with partial state rather than overrunning.

Thresholds are tunable through environment variables and a gitignored
`settings.local.json`. The defaults are protective, not draconian. See
`docs/known-limits.md` for what stays advisory at runtime.

## License boundary

The enforced-runtime hooks (usage-guard, session-router) are vendored under
Apache-2.0, adapted from Joshua Sutcliff's public claude-config
(github.com/joshuadsutcliff) and credited in `runtime/claude-code/NOTICE`. The
doctrine, the originally authored CI gates, and this provenance note do not
depend on the runtime and proceed independently.
