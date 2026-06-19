# Compound AI Operating Standards v3.0.0

**A co-owned operating kit that turns any capable AI coding agent into a
compounding work surface.**

By **Cameron Sutcliff** ([cameronpsutcliff](https://github.com/cameronpsutcliff))
and **Joshua Sutcliff** ([joshuadsutcliff](https://github.com/joshuadsutcliff)).

Most AI work resets every session: the operator re-explains the project, the
agent bulk-loads everything it might need, and the cost rises while the value
stays flat. This kit makes the work compound instead. It ships a portable
operating doctrine, a runtime-agnostic capability model that any agent can plug
into, and a real enforcement layer that blocks violations rather than asking
nicely.

**Canonical site:** [cameronsutcliff.com/compound-ai](https://cameronsutcliff.com/compound-ai)
**Source repo:** [github.com/cameronpsutcliff/compound-ai-operating-standards](https://github.com/cameronpsutcliff/compound-ai-operating-standards)

---

## The 158x proof point

Loading the full operating reference at session start costs about **158.4x**
the context this kit loads at session start. The kit reaches the same
capability by routing to one short procedure on demand instead of keeping the
whole reference resident.

| Set | Files | Est. tokens |
|---|---:|---:|
| Naive full reference (resident) | 135 | 202,207 |
| Kit session-start (tier-0 always-load) | 2 | 1,276 |
| **Ratio (naive / kit)** | | **158.4x** |

No metered API, no model call. Pure shell, reproducible on a bare laptop:
`bash proof/session-start-benchmark/measure.sh`. The ratio is
estimator-independent because both sets use the same divisor. See `proof/`.

## The six-layer architecture

The kit is organized as six layers. You may stop at any layer; every layer
below the one you stop at still applies and the Standard still holds.

| # | Layer | Path | What it gives you |
|---|---|---|---|
| 1 | **Doctrine** | `doctrine/` | Portable core any agent honors: tiered context, skills, goal and loop contracts, conventions. Plain Markdown and YAML, no tools. |
| 2 | **Capabilities** | `capabilities/` | The runtime-agnostic capability model. Four contracts (`adapter-contract`, `usage-discipline`, `session-routing`, `goal-loop`) that define what any adapter must guarantee. |
| 3 | **Runtime adapters** | `runtime/` | Real per-runtime adapters, none privileged: `claude-code` (full hook enforcement), `codex`, `cursor`, `generic` (the graceful-degradation path for any agent). |
| 4 | **Enforcement** | `enforcement/` | CI gates, workflows, and a planted-fixture self-test that block real violations. Run `enforcement/bin/check-kit.sh`. |
| 5 | **Proof** | `proof/` | The 158x benchmark and other net-positive evidence. |
| 6 | **Reference and adoption** | `reference-impl/`, `adoption/` | Maintainer Python tooling and the drop-in adoption protocol. |

See [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md) for the full picture: how the
capability and adapter model lets any agent plug in, and how Claude Code hard
enforces via hooks while any other agent honors the same contract through the
generic adapter.

## Any agent, none privileged

The capability layer is runtime-agnostic. A capability is defined once in
`capabilities/<name>.md` as a contract, an input and output shape, a reference
implementation, and a conformance test. Each runtime in `runtime/<agent>/`
implements the same `dispatch(task) -> result` contract with its own mechanism:

- **Claude Code** wires the capabilities to real `PreToolUse` and
  `UserPromptSubmit` hooks, so usage ceilings and tier routing are mechanical
  hard blocks. This is the richest adapter.
- **Codex** and **Cursor** apply the same checks through their directive files
  plus a dispatch wrapper.
- **Generic** injects the discipline as a prompt prelude with an optional shell
  wrapper, so a brand-new or GUI-only agent still honors the contract. This is
  graceful degradation: the kit works with one agent and scales to N with no
  structural change.

## Install

### Option A: adopt the doctrine into an existing project

```bash
```

Hand the agent `adoption/ADOPT.md` and run the `adoption-captain` skill. The
doctrine and the capability contracts apply with no runtime dependency. See
`adoption/INSTALL.md` for the multi-agent walkthrough.

### Option B: add the enforced Claude Code runtime

The `runtime/claude-code/` module vendors the enforced-runtime hooks
(usage-guard, session-router) under Apache-2.0, adapted from Joshua Sutcliff's
public claude-config (github.com/joshuadsutcliff) and credited in
`runtime/claude-code/NOTICE`. Wire the runtime by following the adapter docs.

## The merge story

Version 3 is a true co-owned merge of two complementary systems. Cameron's
solo edition contributed the portable doctrine, the tiered context model, and
the skill library. Joshua's System B reference runtime
([github.com/brass458/claude-config-public](https://github.com/brass458/claude-config-public)),
hardened by a real multi-agent operating incident, contributed the hook-level
enforcement now living in `runtime/claude-code/`. The consolidation lifted the
shared behavior out of both into the runtime-agnostic `capabilities/` layer, so
the enforcement Joshua proved on Claude Code is now a contract any agent can
satisfy. Cross-repo skills were merged into unified named skills (`memory`,
`delegation`, `review`) with intelligent sub-routing. See
[docs/ARCHITECTURE.md](docs/ARCHITECTURE.md).

## Multi-agent orchestration

Multi-agent coordination ships as distilled guidance, not implementation. The
Field Guide (`docs/FIELD-GUIDE.md`) covers the patterns in its panel chapters:
the agent interface contract, multi-agent coordination, and the planning and
review panels. These read as operating guidance for running your own panels.
The kit does not ship any sealed-panel protocol mechanics or orchestration
secret sauce.

## Honest posture

This is an early operating standard with a real enforced reference runtime, not
a battle-tested mass-adopted product. Public adoption is low; internal usage is
real. The enforcement story is incident-hardened on the runtime side. The kit
states what the hooks block, what stays advisory, and what the human still
controls, rather than overclaiming. See `docs/known-limits.md`.

## License

Co-owned by its two authors and dual licensed:

- **Documentation and data:** CC BY 4.0
- **Originally authored code:** Apache 2.0
- **Vendored enforced-runtime hooks** (usage-guard, session-router): Apache 2.0,
  adapted from Joshua Sutcliff's public claude-config
  (github.com/joshuadsutcliff), credited in `runtime/claude-code/NOTICE`.

Attribution:
`Compound AI Operating Standards by Cameron Sutcliff and Joshua Sutcliff`

See `LICENSE` and `NOTICE` for full terms.
