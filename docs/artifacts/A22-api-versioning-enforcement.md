# A22 — API Versioning Enforcement

**Layer:** runtime · **Stacks:** rails · **Mirror:** scheduled (W8 ratchet)

## Scope

Making A09's versioning rules executable: routing, deprecation middleware,
and the drift gate.

## Standards

1. Each version mounts through its own routing constraint; shared code
   between versions must be additive-safe (A09 #6).
2. The deprecation middleware sets `Deprecation`/`Sunset` headers from a
   reviewed registry — dates are configuration, not literals in controllers.
3. The rswag request specs are the contract's single home; the generated
   swagger artifact is a mirror regenerated in CI.
4. `swagger_drift` gate: regenerate the schema, `git diff --exit-code` —
   drift is a build failure (Law 5 applied to contracts).
5. Sunset removal PRs delete the version directory, its routing constraint,
   and its specs in one PR; a removed version never leaves dead specs.

## Enforcement

- `swagger_drift` gate (ratchet: zero, permanent); guard specs assert
  deprecation headers for every deprecated endpoint.

## Deterministic fixes

- Drift red in CI → regenerate the schema; if the drift was intentional, the
  request spec changed in the same PR (contract first, then code).
