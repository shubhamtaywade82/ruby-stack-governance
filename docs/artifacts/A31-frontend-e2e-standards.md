# A31 — Frontend E2E and Visual Testing Standards

**Layer:** runtime · **Stacks:** react · **Mirror:** frontend-e2e-standards

## Scope

Browser-level end-to-end tests for critical workflows, and visual
regression across states — plus the accessibility scan that rides along.

## Standards

1. E2E covers critical user workflows only — small, deterministic, real
   page-and-network boundary; logic coverage belongs to `web_test`
   (A30), not to the browser layer.
2. Selectors are user-surface (role, label, text) or explicit test
   anchors; CSS paths and auto-generated locator chains are defects.
3. Each test owns its state: fresh auth and seed per test, no cross-test
   ordering; the suite must pass under random order.
4. Network is deterministic — routes stubbed or fixture-backed except
   where the test's purpose is the real boundary itself.
5. Visual regression sweeps viewport × theme × locale × reduced-motion;
   unstable screenshot noise (animations, carets, timestamps) is
   stabilized by config, never by retry.
6. Axe scans run in the E2E pass; violations feed the `axe_violations`
   ratchet (`docs/ratchets.yml`).
7. E2E flake follows the same one-way quarantine ratchet as unit flake
   (A04).

## Enforcement

- `web_e2e` in CI; `axe_violations` ratchet; flaky quarantine ratchet.

## Agent Digest

- E2E is for critical workflows only — logic coverage belongs to web_test (A30).
- User-surface selectors; fresh state per test; the suite passes in random order.
- Deterministic network — stubbed or fixture-backed; visual tests sweep viewport × theme × locale × reduced-motion with stabilized animation config.
- Axe runs here — violations count into the axe_violations ratchet (read `docs/ratchets.yml`, never restate the number).
- E2E flake feeds the same one-way quarantine as unit flake (A04).
