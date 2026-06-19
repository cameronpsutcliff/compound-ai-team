# Compound AI Operating Standards
## The Six-Layer Standard

Version: v3.0.2
Authors: Cameron Sutcliff (cameronpsutcliff), Joshua Sutcliff (joshuadsutcliff)

---

Every capability in this kit lives in exactly one of six layers. A forker on a
bare laptop needs to understand only one rule: you may stop at any layer. The
layers below it still apply and the Standard still holds.

The first two layers are vendor-neutral and portable. The remaining layers add
mechanism: real adapters, real enforcement, proof, and tooling. The dependency
fence is enforced by `enforcement/bin/check-portability.sh`: no Python outside
`reference-impl/`, no shell or JS outside `runtime/` and `enforcement/`.

---

## Layer 1 - Doctrine (portable, vendor-neutral)

**What:** Everything under `doctrine/`. Plain Markdown and YAML.

**Dependencies:** None. No Python, no Node, no Claude Code, no npm.

Includes:
- Tiered context model (`tiers/`: tier0 through tier3 discipline)
- The consolidated skills (`skills/`, merged Cameron + Josh, by tier)
- Verifiable finish-line primitives (`contracts/`: goal-contract, loop-spec)
- Conventions (`conventions/`: trigger-registry, file caps, skill-author rule)

This layer is advisory on its own: it describes what good operation is. Layers 2
and 3 turn the advice into a contract and then into mechanism.

---

## Layer 2 - Capabilities (runtime-agnostic)

**What:** Everything under `capabilities/`. Plain Markdown. The universal
capability model that lets any agent plug in.

**Dependencies:** None.

Each capability is defined once as a contract, an input and output shape, a
reference implementation, and a conformance test:
- `adapter-contract.md`: the shared `dispatch(task) -> result` interface and the
  capability hook order. Start here. Carries no runtime internals.
- `usage-discipline.md`: a tunable, fail-open spend and work ceiling.
- `session-routing.md`: LIGHT/MEDIUM/HEAVY tier classification.
- `goal-loop.md`: verifiable finish-line + budget ceiling + no-progress halt.

A runtime is conformant when the numbered tests (CT-AC-*, CT-UD-*, CT-SR-*,
CT-GL-*) pass. This is the only layer besides Doctrine that may be called
vendor-neutral.

---

## Layer 3 - Runtime adapters (real per-runtime mechanism)

**What:** Everything under `runtime/`. One subdirectory per agent runtime. None
privileged; every runtime gets a real adapter.

| Adapter | Mechanism | Enforcement |
|---|---|---|
| `claude-code/` | `PreToolUse` + `UserPromptSubmit` hooks, agents, commands | Full hard block |
| `codex/` | `AGENTS.md` directives + dispatch wrapper | Honor + wrapper checks |
| `cursor/` | rules file + dispatch wrapper | Honor + wrapper checks |
| `generic/` | prompt prelude + optional shell wrapper | Honor (graceful degradation) |

The Claude Code adapter is the richest because hooks let it hard-block: the
usage ceiling and tier router are mechanical, not promises. The generic adapter
is the fallback so a brand-new or GUI-only agent still gets the capabilities by
honor. The kit works with one agent and scales to N with no structural change.

Status: the enforced-runtime hooks (usage-guard, session-router) are vendored
under Apache-2.0, adapted from Joshua Sutcliff's public claude-config
(github.com/joshuadsutcliff), and credited in `runtime/claude-code/NOTICE`.

---

## Layer 4 - Enforcement (CI gates and self-test)

**What:** Everything under `enforcement/`. Small portable scripts: bash plus
python3.

Includes:
- `bin/`: the doctrine gates, orchestrated by `check-kit.sh`.
- `.github/workflows/`: CI.
- `tests/`: the planted-fixture self-test that proves the gates block real
  violations.
- `hooks/`: git hooks (pre-commit, post-session).

All gate thresholds live in `enforcement-rules.yaml` (single source of truth;
never duplicated in scripts).

---

## Layer 5 - Proof

**What:** Everything under `proof/`. Net-positive evidence.

Includes the session-start benchmark (a character-estimate ratio of roughly two
orders of magnitude, pure shell, no metered API), delegation economics, and
loop-adoption evidence. The token counts are heuristic estimates (bytes / 4), so
the result is order-of-magnitude, not a model-exact byte count. The exact
current numbers are regenerated from the tree into
`proof/session-start-benchmark/results.md` (never hand-typed, so they cannot
drift); a reviewer can re-run `measure.sh` on a bare laptop and reproduce them.

---

## Layer 6 - Reference implementation and adoption

**What:** `reference-impl/` (maintainer Python tooling) and `adoption/` (the
drop-in adoption protocol).

`reference-impl/` is the only place Python lives: provenance verification,
manifest build, derive, and the skill-creator scaffold. It is excluded from the
Individual edition release zip (lean adopter payload) and included in the Team
edition. `adoption/` carries `ADOPT.md`, the installer, and `INSTALL.md`.

---

## The one rule for forkers

> "Everything under `doctrine/` and `capabilities/` is portable: plain Markdown
> and YAML, readable with no tools. `runtime/` holds the per-agent adapters,
> `enforcement/` holds the CI gates, `proof/` holds the evidence, and
> `reference-impl/` holds optional Python tooling. You may ignore the mechanical
> layers and the portable layers still apply."

---

## What the CI gates enforce

Seven gates orchestrated by `enforcement/bin/check-kit.sh` (thresholds in
`enforcement-rules.yaml`, the single source of truth):

| Gate script | Enforces |
|---|---|
| `enforcement/bin/check-line-caps.sh` | Pointer Markdown files at or under 100 lines |
| `enforcement/bin/check-tier-discipline.sh` | tier0 never references tier-2/tier-3 |
| `enforcement/bin/check-counts.sh` | Skill count derived, never hand-typed; matches index and registry |
| `enforcement/bin/check-registry-coherence.sh` | Every registry pointer resolves and every SKILL.md is registered |
| `enforcement/bin/check-handoff-skills.sh` | HANDOFF.md lists the live Tier 1 skills, no stale or duplicate entries |
| `enforcement/bin/check-runtime-wiring.sh` | settings.fragment.json wires all hook events with resolving paths and adapters |

Run them all with `enforcement/bin/check-kit.sh`. See `docs/known-limits.md` for
what is advisory rather than mechanically enforced.

---

## Version history

- v3.0.2 (2026-06-19): pre-publication hardening. An executive one-pager, a
  README that leads with the thesis (the 158x figure is now generated, not
  hand-typed, so it cannot drift), real captured hook-block evidence in place of
  an illustration, clone-safe proof scripts, the CI workflow relocated to the
  repo root so it actually runs, a seventh gate documented, provenance pointed
  at a single canonical handle, and assorted version and reference fixes. No
  behavior change to the doctrine.
- v3.0.1 (2026-06-19): coherence and provenance remediation. Provenance
  verifiers now ship in both editions with a planted-fixture self-test; a
  HANDOFF roster gate, a deduped changelog, ccusage degradation docs, a
  session-router singular-term fix, a quick-recap convention, scripted
  installers, edition-specific zips, and an estimator-based reframing of the
  158x and non-Claude enforcement claims. No behavior change to the doctrine.
- v3.0.0 (2026-06-18): co-owned consolidation. Six-layer architecture, the
  runtime-agnostic capability and adapter model, cross-repo skill-merge
  (memory, delegation, review), goal-parity, vendored runtime/claude-code hooks.
  SemVer-major signals a re-read-before-adopting boundary.
- v2.7.0: Cameron Sutcliff solo edition (CAOS), prose-only enforcement.
