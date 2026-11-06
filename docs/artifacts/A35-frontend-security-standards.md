# A35 — Frontend Security and Supply Chain Standards

**Layer:** runtime · **Stacks:** react · **Mirror:** frontend-security-standards

## Scope

XSS, token handling, CSP, third-party scripts, RSC/server-action
authorization, and dependency supply-chain boundaries.

## Standards

1. XSS is banned by construction: no `dangerouslySetInnerHTML` with
   untrusted content, no `eval`/`new Function`, sanitized URLs
   (`javascript:` schemes rejected), guarded DOM sinks.
2. Auth tokens live in httpOnly cookies first; what must be readable in
   JS is scoped, short-lived, and never logged.
3. CSP is explicit and tested in report-only before enforcement;
   `unsafe-inline`/`unsafe-eval` in the final CSP is a justified
   exception, never a default.
4. Server actions and RSC boundaries re-authorize on the server —
   client-side checks are UX, never authorization (A08/A22 discipline
   applied to the web).
5. The lockfile is committed with integrity; new dependencies have their
   install scripts reviewed and provenance checked for critical
   packages; `npm_audit` gates CI.
6. Third-party scripts are consented, subresource-integrity-pinned where
   supported, and listed with owners and dates (A34).

## Enforcement

- `npm_audit`, `web_lint`, and review (A13) in CI.

## Agent Digest

- XSS banned by construction — no dangerouslySetInnerHTML with untrusted content, no eval, sanitized URLs, guarded DOM sinks.
- httpOnly cookies for tokens first; JS-readable tokens are scoped, short-lived, never logged.
- CSP explicit and report-only-tested first; unsafe-* is a justified exception, never a default.
- Server actions and RSC boundaries re-authorize server-side — client checks are UX only (A08/A22 discipline).
- Lockfile committed with integrity; install scripts reviewed; provenance for critical deps; npm_audit gates CI.
- Third-party scripts consented, integrity-pinned, owned, and dated (A34).
