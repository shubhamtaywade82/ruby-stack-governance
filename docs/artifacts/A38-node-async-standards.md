# A38 — Node.js Async and Event-Loop Standards

**Layer:** runtime · **Stacks:** nodejs · **Mirror:** node-async-standards

## Scope

Event-loop discipline, promise hygiene, cancellation, bounded concurrency,
and the boot validators that make async failures visible.

## Standards

1. The event loop is the contract: no synchronous I/O or CPU-bound work on
   request paths (`fs.*Sync`, sync crypto variants, huge `JSON.parse`) —
   blocking the loop blocks every request.
2. CPU-bound work runs in worker threads or child processes with bounded
   pools; unbounded per-request spawning is a defect.
3. Every promise chain terminates: a boot validator installs
   `process.on('unhandledRejection')` that crashes in development and
   fails the suite — silent rejections are defects (A20 discipline).
4. Cancellation is explicit: long operations accept `AbortSignal` and
   clean up timers, sockets, and subscriptions; orphaned timers and
   interval leaks are defects (A26 cleanup discipline).
5. Concurrency over collections is bounded (pool/map with explicit
   sizes); unbounded `Promise.all` over user-controlled collections is a
   defect.
6. Callback-style APIs are promisified once at the boundary
   (`util.promisify`), not re-wrapped ad hoc; error-first callbacks exist
   only at the FFI edge.
7. External handles (sockets, workers, watchers) close on error paths —
   a success path that closes and an error path that leaks is a defect.

## Enforcement

- `web_test`: boot validator specs and leak guards run in the standard
  suite (A18 discipline); review applies loop-blocking rules (A13).

## Agent Digest

- The event loop is the contract — no sync I/O or CPU-bound work on request paths.
- CPU-bound work goes to bounded worker pools; unbounded per-request spawning is a defect.
- Unhandled rejections fail boot and the suite (A20 discipline) — every promise chain terminates.
- Cancellation is explicit (AbortSignal) — orphaned timers, sockets, and subscriptions are leaks (A26).
- Concurrency over user-controlled collections is bounded; callback APIs are promisified once at the boundary.
