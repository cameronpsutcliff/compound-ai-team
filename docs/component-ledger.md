# Component Ledger
# Compound AI Operating Standards v3.0.2
# Maintained by: Cameron Sutcliff + Joshua Sutcliff

Every component from both contributing systems is evaluated here against
the five-part standalone-skill rule. The ledger drives the registry and
index; `check-counts.sh` derives the active count from the filesystem, not
from this file.

## The five-part rule

A capability earns a standalone `SKILL.md` if and only if it has:

1. A distinct routable trigger that would not fire on another active skill.
2. A distinct procedure non-obvious enough that a capable agent gets it wrong
   without it.
3. Independent reuse across more than one project type.
4. Pointer-cap and reference-on-demand compliance (under 100 lines, target 80).
5. A proof note or scheduled measurement. Fail (5) twice: cut. Fail (3): demote
   to a section inside a related skill's reference.

## Status codes

| Code | Meaning |
|---|---|
| ACTIVE | Standalone SKILL.md; passes all five parts. |
| DEMOTED-CI | Moved to CI gate; no standalone SKILL.md. |
| MERGED | Content absorbed into another skill's reference. |
| REFERENCE-ONLY | Exists as a reference doc, not a routable skill. |
| VENDORED | Vendored under Apache-2.0; credited in `runtime/claude-code/NOTICE`. |
| FOLDED | Runnable source kept as a local compatibility implementation; portable doctrine folded into a skill. |
| EXTERNAL | Referenced, not vendored; install separately. |

---

## System A: CAOS Tier 1 Skills

### request-router

| Field | Value |
|---|---|
| Status | ACTIVE |
| Location | `doctrine/skills/request-router/SKILL.md` |
| Rule (1) | Distinct trigger: session start, routing intent. No other skill routes. |
| Rule (2) | Routing procedure, mode table, bootstrap distinction, panel offer judgment. Non-trivial. |
| Rule (3) | Universal across every project type. |
| Rule (4) | 57 lines as of v3.0.0. Compliant. |
| Rule (5) | Session-start usage is measurable; every session calls it. |
| Notes | Core router; reads trigger-registry.yaml. session-router.sh is the hook delivery. |

### goal-runner

| Field | Value |
|---|---|
| Status | ACTIVE |
| Location | `doctrine/skills/goal-runner/SKILL.md` |
| Rule (1) | Distinct: "keep going until", completion-condition language. No overlap. |
| Rule (2) | Durable goal contract, validation loop, slow lanes, memory closeout. |
| Rule (3) | Universal. Any project with multi-step durable work. |
| Rule (4) | Compliant. |
| Rule (5) | Operator preservation list; real internal production usage confirmed. |
| Notes | Keeper. Verbatim from v2.7.0. |

### context-loader

| Field | Value |
|---|---|
| Status | MERGED (redirect stub) |
| Location | `doctrine/skills/context-loader/SKILL.md` (stub) |
| Decision | Folded into `memory` as the resume mode in the skill-merge. |
| Rule (1) | Triggers ("load context", "start session") now route to `memory`. |
| Rule (3) | Reuse preserved inside memory; the tier discipline stays in `doctrine/tiers/`. |
| Notes | Procedure now at `doctrine/skills/memory/reference/resume.md`. |

### token-economist

| Field | Value |
|---|---|
| Status | ACTIVE |
| Location | `doctrine/skills/token-economist/SKILL.md` |
| Rule (1) | Distinct: "token audit", "optimize context", "reduce cost". |
| Rule (2) | Budget policy, load-minimum-tiers doctrine, context pruning procedure. |
| Rule (3) | Universal. |
| Rule (4) | Compliant. |
| Rule (5) | Retained as doctrine backing usage-guard.sh; the hook is the enforcement path. |
| Notes | Doctrine, not the enforcement path. usage-guard.sh replaces it as runtime enforcer. |

### engagement-bootstrap

