# Fresh-Session Dry Run

Date: 2026-05-13

Package tested: `releases/v1.0.0/compound-ai-starter-kit-v1.0.0.zip`

Purpose: understand what a brand-new agent session would think to do with the delivery package before doing any implementation.

## Setup

I extracted the release zip into a clean temporary directory and treated it as a fresh agent workspace. I did not use the already-open build folder as the working surface.

Checks run from the extracted kit:

```bash
scripts/verify-integrity.py
scripts/verify-origin.py --online
```

Result: both passed. Online origin verification returned `VERIFIED` after the canonical manifest was hosted on the website.

## What A Fresh Agent Sees First

The package presents itself as an operating scaffold, not an application repo. The first files a fresh agent should read are:

1. `AGENT.md`
2. `STATE.md`
3. `_map.md`
4. `_skills-index.md`
5. `Project.md`
6. `checklists/session-start.md`

This gives the agent a contract, current state, file routing map, skill routing table, project definition, and startup checklist before it loads deeper context.

## What The Agent Thinks The Package Is

A fresh agent should understand the kit as a repeatable operating standard for compound AI work. It is meant to help an agent preserve state, load context selectively, route work to skills, verify provenance, and close sessions in a way that makes the next session stronger.

It should not assume the kit is a complete implementation of a product. It is a starter operating layer to install into a project and adapt.

## What The Agent Would Do First

1. Verify the package with `scripts/verify-integrity.py`.
2. If online, run `scripts/verify-origin.py --online`.
3. Fill placeholders in `AGENT.md`, `Project.md`, and `STATE.md`.
4. Use `_map.md` to load only the files needed for the task.
5. Use `_skills-index.md` to route specialized tasks instead of loading the whole guide.
6. Create or append to `session-log.md` during meaningful work.
7. Close the session with `checklists/session-closeout.md`.

## What The Agent Would Not Do

1. It would not load the full Field Guide into the active context by default.
2. It would not implement a product before the project placeholders are filled.
3. It would not treat provenance verification as a mandatory phone-home lock.
4. It would not overwrite the package attribution fields while adapting the kit.
5. It would not skip session logging after material changes.

## Skill Routing Interpretation

The skill index makes routing legible. A fresh agent would map tasks like this:

| Task type | Likely route |
|---|---|
| Reduce context cost | `conventions/token-efficiency.md`, `checklists/token-budget.md`, context files |
| Plan model choice | `checklists/model-routing.md`, `templates/model-routing.md` |
| Verify attribution | `scripts/verify-integrity.py`, `scripts/verify-origin.py`, `conventions/provenance.md` |
| Add a repeatable pattern | `checklists/pattern-promotion.md`, `templates/quality-gates.md` |
| Close a session | `checklists/session-closeout.md`, `session-log.md`, `STATE.md` |

## Issue Caught

The dry run caught a stale documentation path: `README.md` and `_map.md` referenced `examples/`, but the actual reference implementation folder is `code/`. I corrected those two files, rebuilt the starter-kit manifest, rebuilt the release zip, and regenerated release checksums.

Corrected aggregate SHA256:

`dc9c853bbaba3c2c670017f119cc9611cd08962acbcb8231f57c7aad525bd8a3`

Corrected release zip SHA256:

`e124d2b1c0e7baee1c7aee17a6f85006bd1981cd5180a0175a0f0340b15bd309`

## Verdict

Pass. A fresh session should understand the delivery package as a sophisticated, low-context operating scaffold. It should begin with verification, state setup, and context routing, not implementation.
