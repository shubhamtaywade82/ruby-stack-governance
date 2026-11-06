# A36 — Agent Evaluation Standards

**Layer:** process · **Stacks:** react · **Mirror:** agent-evaluation-standards

## Scope

Evaluating AI-agent-assisted frontend changes: PR scoring on observable
evidence, adversarial probes, and multi-turn workspace assessments.

## Standards

1. Agent output is evaluated on observable evidence — gates, tests, and
   diffs — never on the agent's self-description; "it should work" is
   not evidence.
2. Every agent-assisted PR passes the same gates as human PRs
   (`web_lint`, `web_typecheck`, `web_test`, `web_e2e`) — no machine
   exemptions (A13).
3. Scope discipline is scored: changes outside the requested scope are
   flagged, and self-serving test changes (editing tests to pass rather
   than fixing behavior) block the PR.
4. Adversarial probes run against agent changes: prompt injection through
   content and data, secret exposure, unsafe dependency suggestions,
   scope creep; one probe set per repo is the single home.
5. Multi-turn work is scored per turn on persistent workspace state —
   failure recovery and review-driven repair are scored behaviors, not
   best-effort extras.
6. Results are recorded per PR with the label taxonomy (A13) — a trend
   line, not vibes.

## Enforcement

- Process layer (A13): full gate set on every agent PR; the probe set's
  single home; per-PR evaluation labels.

## Agent Digest

- Evidence over self-description — gates and diffs decide; "it should work" is not evidence.
- Agent PRs run the full gate set (web_lint, web_typecheck, web_test, web_e2e) — no machine exemptions (A13).
- Scope discipline scored — out-of-scope changes flagged; self-serving test changes block the PR.
- Adversarial probes (injection, secrets, unsafe deps, scope creep) run from one probe-set home.
- Multi-turn turns are scored on recovery and review-driven repair; results recorded per PR (A13 labels).
