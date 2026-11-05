# A11 — Slow Query Monitoring Standards

**Layer:** runtime · **Stacks:** rails · **Mirror:** scheduled (W8 ratchet)

## Scope

Detecting, budgeting, and retiring slow queries in production.

## Standards

1. Query budgets per endpoint group are the primary control (A19); the
   statement timeout is the safety net, not the plan.
2. Slow query review is a weekly cadence item with one owner (A06): the
   slowest queries page, the deadset growth, the verdict per query.
3. A query merged over budget gets a strike: owner + fix deadline recorded;
   the third strike removes the feature from the budget allowlist entirely
   (it must be redesigned).
4. Adding instrumentation beats adding cache: measure before optimizing;
   speculative caching is a defect (A10).
5. Production query logs are sampled, not exhaustive — the sampler rate is
   ops-reviewed configuration.

## Enforcement

- `query-budget` PR label for budget changes; guard specs fail the suite on
  regression (A18/A19).

## Deterministic fixes

- Over-budget endpoint → query object (A07), then cache (A10), then budget
  review — in that order, measured at each step.
