# A14 — Sidekiq Job Implementation Standards

**Layer:** runtime · **Stacks:** ruby, rails · **Mirror:** sidekiq-job-standards

## Scope

The body of a Sidekiq worker: what a correct job looks like, line by line.

## Standards

1. Idempotent: running twice produces one observable effect — guards
   (uniqueness window or state check) make double-enqueue safe, not rare.
2. Explicit retry policy per job class (bounded, with backoff); the default
   is a decision, not an accident.
3. Death handler mandatory on exhaustion: report once, record deadset state,
   page the owning surface (A03/A06).
4. Timeouts wrap the job's external calls — a job without a timeout is a
   worker-slot leak under outage.
5. Args are plain and serializable (IDs per A02); globals, AR objects, and
   `Time` instances are defects.
6. Per-job query budgets apply (A07/A19): a job is a request path —
   tracked, budgeted, Bullet-covered in specs.
7. Jobs are specced with fake-enqueue mode in the standard suite (A04):
   behavior assertions plus the idempotency double-run assertion.
8. No `perform_inline`/test-in-real-redis in CI; the real-redis check is an
   ops smoke test, not a spec phase.

## Enforcement

- Guard suite asserts double-run idempotency for every job class
  (`spec/guards`); death handlers asserted per retryable job.

## Agent Digest

- Every job is idempotent: a double run produces one observable effect — uniqueness window or state check makes double-enqueue safe, not rare.
- Explicit bounded retry with backoff per job class; exhaustion goes to a mandatory death handler (report once, record deadset, page the owner).
- Wrap external calls in timeouts — a job without a timeout is a worker-slot leak.
- Args are plain serializable IDs only (A02) — never AR objects, globals, or Time instances.
- A job is a request path: per-job query budgets apply (A07/A19) and Bullet runs in its specs.
- Specs assert behavior plus the idempotency double-run; deadset growth is monitored (A06), never silent.
