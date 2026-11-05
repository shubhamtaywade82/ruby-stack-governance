# By approving this PR you confirm, per Ruby Stack Governance (docs/ENFORCEMENT.md):

- [ ] All gates green: CI `enforcement` + `agent-interface` workflows pass.
- [ ] **Boy Scout**: every file this PR touches is out of `.rubocop_todo.yml`
      (or the entry is removed here).
- [ ] No number was restated: limits/ratchets/gate commands changed **only** in
      their single home (`.rubocop.yml`, `docs/ratchets.yml`, `config/gates.yml`).
- [ ] Corpus edits: `bin/rake agent:mirror` regenerated and mirrors committed.
- [ ] IP tracker: no third-party code pasted without a license record (A13).

## Labels (at least one)

- [ ] `ratchet` — moves a `docs/ratchets.yml` value (one-way, tightening only)
- [ ] `todo-baseline-change` — shrinks the todo baseline
- [ ] `mcp-contract-change` — tool signature change; bumps `MCP::VERSION` + CHANGELOG
- [ ] `packwerk` — package boundary change
- [ ] `query-budget` — per-endpoint budget change
- [ ] `docs-corpus` — artifact content change
- [ ] `react` — A25+ React corpus (pending R8 merge)
