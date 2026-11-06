# A44 — Node.js Server Security Standards

**Layer:** runtime · **Stacks:** nodejs · **Mirror:** node-security-standards

## Scope

Server-side security: transport headers, rate limiting, injection
prevention, secret handling, authorization, and supply chain.

## Standards

1. Security headers are set at the edge (helmet-style: CSP, HSTS,
   nosniff, frame policies) with A35's CSP discipline — report-only
   first, `unsafe-*` only as a justified exception.
2. Rate limiting applies to every unauthenticated route and expensive
   operation, before body parsing (A40); limits are configuration with
   a single home.
3. Path traversal and command injection are banned by construction:
   user input never reaches path joins without normalization and
   allowlists; `shell: true` never with user-derived input (A41).
4. Secret comparisons are timing-safe (`crypto.timingSafeEqual`);
   secret storage follows A08's single-home rules and secrets never
   appear in logs (A42).
5. AuthN/AuthZ is centralized in one guard chain (single home);
   handlers re-authorize server-side — client checks are UX only
   (A22/A35 discipline).
6. Dependency vulnerabilities gate CI (`npm_audit`); production
   installs run frozen-lockfile with install scripts reviewed (A35/A37).
7. Untrusted input is schema-validated before anything else touches it
   (A32); `eval`/`vm` on untrusted input is a defect.

## Enforcement

- `npm_audit`, `web_lint`, `web_test` (auth and injection guard specs);
  review applies the guard-chain rules (A13).

## Agent Digest

- Security headers at the edge (helmet-style) with A35's CSP discipline — report-only first, unsafe-* only justified.
- Rate limiting before body parsing on every unauthenticated route; limits live in one config home.
- Path joins normalize against allowlists; shell true never sees user input (A41).
- Secret comparisons are timing-safe (crypto.timingSafeEqual); secrets follow A08's single home and never hit logs (A42).
- AuthN/AuthZ is one centralized guard chain; handlers re-authorize server-side (A22/A35 discipline).
- npm_audit gates CI; frozen installs in production; untrusted input is schema-parsed first (A32).
