# A17 — RuboCop Plugin Conventions

**Layer:** static · **Stacks:** ruby · **Mirror:** scheduled (W8 ratchet)

## Scope

The plugin set, cop-enablement policy, and cop-change process.

## Standards

1. RuboCop >= 1.72 with the `plugins:` syntax only; `require:` is forbidden
   — enforcement here is the parse itself (old syntax fails to load).
2. The eight plugins, each earning its gate: rubocop-rails, rubocop-rspec,
   rubocop-performance, rubocop-thread_safety, rubocop-bundler,
   rubocop-rake, rubocop-capybara, rubocop-factory_bot.
3. A plugin is admitted by the A01 rule (one tool per mandate) and removed
   when it duplicates another's cops.
4. NewCops: enable — a new opinionated cop is a standards decision recorded
   in the PR that suppresses or adopts it, never a silent CI change.
5. Cop limit values live in `.rubocop.yml` alone (Law 3); a limit change is
   a `docs-corpus`-labelled PR.
6. Custom cops are inadmissible until a contract spec pins them — a custom
   cop without a spec is an unversioned opinion.

## Enforcement

- `rubocop` gate; plugin presence asserted by Gemfile + `plugins:` parse.

## Deterministic fixes

- Cop disagreement with corpus → corpus wins in A-revision, then cop config
  follows; never the reverse.
