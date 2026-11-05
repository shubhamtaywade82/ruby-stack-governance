# Naming Decisions

One home for names: this file records every naming decision, most recent first.

## R11 — the organization name is retired

Per owner directive, the organization name is removed from the repo — contents,
paths, and binaries, dotfiles included. A retired name is deleted, not archived:
it is not repeated in this file either. Replacements:

- Human name: **Ruby Stack Governance**
- Ruby module: `RubyStackGovernance` — `lib/ruby_stack_governance/`
- MCP binstubs: `bin/ruby-stack-governance-mcp` (wrapper) and
  `exe/ruby-stack-governance-mcp` (server)
- MCP server id: `ruby-stack-governance` (registered in `.mcp.json`,
  `.cursor/mcp.json`)

Audit rule: a case-insensitive search for the retired string returns zero hits
in the tree, dotfiles included. Future renames go through this file first, then
one PR that moves every home at once (Law 1).

## R10 — platform name follows the repo: `ruby-stack-governance`

The earlier proposal is superseded by the chosen repository name
`ruby-stack-governance`:

- Human name: **Ruby Stack Governance**
- MCP server id: `ruby-stack-governance` (registered in `.mcp.json`,
  `.cursor/mcp.json`)
- Ruby module: `RubyStackGovernance`
- Mirror namespace: `.claude/skills/*`, `.cursor/rules/*`

The rule that survives: platform names never contain a single tool's name
("RuboCop Governance" demoted to the Layer 1 chapter title in
`docs/ENFORCEMENT.md`), and stack-neutral wording admits new stacks (React
corpus lands at A25+ — see `docs/artifacts/MANIFEST.yml`).
