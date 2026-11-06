# Changelog

## 1.3.0 — node skill-pack ecosystem corpus merge (A45–A47)

The pack layer of the Node ecosystem lands in the corpus, grounded in the
[node-agent-skills](https://github.com/shubhamtaywade82/node-agent-skills)
pack (manifest schema v3) — the third governed companion pack alongside
ruby-agent-skills and react-agent-skills. No Ruby code changed — the MCP
contract stays v1.0.0; every addition is corpus data.

- 3 new artifacts, all `mirror: true`:
  - **A45** skill-pack format + manifest governance — one SKILL.md per
    skill with strict-YAML-valid frontmatter (bare `": "` in descriptions
    is a defect: v3 cross-pack loaders parse real YAML), manifest↔filesystem
    1:1 sync, the v3 `adapter_skills`/`adapters` structural split, per-skill
    semver independent of the pack version, `node-` namespace prefixes,
    counts derived never hardcoded.
  - **A46** distribution + release discipline — allowlist payloads,
    checksums + version/source identity on every distribution, generated
    artifacts as gated derived outputs (Laws 4–6 applied to the pack),
    releases never weaken gates, zero-dependency additive-only runtime.
  - **A47** cross-pack integration (stacks: ruby, react, nodejs; layer:
    agent-interface) — declared companions with pinned refs + snapshotted
    manifests, symmetric seam skills, additive-only schema evolution
    (v3 superset of v1/v2), eval-gated `route_cross_pack` routing, and
    collision registries for names and triggers.
- 3 Claude skills + 3 Cursor rules generated; `AGENT_CONTEXT.md`
  reindexed to 47 artifact rows. Mirrors byte-stable (Law 6).
- `skills_corpus_coverage` ratchet: 68 → 70 (30 of 43
  mirrored-or-scheduled now mirrored).

## 1.2.0 — nodejs stack corpus merge

The Node.js stack lands in the corpus (A37–A44), grounded in the
Awesome Node.js domains (streams, control flow, logging, testing,
security, process management, queues). No Ruby code changed — the MCP
contract stays v1.0.0; every addition is corpus data.

- 8 new artifacts, all `mirror: true`: modules/packages (ESM-first,
  engines as the runtime pin home), async and event loop (no sync I/O on
  request paths, unhandled-rejection boot validators), streams and
  backpressure (pipeline over pipe, nothing large buffered), HTTP
  services (timeouts, error envelopes, graceful drain ordering), process
  and runtime (signals, config-at-boot, child-process argv discipline,
  queues follow A14), logging and observability (one structured logger,
  correlation IDs, redaction homes), service testing (boundary exercise,
  network mocked at the edge, guards in the standard suite), and server
  security (helmet-style headers, timing-safe secrets, centralized
  guard chains, frozen installs).
- 8 Claude skills + 8 Cursor rules generated; `AGENT_CONTEXT.md`
  reindexed to 44 artifact rows. Mirrors byte-stable (Law 6); drift gate
  green.
- `skills_corpus_coverage` ratchet: 59 → 68 (27 of 40 mirrored-or-
  scheduled now mirrored).
- Gates registry `app` comment: "target application (Rails, web, or
  node service)" — the registered web_* gates and `npm_audit` resolve
  for node checkouts via the A37 script-naming convention.

## 1.1.0 — R8: react stack corpus merge

The react stack lands in the corpus (A25–A36), distilled from the
react-agent-skills pack. No Ruby code changed — the MCP contract stays
v1.0.0 and the nine tools are untouched; every addition is corpus data.

- 12 new artifacts, all `mirror: true`: component engineering, hooks and
  effects, state management, data fetching + Server Components, forms,
  testing, E2E + visual, TypeScript contracts, accessibility,
  performance, security + supply chain, and agent evaluation.
- 12 Claude skills + 12 Cursor rules generated; `AGENT_CONTEXT.md`
  reindexed to 36 artifact rows. Mirrors byte-stable (Law 6); drift gate
  green.
- `skills_corpus_coverage` ratchet: 35 → 59 (19 of 32 mirrored-or-
  scheduled now mirrored).
- Gates registry (`app` context, now "target application — Rails or
  web"): `npm_audit`, `web_e2e`, `web_lint`, `web_test`, `web_typecheck`
  — resolvable by `run_gate` inside a web app checkout that adopts this
  corpus.
- New ratchet: `axe_violations` (scope web; home — the E2E axe suite,
  A31/A33).

## 1.0.2 — enforcement pipeline green

The bootstrap shipped a Gemfile CI could never install and code that had never
been linted. Fixed in one pass and verified on Ruby 4.0.6 — the exact
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
- Gate results on the 4.0.6 pipeline: rubocop 0 offenses, reek 0 warnings,
  rubycritic 83.58 (min 80), bundler-audit clean, mirror drift clean,
  9 rspec examples green.
- Ruby toolchain: `.ruby-version` (single home, Law 1) reads 4.0.6 and both
  workflows pin `ruby-version: "4.0.6"`; setup-ruby installs it cleanly on
  ubuntu-24.04, so the earlier "not a real release" note was wrong and the
  interim 3.3.7 pin was superseded. The gate results above are verified
  against the 4.0.6 green runs — version claims are verified, never
  invented (R7).

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
