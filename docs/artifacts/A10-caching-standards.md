# A10 — Caching Standards

**Layer:** runtime · **Stacks:** rails · **Mirror:** caching-standards

## Scope

Fragment, model, and computed-value caching in the target app.

## Standards

1. Key-based invalidation only: never delete or sweep entries in response to
   writes (A23 for the key recipe).
2. TTLs are explicit per surface and live in the app's cache config — the
   shortest that tolerates staleness; defaults are chosen once, reviewed,
   never guessed per PR.
3. Anything cached must be measurable: hit ratio per key namespace is on the
   monitoring dashboard (A06).
4. Cache misses on hot paths are computed through query objects (A07) —
   caching never hides an N+1.
5. `expires_in` on fragment caches is a decision with an owner; "no TTL"
   requires a versioned key recipe instead.
6. Cross-cutting (Solid Cache / store choice) follows the Rails 8.1 track
   decision (R7/A02) — cache store configuration is ops-reviewed.

## Enforcement

- Key discipline reviewed via the checklist; hit-ratio regression is a
  monitoring alert, not a debate.

## Agent Digest

- Key-based invalidation only — never delete or sweep cache entries in response to writes (key recipe in A23).
- TTLs are explicit per surface, owned by the app cache config — the shortest that tolerates staleness; never guessed per PR.
- Cache never hides an N+1 — misses on hot paths go through query objects (A07).
- Hit ratio per key namespace is on the monitoring dashboard; regressing hit ratio is an alert.
- No-TTL requires a versioned key recipe; a bare `expires_in` without an owner is a defect.
