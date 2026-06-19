# HG-2 Debate: The Foreword Incident

**Status:** Closed in Loop 5. All three agents have logged positions and concur on the WAL contention story. Resolution locked in the build plan (HG-2) and applied to the Field Guide foreword.
**Cameron's directive (Loop 4):** "all 3 of you debate and come up with a decided upon answer, which is the strongest story for which entry is best answered by this resource?"
**Created by:** Claude, Loop 4

---

## The three candidates

| # | Candidate | Source | Verified |
|---|---|---|---|
| 1 | The 47K-token re-read session: the same spec was reloaded seven times in one day because the project had no operating contract. | Claude conjecture (no source). | NO. Drop. |
| 2 | The WAL contention incident: 18 of 22 verticals lost overnight because the LLM cache opened its own SQLite handle on every call. | `ENHANCEMENTS.md` Session 2026-05-04. Commits 560c6f7, 7bc85c7, 0c3f22e, 22debd0, 54fe647. | YES. |
| 3 | The narrative regression: 24 reports including META, NVDA, AMZN, BRK.B, BAC, INTC, CRM, V, HD regressed to 9-25% of historical content size. Discovered by Cameron manually reviewing the Verizon page. | `ENHANCEMENTS.md` Reliability Pattern 7 section. | YES. |

Candidate #1 has no source and should not be considered. The debate is between #2 (WAL) and #3 (narrative regression).

---

## Selection criteria

Cameron's framing: *"the strongest story for which entry is best answered by this resource?"*

Translated: the strongest opener is the failure that this manual most clearly resolves. Not the most dramatic failure. Not the most distinctive failure. The one whose resolution maps tightest to the standards the manual ships.

Five dimensions for grading:

1. **Verifiability.** Specific commits, dates, numbers.
2. **Coverage.** How many of the manual's parts does the resolution touch?
3. **Visceral landing.** Will a reader feel the failure?
4. **Specificity of detail.** Named entities, real percentages, real timing.
5. **Onboarding cost.** How much pre-context does the reader need before the story lands?

---

## Position: Claude

**Concurs with the WAL contention resolution.** Honest read after seeing the foreword draft.

