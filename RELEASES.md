# Releases

Release notes for the Compound AI Operating Standards kit. Newest first.

## v3.0.1 (2026-06-19)

A coherence and provenance patch on the v3.0.0 co-owned release. No doctrine or
behavior change; this release makes the kit's own claims and tooling honest and
self-consistent for publication.

### Fixed

- **Provenance tooling now ships to adopters.** `reference-impl/scripts/verify-integrity.py`
  and `verify-origin.py` are stdlib-only and now ship in BOTH editions (they
  were excluded from the Individual tree while 15+ docs told adopters to run
  them). A planted-fixture self-test runs the verifier against the shipped
  manifest and asserts both a clean pass and a tamper-failure.
- **HANDOFF roster drift gate.** `HANDOFF.md` listed two retired skills as live
  Tier-1. The roster is corrected and a new `check-handoff-skills.sh` gate
  (wired into `check-kit`) blocks future drift between the roster and the
  registry. The Individual derive now also strips the Team-only `team-router`
  from the roster so the editions stay coherent.
- **Changelog dedupe.** `_skills-index.md` carried two overlapping change
  summaries with a contradictory skill count; collapsed to one authoritative
  block reconciled against the skills on disk.
- **ccusage degradation is documented.** The usage ceiling runs on character
  estimation when `ccusage` is absent (fail-open, zero metered spend). Install
  guidance and a known-limit entry now state this plainly.
- **session-router singular term.** A heavy-routing term matched only its
  plural form; routing now uses one term source with consistent substring
  matching, covered by a new fixture.

### Changed

- **Honesty pass.** The 158x headline is reframed as an estimator-based,
  order-of-magnitude figure (no metered tokenizer read), and the docs state
  that hard-blocking enforcement is real on Claude Code while other runtimes
  honor the contract by prompt-prelude and wrapper (advisory, graceful
  degradation).
- **Scripted installers.** Cross-platform `install.sh` and `install.bat` for the
  Team edition (idiot-proof, mirror the reference Python installer) plus a lean
  `adoption/install.sh` for the Individual edition.
- **Quick-recap convention** added under `doctrine/conventions/`.
- **Edition-specific release zips** (`compound-ai-individual-vX.Y.Z.zip`,
  `compound-ai-team-vX.Y.Z.zip`); the two editions no longer overwrite one zip.
- **Denylist negative-space fix.** The shipped denylist files no longer carry a
  literal private workspace name; literal personal terms live only in the
  gitignored maintainer denylist, which the build-time scrub now also reads.

## v3.0.0 (2026-06-18)

Co-authored by **Cameron Sutcliff**
([cameronpsutcliff](https://github.com/cameronpsutcliff)) and **Joshua
Sutcliff** ([joshuadsutcliff](https://github.com/joshuadsutcliff)).

Version 3 is the co-owned merge of two complementary systems into one kit. It
is a SemVer-major release: re-read before adopting.

### Headline changes

- **Co-owned merge.** Cameron's solo edition contributed the portable doctrine,
  the tiered context model, and the skill library. Joshua's reference runtime
  contributed hook-level enforcement. The two systems are now one kit, owned by
  both authors, with cross-repo skills consolidated into unified named skills
  (`memory`, `delegation`, `review`) that sub-route by intent.

- **Enforced runtime adopted from the collaborator.** The Claude Code runtime
  vendored under `runtime/claude-code/` comes from Joshua's System B reference
  ([brass458/claude-config-public](https://github.com/brass458/claude-config-public)),
  hardened by a real multi-agent operating incident. It wires usage ceilings
  and tier routing to live `PreToolUse` and `UserPromptSubmit` hooks, so the
  discipline is a mechanical hard block, not a polite request.

- **Blocking CI gates.** Enforcement moved from prose to code. The gates under
  `enforcement/` block real violations, including a planted-fixture self-test
  that proves the checks fire. Run them with `enforcement/bin/check-kit.sh`.

- **Doctrine, capabilities, runtime architecture.** Shared behavior was lifted
  out of both systems into a runtime-agnostic capability model. Doctrine
  (`doctrine/`) is the portable core any agent honors. Capabilities
  (`capabilities/`) define the contracts every adapter must satisfy. Runtime
  adapters (`runtime/`) implement those contracts per agent, with none
  privileged: Claude Code hard-enforces through hooks while Codex, Cursor, and
  the generic adapter honor the same contract. The enforcement Joshua proved on
  one runtime is now a contract any agent can satisfy.

- **The 158x proof.** Loading the full operating reference at session start
  costs about 158.4x the context this kit loads at session start, because the
  kit routes to one short procedure on demand instead of keeping the whole
  reference resident. The token counts are character estimates (bytes / 4), not
  a tokenizer count, so the figure is order-of-magnitude. No metered API and no
  model call: pure shell, reproducible on a bare laptop with
  `bash proof/session-start-benchmark/measure.sh`. The ratio is
  estimator-independent because both sets use the same divisor.

### Compatibility

SemVer-major signals a re-read-before-adopting boundary. The doctrine and
capability contracts apply with no runtime dependency. The enforced Claude Code
runtime is wired and ready: its hooks (usage-guard, session-router) are vendored
under Apache-2.0, adapted from Joshua Sutcliff's public claude-config
(github.com/joshuadsutcliff), and credited in `runtime/claude-code/NOTICE`.

### Attribution

`Compound AI Operating Standards by Cameron Sutcliff and Joshua Sutcliff`.
Documentation and data under CC BY 4.0, originally authored code and the
vendored enforced-runtime hooks under Apache 2.0. See `LICENSE` and `NOTICE`.

### Prior versions

- v2.7.0: Cameron Sutcliff solo edition (CAOS), prose-only enforcement.