| Field | Value |
|---|---|
| Status | ACTIVE |
| Location | `doctrine/skills/engagement-bootstrap/SKILL.md` |
| Rule (1) | "New project", "bootstrap this". Distinct from adoption-captain. |
| Rule (2) | Fresh-project scaffold procedure. Gets it wrong without the new-vs-existing boundary. |
| Rule (3) | Any new project engagement. |
| Rule (4) | Compliant. |
| Rule (5) | Bootstrap usage measurable per project init. |
| Notes | Safety boundary with adoption-captain kept; panel concurred adoption-captain/engagement-bootstrap split is a safety boundary (SKILL.md says "Do NOT use engagement-bootstrap on an existing project"). |

### quality-gate

| Field | Value |
|---|---|
| Status | ACTIVE |
| Location | `doctrine/skills/quality-gate/SKILL.md` |
| Rule (1) | "Quality check", "validate output", "is this ready". Distinct from release-captain's ship gate. |
| Rule (2) | Generic deliverable quality procedure, so-what test, rendered contract check. |
| Rule (3) | Universal. |
| Rule (4) | Compliant. |
| Rule (5) | Every deliverable quality check invokes it. |
| Notes | Pairs with release-captain as the generic-before-release-specific pipeline stage. |

### pattern-promoter

| Field | Value |
|---|---|
| Status | MERGED (redirect stub) |
| Location | `doctrine/skills/pattern-promoter/SKILL.md` (stub) |
| Decision | Folded into `memory` as the preserve mode (promotion path) in the skill-merge. |
| Rule (1) | Triggers ("promote this pattern", "save this lesson") now route to `memory`. |
| Rule (2) | ACE-scored promotion format (helpful=N / harmful=N) carried into preserve.md. |
| Notes | Procedure now at `doctrine/skills/memory/reference/preserve.md` (Promotion path). |

### agent-panel-planning

| Field | Value |
|---|---|
| Status | ACTIVE |
| Location | `doctrine/skills/agent-panel-planning/SKILL.md` |
| Rule (1) | Pre-execution planning phase triggers. Distinct from agent-panel-review post-execution. |
| Rule (2) | Converged plan artifact, panel assignment, split procedure. |
| Rule (3) | Any multi-agent or high-stakes planning task. |
| Rule (4) | Compliant. |
| Rule (5) | Panel usage measurable. |
| Notes | Kept separate from agent-panel-review: distinct lifecycle phases and artifacts. Merge withdrawn under Kiro critique. |

### agent-panel-review

| Field | Value |
|---|---|
| Status | ACTIVE |
| Location | `doctrine/skills/agent-panel-review/SKILL.md` |
| Rule (1) | Post-execution review triggers. Distinct from planning. |
| Rule (2) | Sealed critique artifact, multi-perspective review, convergence procedure. |
| Rule (3) | Any multi-agent or high-stakes review task. |
| Rule (4) | Compliant. |
| Rule (5) | Panel review usage measurable. |
| Notes | Kept separate from agent-panel-planning: post-execution vs pre-execution, sealed critique vs converged plan. |

### release-captain

| Field | Value |
|---|---|
| Status | ACTIVE |
| Location | `doctrine/skills/release-captain/SKILL.md` |
| Rule (1) | "Ship gate", "release captain", "pre-release check". Distinct from quality-gate. |
| Rule (2) | Ten-step ship gate procedure; cross-cutting scope (deliverable + metadata). |
| Rule (3) | Any project with public releases. |
| Rule (4) | Compliant. |
| Rule (5) | Used on every release; origin: v2.3.1 incident. |
| Notes | Now carries provenance-check procedure in reference/provenance-verification.md. |

### adoption-captain

| Field | Value |
|---|---|
| Status | ACTIVE |
| Location | `doctrine/skills/adoption-captain/SKILL.md` |
| Rule (1) | "Adopt this kit", "install into my current repo". Distinct from engagement-bootstrap. |
| Rule (2) | Existing-project install procedure; memory commit; behavioral overlay. Critical: do not overwrite existing files. |
| Rule (3) | Any existing-project CAOS adoption. |
| Rule (4) | Compliant. |
| Rule (5) | Adoption usage measurable. |
| Notes | Safety boundary preserved: SKILL.md explicitly prohibits engagement-bootstrap on existing projects. |

### trigger-indexer

