# A12 — Static Analysis Suite Standards

**Layer:** static · **Stacks:** ruby · **Mirror:** never (enforced by gates, not context)

## Scope

The static gate set every Ruby commit passes, in both this repo and the
target app.

## Standards

1. RuboCop >= 1.72 with the `plugins:` syntax (A17 for the plugin set);
   `require:` is forbidden.
2. Cop limits live in `.rubocop.yml` — the single home (Law 3); the todo
   baseline is empty here and only shrinks in adopting apps (Boy Scout, A13).
3. reek runs on `lib`/`exe` surfaces with the checked-in `.reek.yml`.
4. rubycritic score floor is ratcheted (`rubycritic_minimum_score`) — the
   floor lives in `docs/ratchets.yml` and the gate in `config/gates.yml`.
5. Brakeman at zero warnings — hard gate, no baseline, no severity carve-outs.
6. bundler-audit gates the lock file; weekly automated dependency-bump PRs
   keep the audit meaningful.
7. NewCops are enabled: an opinionated default beats a frozen config that
   nobody maintains.

## Enforcement

- All of the above run in CI (`enforcement` workflow here; equivalent in the
  app) — no local-only gates, no advisory-only gates.

## Deterministic fixes

- New cop flags valid existing code → fix the code, or add the file to the
  todo baseline with a shrink deadline in the PR description.
- Audit advisory without patch → pin away with a comment record; a comment
  without a pin is a lie.
