# Brief Standard

> Locked 2026-06-10 after the June 9 daily brief shipped LLM-improvised dark callout boxes with
> unreadable contrast. Briefs are sent, set to a standard, on a schedule. No agent hand-writes
> brief HTML, ever.

## The contract

1. **Content and presentation are separated.** Agents write brief CONTENT as markdown. The
   deterministic renderer `$ORCH_DIR/brief-render.py` owns ALL presentation: light palette,
   WCAG-safe contrast, email-client-safe inline CSS, 600px column, -apple-system. An agent that
   writes `<div style=...>` into a brief is violating this standard.
2. **The markdown contract** (everything else is plain paragraphs):
   - `# Title` (one), `## Section` headings
   - `-` bullets and `1.` numbered items, with `**bold**`, `*italic*`, `[text](url)`, `` `code` ``
   - `> ACTION: ...` (amber callout), `> HIGHLIGHT: ...` (green), `> NOTE: ...` (gray)
   - triple-backtick blocks for verbatim text (LinkedIn drafts, commands)
   - pipe tables (`| a | b |` header + `|---|---|` separator + data rows), added 2026-06-10
     for the token-burn section
3. **One send path:** `brief-render.py /tmp/brief-body.md --send 'Subject'` (wraps
   send_email.py). Email is the sole delivery channel; Telegram is for failures only.
4. **Idempotency:** `emailed: true` frontmatter on the data file is the only authoritative
   delivery flag.

## The schedule (all briefs, one table)

| Brief | Time CT | Job | Subject pattern |
|---|---|---|---|
| Morning Brief | 07:45 | com.cameronsutcliff.claude-selfcheck-daily | Morning Brief - DATE |
| Daily Intelligence Brief | with morning run | daily-brief component | Daily Intelligence Brief DATE |
| Afternoon Action Brief | on demand / PM run | afternoon-brief component | Afternoon Action Brief DATE |
| Evening Intel Brief | 17:30 | com.cameronsutcliff.claude-selfcheck-evening | Evening Intel Brief DATE |
| Weekly Review | Sun 08:00 | weekly-review component | Weekly Review DATE |

## Content quality gates (unchanged, restated)

- No em-dashes. No AI vocabulary (Additionally/Moreover/Furthermore/delve/landscape/pivotal/
  tapestry/testament). All URLs from source data. LinkedIn draft fully inline, never a file
  reference.
- Every "Opportunities / Tech Stack Enhancements" item must carry a concrete next step AND gets a
  ledger row (see enhancement-ledger below): recommendations that nobody works are noise.

## Token burn section (2026-06-10)

Morning Brief and Daily Intelligence Brief each carry a `## Token burn (last 7 days)` section so
"are the loops eating my quota" gets a measured daily answer. The contract:

- Generated ONLY by `python3 $ORCH_DIR/token-burn-report.py --markdown`.
  The brief agent appends the output VERBATIM to /tmp/brief-body.md; it never rewrites,
  summarizes, or reformats the table or trend line. No new scheduled job: it runs inside the
  existing brief jobs, so no Loop Spec is required.
- Content: a per-day pipe table (day, claude out/in, codex out/in, hermes out/in), 7-day totals,
  cache reads listed separately (cheap, not free attention), claude split by model family, and a
  one-line trend verdict (flat / rising / falling vs the prior 7 days).
- Sources are MEASURED from local session records: Claude Code transcripts
- Per-job attribution is not feasible yet (loop jobs share cwd with interactive sessions);
  `--json` carries a truthful per-project-dir breakdown instead. Never fake job attribution.
- If the script errors, the brief omits the section and logs the failure; the brief still sends.

## Enhancement accountability (2026-06-10)

Brief recommendations are not fire-and-forget. Each actionable enhancement is appended by the brief
to a shared workspace enhancement ledger (status: proposed). The Enhancement Worker loop evaluates,
implements, tests, and verdicts each one (kept / pulled / rejected, with evidence). A lessons-review
loop audits whether kept enhancements still earn their place.
