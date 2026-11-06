# A41 — Node.js Process and Runtime Standards

**Layer:** runtime · **Stacks:** nodejs · **Mirror:** node-process-standards

## Scope

Runtime version management, signals, process managers, boot-time config
validation, child processes, and background queues.

## Standards

1. The Node runtime is managed by one tool (nvm/fnm/nodenv — the app's
   choice is its single home) with one pin file (`.nvmrc` or
   `engines.node`) — ad-hoc runtime installs are defects (R7 discipline).
2. Signals are handled honestly: SIGTERM triggers the graceful drain
   (A40 order); SIGINT exits cleanly in development; handlers that
   swallow a signal and continue are defects.
3. One process manager in production (the app's chosen pm2/systemd/
   container supervisor — single home); watch modes (nodemon, tsx watch)
   are dev-only, never production.
4. Environment config is read once at boot, validated against a schema
   (A32), and exposed typed — scattered `process.env` reads deep in
   modules are defects (A20 boot-validation discipline; secrets follow
   A08).
5. Child processes: array argv only, `shell: true` never with
   user-derived input (A44), stdio wired, exit codes checked — spawned
   and forgotten children are defects.
6. Exit is meaningful: uncaught errors exit non-zero with a final
   machine-readable log line (A42); silent hangs are defects.
7. Background queues (bull/bullmq/bree and friends) follow A14's job
   law — idempotency, explicit retries, death handlers; the queue
   library is transport, A14 is the standard.

## Enforcement

- `web_test`: signal and boot validator specs; review applies the
  runtime and queue rules (A13).

## Agent Digest

- One runtime manager, one pin file (.nvmrc/engines.node) — verified in CI, never guessed (R7).
- SIGTERM = graceful drain in A40 order; handlers that swallow signals and continue are defects.
- Watch modes are dev-only; one production process manager, written in the app's home.
- Config is read once at boot, schema-validated, typed (A20/A08 discipline) — deep process.env reads are defects.
- Child processes: array argv, shell true never with user input (A44), exit codes checked.
- Queues follow A14 — idempotency, retries, death handlers; the library is transport, A14 is the law.