| Field | Value |
|---|---|
| Status | DEMOTED-CI |
| Location | `doctrine/skills/trigger-indexer/` (directory kept; no active SKILL.md in registry) |
| Rule (1) | FAILS: trigger phrases ("reindex triggers", "rebuild trigger registry") are maintenance actions, not session work. CI runs this automatically on every push. |
| Rule (2) | Procedure absorbed into registry-maintenance.md and check-registry-coherence.sh. |
| Rule (3) | Not independently reusable across projects; it is a repo-level CI concern. |
| Rule (4) | N/A. |
| Rule (5) | N/A. |
| Notes | Demoted to CI gate (check-registry-coherence.sh) + request-router reference (registry-maintenance.md). Triggers removed from registry. registry-schema.md reference file retained at original location. |

### provenance-check

| Field | Value |
|---|---|
| Status | MERGED |
| Location | Absorbed into `doctrine/skills/release-captain/reference/provenance-verification.md` |
| Rule (1) | FAILS: "verify origin" fires only on release or audit scenarios already handled by release-captain. No independent session-time trigger. |
| Rule (2) | Procedure merged into release-captain reference. The verify-integrity and verify-origin scripts are still called; the skill wrapper was redundant. |
| Rule (3) | FAILS: reuse is exclusively release-time. |
| Rule (4) | N/A. |
| Rule (5) | N/A. |
| Notes | release-captain Step 3 now points to reference/provenance-verification.md. "verify origin" / "check provenance" triggers removed from registry. |

---

## System A: CAOS Tier 2 Skills

### parallel-lens-synthesis

| Field | Value |
|---|---|
| Status | ACTIVE |
| Location | `doctrine/skills/parallel-lens-synthesis/SKILL.md` |
| Rule (1) | "Multiple perspectives", "steelman", "red-team". Distinct. |
| Rule (2) | Parallel lens procedure, ensemble framing, synthesis output format. |
| Rule (3) | Universal reasoning task. |
| Rule (4) | Compliant. |
| Rule (5) | Widely invoked in decision and review sessions. |

### consequence-simulation

| Field | Value |
|---|---|
| Status | ACTIVE |
| Location | `doctrine/skills/consequence-simulation/SKILL.md` |
| Rule (1) | "What could go wrong", "premortem", "simulate". Distinct. |
| Rule (2) | Pre-mortem procedure, second-order effects, failure mode enumeration. |
| Rule (3) | Universal. Any decision or design task. |
| Rule (4) | Compliant. |
| Rule (5) | Active in planning and strategy sessions. |

### cross-domain-translation

| Field | Value |
|---|---|
| Status | ACTIVE |
| Location | `doctrine/skills/cross-domain-translation/SKILL.md` |
| Rule (1) | "Explain to", "translate for", "exec summary". Distinct. |
| Rule (2) | Audience-adaptive translation procedure. |
| Rule (3) | Universal. Any communication task. |
| Rule (4) | Compliant. |
| Rule (5) | Active in cross-functional communication tasks. |

### convergence-detection

| Field | Value |
|---|---|
| Status | ACTIVE |
| Location | `doctrine/skills/convergence-detection/SKILL.md` |
| Rule (1) | "Common thread", "root cause", "what connects these". Distinct. |
| Rule (2) | Pattern-across-sources procedure, root cause chain. |
| Rule (3) | Universal. Any multi-source analysis task. |
| Rule (4) | Compliant. |
| Rule (5) | Active in synthesis and analysis sessions. |

### detached-judgment

| Field | Value |
|---|---|
| Status | ACTIVE |
| Location | `doctrine/skills/detached-judgment/SKILL.md` |
| Rule (1) | "Devil's advocate", "base rate", "calibrated". Distinct. |
| Rule (2) | De-bias procedure, evidence weighting, base-rate check. |
| Rule (3) | Universal. Any judgment or estimation task. |
| Rule (4) | Compliant. |
| Rule (5) | Active in high-stakes decision sessions. |

### simulation-to-action-bridge

