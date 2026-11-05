# W5H Timeline — 8 Weeks

The adoption sequence for one target Rails application. Ratchet values live in
`docs/ratchets.yml` — this file never restates a number (Law 3).

| Week | Focus | Ladder | Exit criteria |
|------|-------|--------|---------------|
| W1 | Static floor | PR #1, #2 | CI green on all self gates; todo policy live |
| W2 | Test floor | PR #3, #4 | guard suite runs in standard CI; PR checklist enforced |
| W3 | Security floor | PR #5 | Brakeman at zero; audit gate live; Packwerk baseline recorded |
| W4 | Data layer | PR #6, #7, #8 | death handlers wired; N+1 bans enforced; secrets boot-validated |
| W5 | API surface | PR #9 | versioning rules enforced; swagger drift gate green |
| W6 | Performance | PR #10, #11 | caching standards adopted; docs ratchet armed |
| W7 | Observability | PR #12 | query budgets tracked; slow query review cadence live |
| W8 | Agent interface | PR #13, #14, #15 | MCP contract pinned; skills coverage ratchet at target |

## Cadence

- **Monday ratchet**: values move in `docs/ratchets.yml`, direction one-way.
- **Boy Scout**: every PR shrinks the todo baseline it touches.
- **Corpus edits**: regenerate mirrors (`bin/rake agent:mirror`) in the same
  PR — the drift gate makes stale mirrors unmergeable.
