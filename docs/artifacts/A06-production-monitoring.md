# A06 — Production Monitoring Standards

**Layer:** runtime · **Stacks:** rails · **Mirror:** scheduled (W8 ratchet)

## Scope

Error tracking, metrics, dashboards, alert routing, and review cadence for
production.

## Standards

1. Every unexpected exception reaches the error tracker exactly once, with
   request/job context (A03).
2. The monitoring stack is chosen by the A01 map — one tool per mandate.
3. Alerts are actionable: routed to owning teams, with runbook links; a
   non-actionable alert is deleted, not muted.
4. Health endpoints cover liveness and readiness separately; boot validation
   failures are startup failures (A20), not metrics.
5. Queue depth, deadset growth, and query latency get dashboards from day
   one (A11/A14 feed them).
6. Weekly review cadence: slowest queries, deadset growth, alert
   volume — one owner, one page of notes, committed to the app repo.

## Enforcement

- Review cadence is on the W5H weekly clock; dashboards are PR-reviewed
  infrastructure, not click-ops.

## Deterministic fixes

- Alert without a runbook link → write the runbook or delete the alert.
- Error reported twice (middleware + job wrapper) → report at one boundary
  only.