| Field | Value |
|---|---|
| Status | ACTIVE |
| Location | `doctrine/skills/simulation-to-action-bridge/SKILL.md` |
| Rule (1) | "What should we do", "next steps", "turn into a plan". Distinct bridge from analysis to action. |
| Rule (2) | Simulation output to owned action list; OODA loop application. |
| Rule (3) | Universal. Post-simulation task. |
| Rule (4) | Compliant. |
| Rule (5) | Active following consequence-simulation or panel runs. |

### nod-protocol

| Field | Value |
|---|---|
| Status | ACTIVE |
| Location | `doctrine/skills/nod-protocol/SKILL.md` |
| Rule (1) | "Argue the opposite", "construct the opposite case", "NOD this". Distinct from detached-judgment. |
| Rule (2) | Negative-outcome defense procedure; adversarial construction. |
| Rule (3) | Universal. Any argument or proposal stress test. |
| Rule (4) | Compliant. |
| Rule (5) | Active in debate and critique sessions. |

### ultra-think

| Field | Value |
|---|---|
| Status | ACTIVE |
| Location | `doctrine/skills/ultra-think/SKILL.md` |
| Rule (1) | "Think deeply", "multi-angle", "ultra think". Distinct. |
| Rule (2) | Multi-angle deep reasoning procedure; explicit slow-thinking protocol. |
| Rule (3) | Universal. Any complex reasoning task. |
| Rule (4) | Compliant. |
| Rule (5) | Active in architecture and high-complexity sessions. |

### pressure-test

| Field | Value |
|---|---|
| Status | ACTIVE |
| Location | `doctrine/skills/pressure-test/SKILL.md` |
| Rule (1) | "Pressure test", "critique this", "rip this apart". Distinct. |
| Rule (2) | Structured critique procedure, failure-mode exhaustion. |
| Rule (3) | Universal. Any deliverable or design critique. |
| Rule (4) | Compliant. |
| Rule (5) | Active in review and pre-release sessions. |

### code-audit

| Field | Value |
|---|---|
| Status | ACTIVE |
| Location | `doctrine/skills/code-audit/SKILL.md` |
| Rule (1) | "Code audit", "dead code", "security review". Distinct. |
| Rule (2) | Code-specific audit procedure; dead code, dependency, security checks. |
| Rule (3) | Any project with code surface. |
| Rule (4) | Compliant. |
| Rule (5) | Active in software project sessions. |

### autoresearch

| Field | Value |
|---|---|
| Status | ACTIVE |
| Location | `doctrine/skills/autoresearch/SKILL.md` |
| Rule (1) | "Research this", "find sources", "investigate". Distinct. |
| Rule (2) | Structured research procedure, source validation. |
| Rule (3) | Universal. Any fact-finding task. |
| Rule (4) | Compliant. |
| Rule (5) | Active in research and investigation sessions. |

### skill-creator

| Field | Value |
|---|---|
| Status | ACTIVE |
| Location | `doctrine/skills/skill-creator/SKILL.md` |
| Rule (1) | "Build a skill", "create a skill", "extend the kit". Distinct. |
| Rule (2) | Skill authoring procedure, SKILL.md format, five-part rule application. |
| Rule (3) | Universal. Any kit extension task. |
| Rule (4) | Compliant. |
| Rule (5) | Active in kit maintenance and extension. |
| Notes | Python tooling relocated to reference-impl/skill-creator/; the SKILL.md pointer remains here. |

### viz

| Field | Value |
|---|---|
| Status | ACTIVE |
| Location | `doctrine/skills/viz/SKILL.md` |
| Rule (1) | "Viz", "what chart", "dashboard design". Distinct. |
| Rule (2) | Chart selection procedure, visualization critique. |
| Rule (3) | Any project with data or communication artifacts. |
| Rule (4) | Compliant. |
| Rule (5) | Active in data and communication sessions. |

### stakeholder-mapping

| Field | Value |
|---|---|
| Status | ACTIVE |
| Location | `doctrine/skills/stakeholder-mapping/SKILL.md` |
| Rule (1) | "Stakeholder map", "influence interest". Distinct. |
| Rule (2) | Influence/interest matrix procedure, stakeholder classification. |
| Rule (3) | Any project with human stakeholders. |
| Rule (4) | Compliant. |
| Rule (5) | Active in strategy and communication sessions. |

