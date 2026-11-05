# Changelog

## 1.0.2 — enforcement pipeline green

The bootstrap shipped a Gemfile CI could never install and code that had never
been linted. Fixed in one pass and verified on Ruby 3.3.7 — the exact
toolchain the workflows run:

- `rubocop-bundler` (a gem that does not exist on rubygems.org) replaced by
  `rubocop-packaging` — Gemfile, `.rubocop.yml`, A17. Bundler cops ship in
  rubocop core; the eight-plugin canon stays intact.
- `Gemfile.lock` committed for the first time (`bundler-audit` requires it).
- `.rubocop.yml`: obsolete `RSpec/FilePath` split into its successors;
  justified disables for Rails cops that presuppose a Rails app or
  ActiveSupport; rescued-variable preference reconciled with reek.
- `.reek.yml`: recorded exclusions for the fast-mcp DSL `call` handlers and
  the mirror path constants (each justified inline).
- Specs: `spec_helper` bootstrap pattern (satisfies the Packaging cop);
  one invalid matcher fixed.
- `lib/`: lint debt paid — communicative names, hoisted duplicate reads,
  extracted helpers, truthiness checks.
- Gate results at this commit: rubocop 0 offenses, reek 0 warnings,
  rubycritic 83.58 (min 80), bundler-audit clean, mirror drift clean,
  9 rspec examples green.

## 1.0.1 — R11: organization name retired

Per owner directive, the organization name is retired repo-wide — human name,
module directory (`lib/ruby_stack_governance/`), and MCP binstubs
(`bin/ruby-stack-governance-mcp`, `exe/ruby-stack-governance-mcp`).
One home for names: `docs/NAMING.md`. Audit rule: the retired string must
return zero hits across the tree, dotfiles included.

## 1.0.0 — R1–R10 corpus bootstrap

Initial import of the engineering training corpus enforcement system.

- 24 governance artifacts (A01–A24) + `MANIFEST.yml` machine index
- Six universal laws (`docs/LAWS.md`); five-layer enforcement model
- Final `.rubocop.yml` (RuboCop >= 1.72, `plugins:` syntax, 8 plugins)
- Single-home registries: `docs/ratchets.yml`, `config/gates.yml`
- MCP server v1.0.0 (stdio, tools-only, read-only, 9 tools) +
  pinned wire contract (`spec/mcp/contract_snapshot.yml`)
- Generated mirrors: 7 Claude skills, 8 Cursor rules (00-core + 7),
  `AGENT_CONTEXT.md`, legacy `.cursorrules` — drift-gated
- CI: `enforcement` (rubocop, reek, rubycritic, bundler-audit) +
  `agent-interface` (mirror drift, MCP contract specs)
- Pre-commit `.githooks/` (whitespace + mirror drift when artifacts staged)
- Platform name: `ruby-stack-governance` (R10; the earlier proposal is
  superseded — one home for names, see `docs/NAMING.md`)

**Reserved**: A25+ for the R8 corpus merge (ruby-agent-skills diff,
react-agent-skills full pass — React stack).

MCP contract v1.0.0 — any tool-signature change requires a version bump and an
entry in this file (gate `mcp_contract`).
