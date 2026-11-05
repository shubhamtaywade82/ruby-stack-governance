# A23 — Cache Key Discipline

**Layer:** runtime · **Stacks:** rails · **Mirror:** scheduled (W8 ratchet)

## Scope

The exact cache key recipe behind A10's key-based invalidation.

## Standards

1. Model-fragment keys: [class, id, updated_at] — the recipe applies
   uniformly; local variants are defects.
2. Collective keys (aggregations, view fragments) carry an explicit
   version namespace, bumped by the PR that changes the computation —
   the bump is reviewable intent, not a TTL escape hatch.
3. Keys never embed wall-clock or random values (Law 6 applied to caches:
   keys are idempotent).
4. No delete-based invalidation anywhere — a `Rails.cache.delete` in a
   model callback is the canonical violation.
5. Key names include the owning surface (`views/…`, `api/…`, `reports/…`)
   so hit-ratio dashboards namespace cleanly (A06).
6. TTLs come from the app cache config (A10); a key recipe without a TTL
   decision is incomplete.

## Enforcement

- Review checklist for the recipe; grep-guard spec in `spec/guards` fails
  on `cache.delete` outside the ops namespace.

## Deterministic fixes

- Stale fragment after a write → fix the key recipe (version bump), never
  add a sweep.
- Cross-talk between surfaces → namespace the key; never widen the TTL.
