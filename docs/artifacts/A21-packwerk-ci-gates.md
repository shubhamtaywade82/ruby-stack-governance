# A21 — Packwerk CI Gates

**Layer:** static · **Stacks:** ruby, rails · **Mirror:** scheduled (W8 ratchet)

## Scope

Exact CI wiring for boundary enforcement in the target app (structure per A05).

## Standards

1. The gate runs `bin/packwerk check` (plus privacy) on every PR touching
   `app/packs/**`.
2. Violations are recorded in `packwerk_todo.yml` — the one-way baseline
   (ratchet `packwerk_violations`); adding a violation to the todo in a PR
   requires the `packwerk` label and a shrink note.
3. The baseline must shrink when a PR resolves violations — Boy Scout
   applies to boundaries exactly as to RuboCop todos.
4. The gate fails on any violation absent from the todo; "allow in CI,
   fix later" is inadmissible.

## Enforcement

- `packwerk` gate (`config/gates.yml`, app context); ratchet on the weekly
  clock.

## Deterministic fixes

- Boundary violation → expose a public API (A05), move the constant inward,
  or inject the dependency at the edge — never suppress the check.
