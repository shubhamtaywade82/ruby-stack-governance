# A07 — ActiveRecord Query Standards

**Layer:** runtime · **Stacks:** rails · **Mirror:** activerecord-query-standards

## Scope

Writing queries, scopes, and migrations that stay inside query budgets and
never regress into N+1 territory.

## Standards

1. N+1 is banned: every association traversal in a request path is covered by
   `includes`/preloading — enforced by Bullet inside the suite.
2. Loops do not contain queries: batch with `in_batches`/`find_each` and
   size the batch explicitly.
3. Every `WHERE`/`ORDER` combination has a supporting index or a written
   exception note; migrations that add filters add indexes in the same PR.
4. Subqueries in loops, query-in-view, and `first`/`last` without order are
   defects.
5. Statement timeout protects production as the safety net; per-endpoint
   budgets are the primary control (A19).
6. Counters are maintained with atomic updates, never in-memory arithmetic
   on associations.
7. Read heavy scopes on large tables go through read-model queries in
   `app/queries/**`, one query object per use case.

## Enforcement

- Bullet in suite; `spec/guards` budget guards (A18/A19).

## Agent Digest

- N+1 banned — preload/`includes` every association a request path traverses; Bullet fails the suite otherwise.
- No queries inside loops — `in_batches`/`find_each` with explicit batch sizes.
- Every WHERE/ORDER has an index or a written exception; migrations adding filters add indexes in the same PR.
- Per-endpoint query budgets are the primary control (A19); statement timeout is the safety net, not the plan.
- Read models live in app/queries — one query object per use case; counters update atomically.
