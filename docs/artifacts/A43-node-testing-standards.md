# A43 — Node.js Service Testing Standards

**Layer:** runtime · **Stacks:** nodejs · **Mirror:** node-testing-standards

## Scope

Service-level test suites: framework choice, boundary exercise, network
mocking, database isolation, and guard placement.

## Standards

1. The suite is one framework (the app's chosen vitest/tap/ava — its
   single home); mixed frameworks inside one service are defects.
2. Service tests exercise the real boundary: HTTP in via the framework's
   inject or a supertest-style client — listening sockets in unit tests
   are defects.
3. Outbound network is mocked at the edge (Nock/MSW/undici
   interceptors); a service test hitting real third-party network is a
   defect (A30 discipline).
4. Databases are isolated per run — truncate/migrate-reset or
   ephemeral containers; order-dependent tests are defects, and random
   order must pass (A31 discipline).
5. The delta rule applies (A04): new behavior ships with the test that
   would have failed before it existed; coverage is a ratchet read from
   its home, never restated here.
6. Guards live in the standard suite (A18): boot validators, config
   validation, and the unhandled-rejection handler are spec'd, not just
   deployed (A38/A41).
7. Flake feeds the one-way quarantine ratchet — reproduce-and-fix or
   leave it counted (A04/A31).

## Enforcement

- `web_test` in CI; coverage and flake ratchets in the app's homes.

## Agent Digest

- One test framework per service, written in the app's home; mixed frameworks are defects.
- The real boundary is exercised (inject/supertest) — listening sockets in unit tests are defects.
- Outbound network is mocked at the edge (Nock/MSW/undici); DB state isolated per run; random order passes.
- Delta rule (A04) and guards-in-suite (A18) apply; boot validators and rejection handlers are spec'd (A38/A41).
- Flake feeds the one-way quarantine ratchet; coverage numbers are read from their home, never restated.
