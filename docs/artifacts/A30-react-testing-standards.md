# A30 — React Testing Standards

**Layer:** runtime · **Stacks:** react · **Mirror:** react-testing-standards

## Scope

Component, hook, form, and integration tests — what they assert, how they
query, what they mock, and how flake is kept out.

## Standards

1. Tests assert behavior through the same surface users use — role and
   name queries; test-id hooks and instance pokes are defects.
2. One behavior per test; the delta rule applies — new behavior ships
   with the test that would have failed before it existed (A04).
3. Network boundaries are mocked at the client edge (MSW or the query
   layer's mock); a component test touching real network is a defect.
4. Async is awaited by role — `findBy*` and `await` on user events;
   sleep-based and wall-clock waits are banned (A04 discipline).
5. Guards run in the standard suite, not a separate phase (A18
   discipline): accessibility and error-boundary guards live with the
   unit tests.
6. Flake follows the one-way quarantine ratchet — reproduce-and-fix or
   leave it counted; never grow it (A04).
7. Coverage targets are ratchets — numbers are read from their single
   home (`docs/ratchets.yml` for corpus-scoped, app config for the app),
   never restated here.

## Enforcement

- `web_test` in CI; flaky quarantine ratchet; coverage ratchet in the
  app's home.

## Agent Digest

- User-surface queries only (role/name) — test-ids and instance pokes are defects.
- Delta rule (A04): new behavior ships with the test that would have failed before it existed.
- Boundaries are mocked at the client edge (MSW); no component test touches real network.
- Await by role — findBy*/await user-event; sleeps and wall-clock waits are banned.
- Guards live in the standard suite (A18 discipline); quarantine is one-way (A04); coverage numbers are read from their ratchet home, never guessed.
