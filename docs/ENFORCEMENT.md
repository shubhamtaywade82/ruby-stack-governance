# ENFORCEMENT — The Runbook

Ruby Stack Governance: the engineering training corpus as a deterministic
enforcement system. Baseline: Ruby 4.0 / Rails ~> 7.2 / RuboCop >= 1.72
(`plugins:` syntax). Rails 8.1 is adopted as the next upgrade track (R7).

## W5H

- **What** — a five-layer enforcement system over the standards corpus
  (24 artifacts, `docs/artifacts/`).
- **Why** — lint rules rot when they live far from the knowledge that justifies
  them. This repo keeps the knowledge, the gate, and the ratchet in one
  deterministically linked structure.
- **Who** — every engineer authoring Ruby/Rails (and, from A25+, React) code;
  every AI agent harness (Claude Code, Cursor Agent CLI) operating on the repo.
- **When** — gates run on every push and PR; ratchets move weekly
  (`docs/W5H_TIMELINE.md`); mirrors regenerate on every corpus edit.
- **Where** — CI (`.github/workflows/`), pre-commit (`.githooks/`), and the MCP
  server (stdio, `bin/ruby-stack-governance-mcp`).
- **How** — the six laws (`docs/LAWS.md`) decide every dispute; the registry
  files below own every number and command.

## The five layers

| # | Layer | What it holds | Primary gates |
|---|-------|---------------|---------------|
| 1 | static | RuboCop + plugins, reek, rubycritic, Brakeman, bundler-audit, Packwerk | `rubocop`, `reek`, `rubycritic`, `brakeman`, `bundle_audit`, `packwerk` |
| 2 | runtime | guard specs, SimpleCov, mutant, Bullet, boot validators, death handlers, QueryCountTracker | `rspec_guard`, `mutant_core` |
| 3 | process | PR template, labels, hooks, IP tracker, Boy Scout rule | pre-commit, PR review |
| 4 | agent-context | skills and rules mirrors injected into harnesses | `agent_mirror` |
| 5 | agent-interface | read-only MCP tools over the corpus | `mcp_contract` |

("RuboCop Governance" is the Layer 1 chapter title — not the platform name;
see `docs/NAMING.md`.)

## Registries (single homes — Law 3)

| Kind | File | Read via |
|------|------|----------|
| Gate commands | `config/gates.yml` | `run_gate` |
| Ratchet targets | `docs/ratchets.yml` | `get_ratchet` |
| Code limits | `.rubocop.yml` | `get_limit` |
| Ruby version | `.ruby-version` | `get_limit("ruby_version")` |
| Gem pins | `Gemfile.lock` (bootstrap PR #1) | `get_versions` |
| Artifact metadata | `docs/artifacts/MANIFEST.yml` | `list_artifacts` |

Docs and code reference names and pointers — they never duplicate values.

## Gate contexts

- `self` gates run in this repo's CI: `rubocop`, `reek`, `rubycritic`,
  `bundler_audit`, `mcp_contract`, `agent_mirror`.
- `app` gates run inside a target Rails application that adopts this corpus:
  `rubocop`, `brakeman`, `bundle_audit`, `packwerk`, `rspec_guard`,
  `mutant_core`.

## Todo baseline and the Boy Scout rule

`.rubocop_todo.yml` seeds **empty** and must stay empty in this repo. A target
app adopting the corpus merges its own baseline, which then only shrinks:
a PR that touches a listed file must remove that entry (Boy Scout rule).
Agents can inspect the state via `get_todo_baseline`.

## Weekly ratchet cadence

Ratchets move every Monday, one direction only, with values read from
`docs/ratchets.yml`. A ratchet change is a PR with the `ratchet` label that
updates exactly the owning registry file — nothing else.

## PR process

1. The template (`.github/PULL_REQUEST_TEMPLATE.md`) enforces the checklist.
2. Labels: `ratchet`, `todo-baseline-change`, `mcp-contract-change`,
   `packwerk`, `query-budget`, `docs-corpus`, `react`.
3. IP tracker: pasted third-party code is inadmissible without a license
   record (A13).
4. Corpus edits (`docs/artifacts/**`, `docs/ratchets.yml`) require
   `bin/rake agent:mirror` + regenerated mirrors in the same PR (pre-commit
   and `agent_interface` CI gate it).

## Agent harness wiring

- **Claude Code** — `.mcp.json` (project scope, one-time approval) +
  `.claude/skills/*` auto-discovered.
- **Cursor Agent CLI** — `.cursor/mcp.json` + `.cursor/rules/*.mdc`
  (glob-attached) + legacy `.cursorrules` (generated, gated).
- Any MCP client — stdio via `bin/ruby-stack-governance-mcp`. All tools read-only (D3);
   the process layer remains the only write path.

## Bootstrapping (first PR in a fresh clone)

```sh
bin/setup                       # bundle install + hooks
bundle install && git add Gemfile.lock   # lock commits in bootstrap PR #1
```