### loop-engineering

| Field | Value |
|---|---|
| Status | ACTIVE |
| Location | `doctrine/skills/loop-engineering/SKILL.md` |
| Rule (1) | "Build a loop", "recurring agent job", "loop spec". Distinct. |
| Rule (2) | Loop-spec contract, three hard stops, closed-loop default, maker/checker verification. |
| Rule (3) | Any project with recurring agent automation. |
| Rule (4) | Compliant. |
| Rule (5) | Operator preservation list. 26 live loop-spec.md instances on Mini (proof/loop-adoption-evidence). |
| Notes | Keeper. Verbatim from v2.7.0. |

---

## Skill-merge: Unified Skills (Cameron Sutcliff + Joshua Sutcliff)

Cross-repo merges. Each unifies both contributors' components into one
intent-routed skill (viz-routing pattern). Co-credited doctrine; portable.

### memory

| Field | Value |
|---|---|
| Status | ACTIVE |
| Location | `doctrine/skills/memory/SKILL.md` |
| Rule (1) | One trigger set for the memory lifecycle; sub-routes to capture/compress/preserve/resume/recall. No overlap with other active skills. |
| Rule (2) | Five distinct procedures (session-log template, routing decision, tier-load, search strategy) non-obvious without the references. |
| Rule (3) | Universal across every project with cross-session memory. |
| Rule (4) | SKILL.md under the cap; depth in `reference/`. |
| Rule (5) | Folds proven components: Josh compress/preserve/resume + Cameron context-loader/pattern-promoter/para-memory. |
| Notes | Absorbs retired context-loader (resume) and pattern-promoter (preserve, ACE format). |

### delegation

| Field | Value |
|---|---|
| Status | ACTIVE |
| Location | `doctrine/skills/delegation/SKILL.md` |
| Rule (1) | Routes work to an agent (distinct from request-router, which routes to a skill). |
| Rule (2) | Two-axis routing (capability/cost + autonomy), three worker contracts, model-tier table. Non-obvious. |
| Rule (3) | Universal across any multi-agent fleet, any provider. Generic, no fleet specifics. |
| Rule (4) | SKILL.md under the cap; depth in `reference/`. |
| Rule (5) | Folds Josh researcher/code-generator/tester + Cameron delegation doctrine + cost-tier routing. |
| Notes | Supersedes the fleet-specific `delegation.md` (now a redirect stub, still derive-excluded). |

---

## System B: Enforced Runtime Components (Joshua Sutcliff / joshuadsutcliff)

Reference: github.com/joshuadsutcliff

The enforced-runtime hooks (usage-guard, session-router) are vendored under
Apache-2.0, adapted from Joshua Sutcliff's public claude-config
(github.com/joshuadsutcliff) and credited in `runtime/claude-code/NOTICE`. The
runnable workflow, worker agents, and commands are kept as local compatibility
implementations whose portable doctrine is folded into the consolidated skills.
The doctrine surface (everything above) proceeds without the runtime.

### usage-guard.sh

| Field | Value |
|---|---|
| Status | VENDORED (Apache-2.0) |
| Location | `runtime/claude-code/hooks/usage-guard.sh` (vendored, Apache-2.0) |
| Rule (1) | PreToolUse hard block at usage-cap proxy. Distinct from token-economist doctrine. |
| Rule (2) | Four modes: pct/block/inform/refresh. Policy 1 denies non-cheap subagents always. Policy 2 blocks at cap threshold. Fail-open. |
| Rule (3) | Claude Code runtime. All Claude Code projects. |
| Rule (4) | N/A (hook, not a SKILL.md). |
| Rule (5) | Origin: real multi-agent burnout incident (incident-anchored). |
| Notes | Replaces token-economist as the runtime enforcement path. Fail-open: broken ccusage or parse failure yields pct=-1, never blocks. Budget probe is pluggable; defaults to ccusage when present, transcript-token estimate when absent. |

### session-router.sh

