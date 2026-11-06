# A39 — Node.js Streams and Backpressure Standards

**Layer:** runtime · **Stacks:** nodejs · **Mirror:** node-streams-standards

## Scope

Streaming large payloads, pipeline composition, backpressure, watchers,
and transport-edge compression.

## Standards

1. Payloads beyond the app's committed threshold (single home) stream —
   buffering large files into memory (`fs.readFile` of uploads, buffering
   whole responses) is a defect.
2. `stream.pipeline` (or async iteration) composes streams; bare `.pipe()`
   chains without error propagation are defects — one stream's error must
   fail the whole pipeline.
3. Backpressure is honored, never fought: `write()` returns are awaited
   and `highWaterMark` respected; draining via ever-growing buffers hides
   a broken consumer.
4. Transform steps are single-purpose and composable; a transform that
   also orchestrates I/O is a defect — extract.
5. Filesystem watchers debounce events and close on shutdown; watcher
   leaks are defects (A38).
6. Compression (gzip/brotli) happens once, at the transport edge, with
   negotiated encodings — double compression is a defect.

## Enforcement

- `web_test`: pipeline tests with injected stream errors; review applies
  the streaming-over-buffering rule (A13).

## Agent Digest

- Large payloads stream — buffering past the app's committed threshold is a defect.
- stream.pipeline or async iteration composes; bare pipe() without error propagation is a defect.
- Backpressure is honored — await write() returns, respect highWaterMark; buffer growth hides a broken consumer.
- Transforms are single-purpose; watchers debounce and close on shutdown (A38).
- Compression happens once, at the transport edge, negotiated.
