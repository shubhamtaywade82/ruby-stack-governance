# PR Ladder

One PR per enforcement increment; every PR is green before the next begins
(gates never land red). R6 ladder (PRs #1–#12) + R9 additions (#13–#15).
Weeks refer to `docs/W5H_TIMELINE.md`.

| PR | Week | Contents | Gates / ratchets introduced |
|----|------|----------|------------------------------|
| #1 | W1 | Bootstrap: configs, registries, CI skeleton, lock file | all self gates wired |
| #2 | W1 | Final `.rubocop.yml` + empty todo baseline policy | `rubocop`; todo ratchet |
| #3 | W2 | RSpec guard suite + SimpleCov wiring (app) | `rspec_guard`; coverage ratchet |
| #4 | W2 | PR template, labels, hooks, IP tracker | process layer |
| #5 | W3 | Brakeman, bundler-audit, Packwerk adoption (app) | `brakeman`, `packwerk` |
| #6 | W3 | Monitoring, death handlers, health endpoints (app) | runtime guards |
| #7 | W4 | Query optimization guards + Bullet (app) | N+1 ban enforcement |
| #8 | W4 | Secrets: credentials home, ENV allowlist, boot validator | secrets gates |
| #9 | W5 | API versioning + swagger drift gate (app) | `swagger_drift` |
| #10 | W6 | Caching standards adoption (app) | cache review checklist |
| #11 | W6 | Docs repo (W5H), YARD ratchet | `yard_coverage` |
| #12 | W7 | Slow query monitoring + QueryCountTracker (app) | query budgets |
| #13 | W8 | Naming (`ruby-stack-governance`), MANIFEST.yml, `config/gates.yml` | metadata single homes |
| #14 | W8 | MCP server + harness wiring + contract snapshot | `mcp_contract` |
| #15 | W8 | Skills mirror generator + coverage ratchet | `agent_mirror`; `skills_corpus_coverage` |

## Parallel track

Round-8 corpus merge (ruby-agent-skills diff vs R5; react-agent-skills full
pass) lands as artifacts **A25+** and feeds the React skill set; it slots into
PR #15 without blocking the ladder.