| Field | Value |
|---|---|
| Status | VENDORED (Apache-2.0) |
| Location | `runtime/claude-code/hooks/session-router.sh` (vendored, Apache-2.0) |
| Rule (1) | UserPromptSubmit regex classifier; injects LIGHT/MEDIUM/HEAVY tier priors. |
| Rule (2) | Reads trigger-registry.yaml as data source. Fail-open. |
| Rule (3) | Claude Code runtime. |
| Rule (4) | N/A. |
| Rule (5) | Incident-hardened; pairs with request-router doctrine. |
| Notes | Cannot change the main-loop model (documented hard limit). Data source: CAOS trigger-registry.yaml. Doctrine: request-router. |

### phased-review.js

| Field | Value |
|---|---|
| Status | FOLDED |
| Location | `runtime/claude-code/workflows/phased-review.js` (local compatibility implementation) |
| Rule (1) | Capped fan-out reference workflow; distinct from agent-panel-planning procedure. |
| Rule (2) | Wave-based review with usage checks between waves; resumable halt. |
| Rule (3) | Claude Code projects requiring multi-agent review with budget gates. |
| Rule (4) | N/A (workflow, not a SKILL.md). |
| Rule (5) | Reference implementation for Layer 4 delegation economics. |
| Notes | Exemplar for phased review with budget checkpoints. Its portable doctrine is folded (co-credited) into `agent-panel-review` as the phased-review mode (`reference/phased-review.md`); the runnable `.js` is a local compatibility implementation. |

### researcher / code-generator / tester (worker agents)

| Field | Value |
|---|---|
| Status | FOLDED |
| Location | `runtime/claude-code/agents/` |
| Rule (1) | Named cheap workers; pinned by usage-guard Policy 1. |
| Rule (2) | Scoped agent definitions for specific task types. |
| Rule (3) | Claude Code multi-agent projects. |
| Rule (4) | N/A. |
| Rule (5) | Policy 1 in usage-guard.sh references these by name. |
| Notes | Their portable contracts are folded (co-credited) into the `delegation` skill (research/generate/test worker references); the runnable agent files are not vendored here. |

### compress / preserve / resume (slash commands)

| Field | Value |
|---|---|
| Status | FOLDED |
| Location | `runtime/claude-code/commands/` |
| Rule (1) | Context compression, state preservation, session resume. Distinct triggers. |
| Rule (2) | Each command has a specific context-window management procedure. |
| Rule (3) | Claude Code sessions with long context requirements. |
| Rule (4) | N/A (commands, not SKILL.md). |
| Rule (5) | Shipped in reference repo; usage validated. |
| Notes | Their portable procedures are folded (co-credited) into the `memory` skill (compress/preserve/resume modes); the runnable command files are not vendored here. |

### settings.example.json

| Field | Value |
|---|---|
| Status | VENDORED (adapted, Apache-2.0) |
| Location | `runtime/claude-code/settings.fragment.json` (adapted, not direct copy) |
| Notes | Fragment wires SessionStart, UserPromptSubmit, PreToolUse with Agent/Workflow matcher. Hook paths must resolve. Validated by check-runtime-wiring.sh. Thresholds are tunable per D-004; hard-blocks at genuinely-protective levels only. settings.local.json (gitignored) for per-host overrides. |

---

## System B: Cognitive Skills (external install, not vendored)

The three System B cognitive skills (`deep-research`, `visual-plan`,
`visual-recap`) are referenced-not-vendored: they are listed in the
reference repo README as external capabilities and are not copied here.
Note them as external installs in the kit documentation.

### deep-research / visual-plan / visual-recap

| Field | Value |
|---|---|
| Status | EXTERNAL |
| Location | Referenced in github.com/joshuadsutcliff README |
| Notes | Not vendored. External install. The "+3" count proposed in synthesis is not applied; these do not add to the active SKILL.md count. |

---

## Summary table

