# Reference Implementation (Layer C)

Optional Python and maintainer tooling for authors. Not required to adopt or apply
the Compound AI Operating Standards Doctrine.

**Version:** v3.0.1  
**Authors:** Cameron Sutcliff, Joshua Sutcliff (joshuadsutcliff)

## Contents

| Path | Purpose |
|---|---|
| `code/` | Reference pipeline patterns (`cache_key.py`, `schema_validator.py`, `pipeline_runs.sql`, `phase_wrapper.sh`) |
| `scripts/` | Provenance utilities (`build-manifest.py`, `verify-integrity.py`, `verify-origin.py`, `new-project.sh`) |
| `skill-creator/` | Interactive skill scaffolding tool (relocated from `doctrine/skills/skill-creator/` in v3.0.0) |

## Usage

From the `operating-standards/` root:

```bash
python3 reference-impl/scripts/verify-integrity.py
python3 reference-impl/scripts/verify-origin.py --online
python3 reference-impl/scripts/build-manifest.py
bash reference-impl/scripts/new-project.sh /path/to/project
```

The `skill-creator` skill pointer lives at
`doctrine/skills/skill-creator/SKILL.md`. Run its scripts from
`reference-impl/skill-creator/`.

## Packaging

The Individual edition release zip excludes this directory (lean adopter
payload). The Team edition zip includes it. See `STANDARD.md` and D-002 in the
ratified plan.
