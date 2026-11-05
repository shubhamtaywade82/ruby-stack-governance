# A02 — Background Job System Selection Standards

**Layer:** runtime · **Stacks:** ruby, rails · **Mirror:** scheduled (W8 ratchet)

## Scope

Choosing and enqueueing background work; the implementation standards for
Sidekiq jobs themselves live in A14.

## Standards

1. Sidekiq is the primary job system on the Rails ~> 7.2 track.
2. Solid Queue is the adopted track for Rails 8.1 (R7 decision) — new work
   must not deepen Sidekiq-specific coupling in models/controllers; enqueue
   through app-level service objects so the backend is swappable.
3. Enqueue plain serializable args (IDs, not Active Record objects or globs).
4. No scheduled work defined in code (`perform_in` for user-visible delays
   only); recurring schedules live in the operations config, reviewed like
   infrastructure.
5. Fan-out jobs must be idempotent and re-enqueueable (A14 applies fully).
6. Never enqueue inside a transaction callback that can roll back — enqueue
   from a service after commit or use transactional enqueue adapters
   explicitly.

## Enforcement

- Review checklist in PR template; job-system choice is architecture review
  scope (`packwerk` label when a new package boundary is involved).

## Deterministic fixes

- Global state enqueued → pass IDs; job re-reads current state at run time.
- AR object enqueued → pass `id`, `find` inside the job; a missing record is
  a no-op with a logged warning, never an exception.