| Component | System | Status | Location |
|---|---|---|---|
| request-router | A | ACTIVE | doctrine/skills/request-router/ |
| goal-runner | A | ACTIVE | doctrine/skills/goal-runner/ |
| memory | A+B | ACTIVE (merge) | doctrine/skills/memory/ |
| context-loader | A | MERGED into memory (stub) | doctrine/skills/context-loader/ |
| token-economist | A | ACTIVE | doctrine/skills/token-economist/ |
| engagement-bootstrap | A | ACTIVE | doctrine/skills/engagement-bootstrap/ |
| quality-gate | A | ACTIVE | doctrine/skills/quality-gate/ |
| delegation | A+B | ACTIVE (merge) | doctrine/skills/delegation/ |
| pattern-promoter | A | MERGED into memory (stub) | doctrine/skills/pattern-promoter/ |
| agent-panel-planning | A | ACTIVE | doctrine/skills/agent-panel-planning/ |
| agent-panel-review | A | ACTIVE | doctrine/skills/agent-panel-review/ |
| release-captain | A | ACTIVE | doctrine/skills/release-captain/ |
| adoption-captain | A | ACTIVE | doctrine/skills/adoption-captain/ |
| trigger-indexer | A | DEMOTED-CI | CI: check-registry-coherence.sh; ref: request-router/reference/registry-maintenance.md |
| provenance-check | A | MERGED | doctrine/skills/release-captain/reference/provenance-verification.md |
| parallel-lens-synthesis | A | ACTIVE | doctrine/skills/parallel-lens-synthesis/ |
| consequence-simulation | A | ACTIVE | doctrine/skills/consequence-simulation/ |
| cross-domain-translation | A | ACTIVE | doctrine/skills/cross-domain-translation/ |
| convergence-detection | A | ACTIVE | doctrine/skills/convergence-detection/ |
| detached-judgment | A | ACTIVE | doctrine/skills/detached-judgment/ |
| simulation-to-action-bridge | A | ACTIVE | doctrine/skills/simulation-to-action-bridge/ |
| nod-protocol | A | ACTIVE | doctrine/skills/nod-protocol/ |
| ultra-think | A | ACTIVE | doctrine/skills/ultra-think/ |
| pressure-test | A | ACTIVE | doctrine/skills/pressure-test/ |
| code-audit | A | ACTIVE | doctrine/skills/code-audit/ |
| autoresearch | A | ACTIVE | doctrine/skills/autoresearch/ |
| skill-creator | A | ACTIVE | doctrine/skills/skill-creator/ |
| viz | A | ACTIVE | doctrine/skills/viz/ |
| stakeholder-mapping | A | ACTIVE | doctrine/skills/stakeholder-mapping/ |
| loop-engineering | A | ACTIVE | doctrine/skills/loop-engineering/ |
| usage-guard.sh | B | VENDORED | runtime/claude-code/hooks/ (Apache-2.0) |
| session-router.sh | B | VENDORED | runtime/claude-code/hooks/ (Apache-2.0) |
| phased-review.js | B | FOLDED | runtime/claude-code/workflows/ (local compatibility) |
| researcher agent | B | FOLDED | runtime/claude-code/agents/ (folded into delegation) |
| code-generator agent | B | FOLDED | runtime/claude-code/agents/ (folded into delegation) |
| tester agent | B | FOLDED | runtime/claude-code/agents/ (folded into delegation) |
| compress command | B | FOLDED | runtime/claude-code/commands/ (folded into memory) |
| preserve command | B | FOLDED | runtime/claude-code/commands/ (folded into memory) |
| resume command | B | FOLDED | runtime/claude-code/commands/ (folded into memory) |
| settings.fragment.json | B | VENDORED | runtime/claude-code/ (adapted, Apache-2.0) |
| deep-research | B | EXTERNAL | github.com/joshuadsutcliff |
| visual-plan | B | EXTERNAL | github.com/joshuadsutcliff |
| visual-recap | B | EXTERNAL | github.com/joshuadsutcliff |

Active SKILL.md count: derived by `check-counts.sh`.
v2.7.0 base 28; minus trigger-indexer (demoted) and provenance-check (merged) = 26
at v3.0.0. The skill-merge added `memory` and `delegation` and retired
`context-loader` and `pattern-promoter` into them, so the active count holds at 26
(now 4 retired redirect stubs, 30 SKILL.md files total).
The exact count is whatever `check-counts.sh` reports; do not hand-type it elsewhere.
