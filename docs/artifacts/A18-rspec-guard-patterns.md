# A18 — RSpec Guard Patterns

**Layer:** runtime · **Stacks:** ruby, rails · **Mirror:** scheduled (W8 ratchet)

## Scope

How guard specs are written so invariants are executable (A16) and budgets
regress-proof (A19).

## Standards

1. A guard spec asserts an invariant, reads its threshold live from the
   owning file, and fails when reality regresses — the spec contains no
   number (Law 3 at spec level).
2. Guards live in `spec/guards` and run inside the standard suite; a separate
   "guards phase" is a two-home defect.
3. Shared contexts assert common invariants (double-run idempotency per job
   class, middleware registration order, boot validator behavior).
4. Guard failures are triaged as invariant breaches, not flaky specs: fix
   the code, never the guard.
5. Adding an enforcement claim to the corpus without its guard spec is a
   `docs-corpus` review blocker.

## Enforcement

- `rspec_guard` gate; guard count is not a metric — coverage of claims is
  (reviewed via A16's Enforcement sections).

## Deterministic fixes

- Invariant documented only → extract to a guard spec reading the source
  threshold.
- Guard asserting a constant → point it at the owning registry file instead.
