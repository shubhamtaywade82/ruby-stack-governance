# A19 — Query Budgets Standards

**Layer:** runtime · **Stacks:** rails · **Mirror:** scheduled (W8 ratchet)

## Scope

Per-endpoint-group query budgets: mechanism, registry, and failure modes.

## Standards

1. The middleware counts queries per request and compares against the
   endpoint group's budget; the budget registry is the app's
   `config/query_budgets.yml` — one home, reviewed like any limit.
2. Test suite: over-budget request fails the example (strict); production:
   record and alert (sampling applies, A11).
3. A budget change is a `query-budget`-labelled PR with before/after
   measurements — budgets are evidence-backed, never negotiated in review.
4. Background jobs carry budgets as request paths do (A14); the same
   registry row format applies.
5. Budget regression in production (A11) follows the strike rule: owner,
   deadline, then redesign.

## Enforcement

- `spec/guards` budget guards (A18); middleware registration asserted
  (A15).

## Deterministic fixes

- Over-budget request → A07 order: query object, then cache (A10), then
  budget review with measurements.
