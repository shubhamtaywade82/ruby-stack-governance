# A01 — Tooling Map and Selection Standards

**Layer:** static · **Stacks:** ruby · **Mirror:** never (internal reference)

## Scope

Which tool owns which job. One tool per mandate (Law 1 applied to tooling);
gaps and overlaps are resolved here, once, deterministically.

## Standards

1. Style/complexity → RuboCop + plugins (A17). Metrics budgets live in
   `.rubocop.yml` — nowhere else.
2. Smell scanning → reek (whole-file design smells; complements RuboCop,
   never duplicates its cops).
3. Maintainability score → rubycritic (score floor ratcheted via
   `docs/ratchets.yml`).
4. Security (static) → Brakeman: zero warnings, hard gate, no baseline.
5. Dependency CVEs → bundler-audit: gate runs against `Gemfile.lock`.
6. Architecture boundaries → Packwerk (A05/A21).
7. Coverage → SimpleCov; mutation testing → mutant on core POROs (A04/A18).
8. N+1 detection → Bullet in the test suite (A07).
9. Background jobs → Sidekiq (A02/A14); caching → Rails cache (A10/A23);
   API contracts → rswag + drift gate (A22).
10. Agent context → mirrors (A16); agent queries → the MCP server (R9/D-decisions).

## Prohibition

If two tools enforce the same rule, one is removed in this artifact's next
revision. "Redundant enforcement" is a defect with two homes (Law 1).

## Enforcement

- Registry of gate commands: `config/gates.yml` (single home).
- Tool adoption/removal = `docs-corpus` PR editing this artifact only.
