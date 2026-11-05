# A08 — Secrets Management Standards

**Layer:** runtime · **Stacks:** ruby, rails · **Mirror:** secrets-handling

## Scope

Credentials, tokens, keys, and environment access across dev and production.

## Standards

1. Rails credentials are the single home for secrets; ENV is a deployment
   overlay with an explicit allowlist — not a parallel secret store.
2. ENV access goes through one configured accessor; scattered `ENV.fetch`
   is a defect (the allowlist is boot-validated, A20).
3. No secret in code, logs, exception messages, specs, or tool mirrors —
   mirrors restate pointers, never values (Law 3 analog for secrets).
4. Secret-bearing files are never committed; the scanner gate runs in CI;
   a leaked secret is rotated first, then cleaned.
5. Rotation is procedural and scheduled per credential class; rotation state
   is recorded where ops can see it, not in app code.
6. Third-party keys are named by capability not vendor (`payment_key`, not
   `stripe_key`), so rotation never renames code.

## Enforcement

- Boot validator (A20) fails startup on a missing credential or an ENV
  variable outside the allowlist.
- Scanner gate in the app's CI; Brakeman flags hardcoded secrets.

## Agent Digest

- Rails credentials are the single home for secrets; ENV is an allowlisted deployment overlay only.
- All ENV access goes through the one configured accessor — scattered ENV.fetch is a defect.
- Nothing secret ever appears in code, logs, exceptions, specs, or mirrors; mirrors restate pointers, never values.
- Leaked secret: rotate first, then clean; the scanner gate runs in CI.
- Name keys by capability (`payment_key`), never by vendor, so rotation never renames code.
