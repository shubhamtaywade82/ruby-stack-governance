# A40 — Node.js HTTP Service Standards

**Layer:** runtime · **Stacks:** nodejs · **Mirror:** node-http-standards

## Scope

HTTP servers, frameworks, request/response handling, client reuse, health
endpoints, and shutdown ordering.

## Standards

1. Servers set explicit timeouts (request, headers, keep-alive) and body
   size limits — vendor defaults that accept unbounded requests are
   defects.
2. Shutdown is graceful and ordered: on SIGTERM stop accepting, drain
   in-flight within a bounded deadline, close streams and pools, then
   exit — the order is the contract (A41).
3. Error responses use one envelope shape (single home); stack traces
   never reach clients; 5xx log lines carry the correlation ID (A42).
4. Handlers validate input at the boundary with the schema layer (A32)
   before any business logic; raw request bodies passed deeper are
   defects.
5. Long-lived outbound clients are created once with connection pooling
   and timeouts; a client constructed per-request is a defect.
6. Health endpoints separate liveness from readiness (dependency checks);
   both are unauthenticated and cheap.
7. Middleware order is explicit and tested — security headers and rate
   limiting (A44) wrap before body parsing.

## Enforcement

- `web_test` (boundary/inject-style integration specs) and `web_e2e`;
  review applies the envelope and shutdown rules (A13).

## Agent Digest

- Explicit request/header/keep-alive timeouts and body size limits — unbounded defaults are defects.
- Graceful shutdown in order: stop accepting, drain bounded, close pools, exit (A41).
- One error envelope (single home); stack traces never reach clients; 5xx logs carry correlation IDs (A42).
- Handlers validate at the boundary (A32 schema discipline) before any logic.
- Outbound clients are created once, pooled, with timeouts; per-request clients are defects.
- Liveness and readiness are separate, unauthenticated, cheap.
