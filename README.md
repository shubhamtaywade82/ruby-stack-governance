# Ruby Stack Governance

**Engineering standards as a deterministic enforcement system.**
Ruby 3.3 · Rails ~> 7.2 (8.1 adopted as the next track) · RuboCop >= 1.72
(`plugins:` syntax only).

The training corpus is an **Executable Knowledge Base**: every rule has exactly
one home, every home has a one-way ratchet, every generated mirror has a drift
gate, and AI agent harnesses (Claude Code, Cursor Agent CLI) can query the
whole thing live over MCP.

## The five layers

| # | Layer | Holds |
|---|-------|-------|
| 1 | static | RuboCop + 8 plugins, reek, rubycritic, Brakeman, bundler-audit, Packwerk |
| 2 | runtime | guard specs, SimpleCov, mutant, Bullet, boot validators, death handlers, QueryCountTracker |
| 3 | process | PR template, labels, hooks, IP tracker, Boy Scout rule |
| 4 | agent-context | `.claude/skills/*`, `.cursor/rules/*`, `AGENT_CONTEXT.md` — generated, gated |
| 5 | agent-interface | read-only MCP server (stdio): 9 tools over the corpus |

Start with `docs/LAWS.md` — the six laws decide every dispute. Then
`docs/ENFORCEMENT.md` (the runbook), `docs/PR_LADDER.md`, `docs/W5H_TIMELINE.md`.

## Repo map

| Path | Role |
|------|------|
| `docs/artifacts/` | the corpus — A01–A24 (+ `MANIFEST.yml`, the machine index) |
| `docs/ratchets.yml` | single home for every ratchet target |
| `config/gates.yml` | single home for gate commands |
| `.rubocop.yml` | single home for code limits |
| `.ruby-version` | single home for the Ruby version |
| `lib/`, `exe/`, `bin/` | the MCP server + mirror generator + binstubs |
| `spec/mcp/` | pinned wire contract + idempotency + gate-allowlist specs |
| `.claude/`, `.cursor/`, `AGENT_CONTEXT.md`, `.cursorrules` | generated mirrors — do not hand-edit |

## Quickstart (human)

```sh
bin/setup          # bundle install + git hooks
bin/rake agent:mirror:check   # verify mirrors are in sync
bundle exec rspec spec/mcp    # contract specs
```

## Quickstart (agent harness)

- **Claude Code**: open the repo — `.mcp.json` offers the `ruby-stack-governance`
  server (approve once); `.claude/skills/*` auto-loads on relevant files.
- **Cursor**: `.cursor/mcp.json` wires the same server; `.cursor/rules/*.mdc`
  attach by glob.
- **Any MCP client**: `bin/ruby-stack-governance-mcp` over stdio.

All tools are **read-only**: `list_artifacts`, `get_artifact`,
`search_corpus`, `get_limit`, `get_ratchet`, `get_versions`,
`get_todo_baseline`, `resolve_violation`, `run_gate` (allowlisted registry
only — array argv, never a shell). The process layer (PR + gates) remains the
only write path.

## Golden path

```text
agent edits app/sidekiq/invoice_sync_job.rb
  → sidekiq-job-standards skill fires (idempotency, retry, death handler)
  → agent calls run_gate("rubocop") → 0 offenses
  → agent calls get_ratchet("simplecov_coverage") → reads the real target
  → PR: Boy Scout confirmed, mirrors regenerated, labels applied
```

## Status

- R1–R10 merged; **A25+ reserved** for the pending corpus merge
  (`ruby-agent-skills` diff + `react-agent-skills` full pass — React stack).
- `skills_corpus_coverage` ratchet: mirrored artifacts vs scheduled —
  read `docs/ratchets.yml`.
- Gemfile.lock commits in the first bootstrap PR (`bundle install`).
