# A42 — Node.js Logging and Observability Standards

**Layer:** runtime · **Stacks:** nodejs · **Mirror:** node-logging-standards

## Scope

Structured logging, correlation IDs, redaction, error logging, metrics,
and profiling discipline.

## Standards

1. Logs are structured JSON through one logger instance (the app's chosen
   pino/winston — its single home); `console.log` in server code paths
   is a defect; debug modules are dev-only.
2. Every request carries a correlation ID from entry to exit (middleware
   in, response header out); log lines without correlation are defects.
3. Levels are configuration, not code — debug in development, info+ in
   production; hardcoded level filters are defects, and sampling rules
   live in the logger's config home.
4. Sensitive fields (tokens, secrets, PII) never appear in logs — the
   redaction list lives in the logger's serializer config (single home;
   A08/A35 discipline).
5. Errors log once, at the boundary that handles them, with stack and
   cause chain — the same error re-logged at every frame is a defect.
6. Metrics and traces follow the app's observability home
   (OpenTelemetry or equivalent); profiling (flamegraphs, event-loop
   diagnostics) is a measurement step, never a permanent probe (A34
   profile-first discipline).
7. A final machine-readable line records exit status on shutdown (A41).

## Enforcement

- `web_test`: log guard specs (correlation, redaction); review applies
  the single-logger rule (A13).

## Agent Digest

- One structured-JSON logger (single home); console.log in server paths is a defect; debug modules are dev-only.
- Correlation IDs run entry to exit — uncorrelated lines are defects.
- Levels are config, never code; sensitive fields are redacted via the serializer home (A08/A35).
- Errors log once at the handling boundary, with stack and cause chain.
- Profiling is a measurement step, never a permanent probe (A34); the final log line records exit status (A41).
