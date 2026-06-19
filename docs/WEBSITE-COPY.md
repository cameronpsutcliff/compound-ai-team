# Website Copy

Target route:

`/compound-ai`

Page title:

`Compound AI Operating Standards`

Meta description:

`A field guide and starter kit for building AI systems that compound instead of reset: durable context, token economics, pointer skills, quality gates, lineage, and optional provenance verification.`

## Hero

Headline:

`Build AI systems that compound instead of reset.`

Subhead:

`A field guide and starter kit for durable context, token economics, repeatable AI work, and agentic quality control.`

Primary action:

`Download the Starter Kit`

Secondary action:

`Read the Field Guide`

Tertiary action:

`View on GitHub`

## One-Minute Explanation

Most AI work starts over every session. The project gets re-explained. The same files get summarized. Expensive synthesis runs even when the inputs have not changed. Outputs get read once, then disappear.

Compound AI Operating Standards is a practical operating layer for the opposite pattern: context persists, skills route work, models are matched to cognitive load, repeated intelligence is cached, and outputs become auditable artifacts.

This is not a prompt library. It is a field guide plus a starter kit you can drop into a project.

The downloadable kit is technique-first so agents can apply it anywhere. The site can be more explicit about provenance: these standards were extracted from Cameron Sutcliff's production agentic systems, including the Industry Intelligence Platform.

## Resetting vs. Compounding

| Resetting AI Work | Compounding AI Work |
|---|---|
| Every session starts cold | Every session loads current state |
| Context is pasted into prompts | Context lives in files, maps, and indexes |
| One model handles everything | Work is routed by cognitive load |
| Synthesis rebuilds from zero | Synthesis evolves from prior state |
| Outputs are prose blobs | Outputs have schemas, lineage, and quality gates |
| Patterns stay in chat history | Patterns become reusable standards |

## What Is Inside

### Field Guide

The operating standard: compound vs. reset, the three-era maturity model, context tiers, model routing, caching, pointer skills, observability, lineage, quality preservation, governance, and when not to use AI.

### Starter Kit

A deployable project scaffold with `AGENT.md`, `STATE.md`, `session-log.md`, `_map.md`, `_skills-index.md`, context tiers, pointer skills, checklists, code examples, and provenance verification.

### GitHub Source

The canonical source, release history, manifest, license, and issue trail.

## Proof Points

The kit bakes in patterns learned from production agentic systems, including the Industry Intelligence Platform:

1. Tiered context loading.
2. File-based handoffs.
3. Pointer skills under 100 lines, target 80.
4. Input-fingerprint caching.
5. Model routing by cognitive load.
6. Schema validation at LLM boundaries.
7. Intelligence lineage.
8. Observability-first scheduled jobs.
9. Quality preservation for narrative content.
10. Optional origin verification without mandatory phone-home.

## Reference Implementation

### Industry Intelligence Platform

The Industry Intelligence Platform is the source proof point for many of the patterns in the field guide: tiered context loading, input-fingerprint caching, model routing, schema validation, intelligence lineage, phase wrappers, and observability-first scheduled jobs.

Reference link:

`https://iip.cameronsutcliff.com`

Site framing:

`The field guide keeps the downloadable package portable. The website names the production system behind the patterns so readers can inspect the proof point without forcing agents to carry product-specific context.`

## Download Cards

### Starter Kit

`compound-ai-starter-kit-v1.0.0.zip`

Drop into a project and fill in the operating files.

Button:

`Download Starter Kit`

### Field Guide

`Compound-AI-Operating-Standards.pdf`

Read the framework and understand why the kit is structured this way.

Button:

`Download Field Guide`

### Source

`github.com/cameronpsutcliff/compound-ai-operating-standards`

Fork, inspect, cite, or contribute.

Button:

`View Source`

## Attribution Block

`Compound AI Operating Standards by Cameron Sutcliff`

Licensed CC BY 4.0 for documentation and Apache 2.0 for code samples.

Canonical source:

`https://cameronsutcliff.com/compound-ai`

GitHub:

`https://github.com/cameronpsutcliff/compound-ai-operating-standards`

## FAQ

### Is this Claude-specific?

No. The starter kit uses `AGENT.md` as the canonical operating contract and includes translation guidance for Claude Code, Codex, Cursor, GitHub Copilot, Aider, Continue.dev, and generic AI CLIs.

### Does it phone home?

No. The kit works offline. It includes optional origin verification so you can check whether a local copy matches the canonical release.

### Is this a prompt library?

No. It is an operating scaffold: context files, pointer skills, quality gates, checklists, code examples, and provenance metadata.

### What makes it different from a good CLAUDE.md?

A good `CLAUDE.md` is one operating file. This is a versioned kit with context tiers, a map, a skills index, reusable checklists, verification scripts, and cross-platform translation.

## JSON-LD Draft

```json
{
  "@context": "https://schema.org",
  "@type": "SoftwareSourceCode",
  "name": "Compound AI Operating Standards",
  "author": {
    "@type": "Person",
    "name": "Cameron Sutcliff"
  },
  "description": "A field guide and starter kit for building AI systems that compound instead of reset.",
  "url": "https://cameronsutcliff.com/compound-ai",
  "codeRepository": "https://github.com/cameronpsutcliff/compound-ai-operating-standards",
  "license": [
    "https://creativecommons.org/licenses/by/4.0/",
    "https://www.apache.org/licenses/LICENSE-2.0"
  ],
  "programmingLanguage": ["Markdown", "Python", "Shell", "SQL"]
}
```
