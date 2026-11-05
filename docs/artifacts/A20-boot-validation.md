# A20 — Boot Validation Standards

**Layer:** runtime · **Stacks:** rails · **Mirror:** scheduled (W8 ratchet)

## Scope

What an application proves about itself before accepting traffic.

## Standards

1. A boot validator PORO runs at startup; every check is deterministic and
   prints one plain-language failure line, then exits nonzero — fail fast,
   no degraded-mode booted.
2. Checks: required credentials present (A08); every ENV read is on the
   allowlist; `RUBY_VERSION` matches `.ruby-version` (single home, Law 3);
   pending migrations abort a production boot.
3. The validator has no side effects and no network egress; it reads local
   truth only.
4. The same validator runs as a one-job CI stage for the app so "boots
   clean" is a gate, not a wish.
5. A failed boot check is a deploy blocker: fix forward, never bypass with
   an env toggle.

## Enforcement

- Validator smoke spec in `spec/guards` (A15/A18); CI boot stage.

## Deterministic fixes

- Missing credential at boot → provision it or fail the deploy; never default
  to a placeholder in production.
- ENV read outside allowlist → route through the configured accessor (A08),
  add to allowlist with review, or remove the read.
