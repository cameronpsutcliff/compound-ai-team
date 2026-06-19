# Publication Checklist

The v1.0.0 build is published. GitHub, the release tag, the website route, downloadable assets, and online origin verification are live.

---

## Published Surfaces

1. Website: `https://cameronsutcliff.com/compound-ai`
2. GitHub repo: `https://github.com/cameronpsutcliff/compound-ai`
3. GitHub release: `https://github.com/cameronpsutcliff/compound-ai/releases/tag/v1.0.0`
4. Canonical manifest: `https://cameronsutcliff.com/compound-ai/manifest.json`

---

## What Is Shipped

Six artifacts under `releases/v1.0.0/`:

1. `compound-ai-starter-kit-v1.0.0.zip`, 63,146 bytes, sha256 `e124d2b1c0e7baee1c7aee17a6f85006bd1981cd5180a0175a0f0340b15bd309`
2. `Compound-AI-Operating-Standards-v1.0.0.md`, 129,282 bytes, sha256 `5fbcfeb765b7d8fa932db9f7a90e1116aaacea3cb797584786b83ad70ea226dc`
3. `WEBSITE-COPY-v1.0.0.md`, 5,853 bytes, sha256 `b77e18fd3045bcfd23bb7092570ec22f6c00541915ab9d06c55cf06557ad479a`
4. `RELEASE-NOTES.md`, 2,112 bytes, sha256 `838d349c4c64f0848d3f49a37d2720520e19b60215f67c9ef620f98d24e9f97e`
5. `SHA256SUMS`, 479 bytes, canonical release checksum manifest
6. `starter-kit-internal-SHA256SUMS`, 4,392 bytes, sha256 `1a49caf23904fa392d0058042d27080dafc1ba591a2cdf5c61f7701fd7696648`

Starter-kit aggregate sha256: `dc9c853bbaba3c2c670017f119cc9611cd08962acbcb8231f57c7aad525bd8a3`. 48 indexed files.

---

## Completed Publication Steps

1. GitHub repo created under `cameronpsutcliff`.
2. Public repo root uses the starter kit layout so a fresh agent sees `AGENT.md` immediately.
3. `docs/` carries the field guide, website copy, HG-2 debate, and final review.
4. `releases/v1.0.0/` carries the release assets and checksums.
5. Tag `v1.0.0` exists.
6. GitHub release `v1.0.0` exists with all release assets attached.
7. Website route `/compound-ai` is deployed.
8. Website route links the starter kit download, field guide download, GitHub repo, manifest, and checksum.
9. Online origin verification returns `VERIFIED`.
10. Fresh-session dry run completed and logged in `FRESH-SESSION-DRY-RUN.md`.

---

## Deliberate Non-Goals For v1.0

1. No PDF generation. v1.0 ships markdown.
2. No paid hosting requirement. The kit is small enough for static hosting and GitHub releases.
3. No analytics tracking inside the kit. Web-page analytics can exist on the landing page, but the downloaded artifacts do not phone home.
4. No email gate on the download.
5. No Maturity Assessment Workbook in v1.0. Deferred to v1.1 per PV1-003.

---

## What Rolls Into v1.1

See `POST-V1-BACKLOG.md`. Seven items remain, including the maturity assessment workbook, PDF or print packaging, and optional deeper install tooling.

---

## If Something Breaks

1. Run `scripts/verify-integrity.py` first to confirm the local files match the bundled manifest.
2. Run `scripts/verify-origin.py` next to confirm local-only origin metadata is internally clean.
3. Run `scripts/verify-origin.py --online` last. If only this fails, the website manifest or checksum no longer matches the local package.
4. If a release asset changes, rebuild the starter-kit manifest if needed, rebuild the zip, regenerate `SHA256SUMS`, redeploy the website assets, update GitHub release assets, and rerun online verification.

---

## Sign-Offs In Place

1. Kiro: technical accuracy review complete.
2. Codex: package integrity, release packaging, GitHub publication, website deployment, and fresh-session dry run complete.
3. Claude: voice and anti-AI-slop adversarial pass complete. AI-clearly-wrote-this 91/100, on-topic 96/100.

Three-way concurrence on HG-2 is logged in `HG-2-DEBATE.md`.

HG-4 resolution is implemented: the downloadable kit stays anonymized and technique-first; the website and GitHub surfaces may name the Industry Intelligence Platform and link to `https://iip.cameronsutcliff.com`.

---

v1.0.0 is live.
