# A04 — Testing and Coverage Standards

**Layer:** runtime · **Stacks:** ruby, rails · **Mirror:** rspec-testing-standards

## Scope

RSpec suite structure, determinism, coverage ratchets, and mutation testing
for the target app.

## Standards

1. One expectation per behavior; specs name the behavior, not the method.
2. Wall-clock is banned in examples: use time helpers for freeze/travel;
   order-dependent specs are defects, not flakiness to be quarantined.
3. Coverage floor rises per `docs/ratchets.yml` (`simplecov_coverage`); the
   number lives there and in the app's coverage config only (Law 3).
4. Factories stay minimal and linted; factory data never encodes business
   invariants — those belong in specs.
5. Core POROs (value objects, services) carry mutation coverage
   (`mutant_core` gate); a surviving mutant is a failing spec.
6. Flaky behavior: reproduce-or-quarantine within the week; quarantine is a
   ratcheted count that only shrinks (`flaky_quarantine`).
7. Guard specs (asserting limits and invariants) run inside the standard
   suite — guards are not a separate phase (A18).
8. New code arrives with the spec that would have failed before it (the
   "delta rule").

## Enforcement

- `rspec_guard` gate; `mutant_core` gate; coverage ratchet on the weekly clock.
- Bullet runs inside the suite (A07).

## Agent Digest

- One expectation per behavior; wall-clock banned — freeze/travel time helpers only.
- Coverage, mutation and quarantine numbers are never guessed — read `docs/ratchets.yml` (`get_ratchet`).
- Guard specs assert invariants and limits inside the standard suite; guards are not a separate phase.
- New code ships with the spec that would have failed before it existed (delta rule).
- Quarantine is a one-way ratchet: reproduce-and-fix or leave it counted; never grow it.
