# A15 — Runtime Guards Standards

**Layer:** runtime · **Stacks:** rails · **Mirror:** scheduled (W8 ratchet)

## Scope

The runtime guard lattice: boot validators, death handlers, request
middleware, and the guard spec convention.

## Standards

1. Boot validators run at startup and fail fast on: missing credentials, ENV
   outside the allowlist, Ruby version mismatch, unrun migrations in
   production (A20 defines the checks).
2. A guard is executable: every invariant has a spec in `spec/guards` that
   fails when the invariant breaks — guards are code, not prose (A16).
3. Request middleware registers: query counting (A19) and statement timeout
   — additions to the middleware stack are PR-reviewed architecture.
4. Death handlers are registered once per system, at one boundary (A03/A14).
5. Guards never carry business logic; they assert and protect invariants.

## Enforcement

- `rspec_guard` runs guard specs in the standard suite (no separate phase);
  boot validator smoke-runs in a one-job CI stage for the app.

## Deterministic fixes

- Invariant enforced only in review → move to a guard spec (review is not a
  gate).
- Two systems reporting the same failure → one boundary owns reporting.
