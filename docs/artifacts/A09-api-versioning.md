# A09 — API Versioning Standards

**Layer:** runtime · **Stacks:** rails · **Mirror:** api-versioning-standards

## Scope

Public-facing HTTP API versioning, deprecation, and contract drift control.

## Standards

1. Version lives in the URL path (`/api/v1/...`); header-based version
   selection is rejected as uncacheable ambiguity.
2. A new version is additive: existing fields keep name and type; removals
   go through deprecation.
3. Deprecations carry machine-readable headers (`Deprecation`, `Sunset`) and a
   document a replacement path; the sunset window spans at least two minor
   releases.
4. The request-spec schema (rswag) is the contract's single home; generated
   swagger is a mirror, drift-gated (A22).
5. Version bumps are decision-recorded: a new version exists only when a
   breaking change is unavoidable.
6. Response envelopes, pagination, and error shapes are version-locked —
   shared helpers change only behind the newest version.

## Enforcement

- `swagger_drift` gate (A22): request specs regenerate the schema; CI diffs
  it — drift fails the build.
- Deprecation middleware specs run in the guard suite.

## Agent Digest

- Version in the URL path (`/api/v1/...`) — header-based versioning is rejected.
- New versions are additive; removals require Deprecation + Sunset headers and a two-release sunset window.
- The rswag request specs are the contract's single home — generated swagger is a drift-gated mirror (A22).
- Shared envelope/pagination/error helpers are version-locked; change them only behind the newest version.