| Dimension | WAL (#2) | Narrative regression (#3) | Winner |
|---|---|---|---|
| Verifiability | 5 commits, specific date, specific count (18 of 22) | Specific tickers (9), percentages (9-25%), narrative of discovery | Tie. Both are verified. |
| Coverage | Maps to caches (Ch 12), cache attribution (Ch 13), observability (Ch 23), Era 03 discipline (Ch 3), schema validation (Ch 21) | Maps to Quality Immune System (Ch 24), lineage (Ch 22), So What test (Ch 25) | WAL wins on breadth. Narrative regression wins on depth on one signature chapter. |
| Visceral landing | "18 of 22 verticals lost overnight" lands instantly. The reader does not need to know what a vertical is to feel the wipeout. | "24 reports regressed to 9-25% silently, discovered manually" lands but requires the reader to absorb the silent-degradation concept. Slower setup. | WAL. |
| Specificity | Named subsystems (LLM cache, SQLite handle, single-writer architecture, ContextVar fix) | Named tickers (META, NVDA, AMZN, etc.) | Tie. WAL has technical specificity; narrative regression has business specificity. |
| Onboarding cost | Low. "Cache opened its own database handle" is plain English for any engineer; the broader audience reads it as "a bug." | Higher. The reader needs to understand that AI outputs can silently regress without anyone noticing. That is half the chapter being summarized in the foreword. | WAL. |

**Why I switched.** My first instinct was to argue for narrative regression because Quality Immune System (Ch 24) is the most distinctive chapter in the manual and the foreword should anchor to the manual's most distinctive contribution. After reading the implemented WAL foreword, I am wrong. The foreword's job is not to advertise the most distinctive chapter; it is to motivate the entire manual. WAL contention motivates Parts II, III, IV, and V simultaneously (context, tokens, orchestration, quality). Narrative regression motivates Part V only. WAL is the more efficient opener.

**The strongest opener is the failure that motivates the most chapters in the fewest words.** WAL wins on that test.

**One concession.** Narrative regression is still the strongest single illustration of Chapter 24 (Quality Immune System), and Chapter 24 should keep it as the worked-example incident inside the chapter body. Two failures, two roles. Both ship.

---

## Position: Codex

**Concurs with the WAL contention resolution.**

The WAL incident is the strongest foreword story because it is the best answer to the resource Cameron is actually shipping. This package is not just about writing better prompts or saving tokens. It is about making agentic work durable: operating contracts, context tiers, cache attribution, phase wrappers, provenance, review gates, and recovery paths. The WAL failure activates that whole stack in one incident.

The 47K-token reread story is useful, but it mainly motivates context loading. The narrative regression story is stronger than the reread story and should absolutely remain in the quality chapters, but it mostly motivates the quality immune system. WAL is broader. It shows a system that already had automation and caching, then failed because one implementation boundary violated the architecture's promise. That is exactly what this manual teaches people to prevent.

Codex vote: **WAL for the foreword, narrative regression for Chapter 24, 47K reread as a context-loading caution only if independently sourced.**

---

## Position: Kiro

**Concurs with the WAL contention resolution. No stronger candidate found in the source material.**

After reviewing `ENHANCEMENTS.md` in full, the WAL contention story (Session 2026-05-04) is the strongest candidate. No other incident in the session logs has the same combination of verifiability, breadth, and visceral landing.

**Scoring the two verified candidates:**

| Dimension | WAL (#2) | Narrative regression (#3) |
|---|---|---|
| Verifiability | 5 commits, specific date, 18/22 count | Specific tickers, 9-25% range, discovery narrative |
| Coverage | Motivates Parts II, III, IV, V simultaneously | Motivates Part V only |
| Visceral landing | "18 of 22 verticals lost overnight" -- immediate | "24 reports silently degraded" -- requires setup |
| Onboarding cost | Low -- "cache opened its own DB handle" is plain English | Higher -- reader needs to understand silent regression first |
| Technical specificity | Named subsystems, named fix pattern (ContextVar) | Named tickers, named percentages |

**Why WAL is the right foreword story for this specific resource:**

The manual's thesis is "AI work that compounds instead of resets." The WAL incident is the clearest example of a system that was already compounding -- it had automation, caching, scheduled jobs -- and then failed because one implementation boundary violated the architecture's promise. That is exactly the failure mode this manual teaches people to prevent.

The narrative regression incident is a better illustration of Chapter 24 specifically (Quality Immune System), but it is a narrower failure. A reader who has never run a synthesis pipeline needs more setup before the regression story lands. The WAL story lands in one sentence for any engineer.

**One thing Kiro adds that the other two did not flag:**

The WAL incident also illustrates the "single-writer architecture that was not actually single-writer" failure mode -- which is a specific instance of the broader pattern this manual calls "demo-era assumptions surviving into Era 03." The LLM cache was added in Era 02 (it existed, it worked). The failure happened in Era 03 when the system had multiple concurrent writers. The fix (ContextVar-based shared connection) is an Era 03 pattern. This maps directly to Chapter 3 (The Three-Era Maturity Model) and makes the foreword incident a preview of the maturity model, not just a horror story.

**Kiro vote: WAL for the foreword. Narrative regression for Chapter 24. Resolution stands.**

---

## Resolution

**Decision:** Use the WAL contention story as the foreword incident.

**Reasoning (synthesizing the three positions above):** All three agents independently arrive at WAL. The story has stronger coverage across the manual's five parts, lower onboarding cost, more visceral first-paragraph landing, and verifiable artifacts (five commits, specific date, named root cause). Kiro adds a fourth dimension the other two did not flag: the WAL incident also illustrates the "demo-era assumption surviving into Era 03" pattern, which previews the maturity model in Chapter 3, not just the reliability chapters. The narrative regression incident remains the strongest single illustration of Chapter 24 and should be used there.

**Status:** Locked in Loop 5. Foreword updated. All three agent positions logged.

**Author of record:** Cameron Sutcliff. The decision is documented in the build plan (HG-2).

**Consensus is three-way and explicit.** The foreword is one Edit away from a different incident at any time, but no agent has dissented. The debate file is the closing record.

---

*Compound AI Operating Standards build, Loop 4, HG-2 debate. See the build plan for the locked resolution and the Field Guide foreword (lines 18-20) for the implemented foreword.*
