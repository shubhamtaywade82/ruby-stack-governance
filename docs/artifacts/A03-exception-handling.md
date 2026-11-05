# A03 — Exception Handling Standards

**Layer:** runtime · **Stacks:** ruby, rails · **Mirror:** scheduled (W8 ratchet)

## Scope

How exceptions are raised, rescued, retried, and reported across app code and
jobs.

## Standards

1. Never `rescue Exception`; never rescue without either re-raising,
   converting to a domain error, or reporting — swallowing is a defect.
2. Domain errors subclass one app error base so controllers/jobs can
   distinguish expected from unexpected failures.
3. Expected failures (validation, not-found, conflict) raise typed domain
   errors and never reach the error tracker as crashes.
4. Unexpected failures crash loudly: fail fast, report once, no `rescue`
   theater around them.
5. Retriable operations (network, third-party) get explicit bounded retry with
   backoff at the operation boundary — not blanket retries in jobs.
6. When retries exhaust, a death handler is mandatory (report + record);
   deadset silently accumulating is a violation (A14).
7. Error reporting (Rollbar or the adopted tracker) receives the exception
  once per failure, with request/job context attached.

## Enforcement

- `reek` flags empty rescue blocks; review enforces the typed-error hierarchy.
- Death handlers exercised in `spec/guards` (A15).

## Deterministic fixes

- `rescue StandardError` with logging → narrow the class, or re-raise.
- Retry loops without bounds → bounded retry + backoff + death record.
