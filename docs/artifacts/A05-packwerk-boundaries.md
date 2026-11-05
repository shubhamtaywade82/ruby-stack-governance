# A05 — Packwerk Boundaries Standards

**Layer:** static · **Stacks:** ruby, rails · **Mirror:** scheduled (W8 ratchet)

## Scope

Package structure and the static boundary discipline for the target app.

## Standards

1. Code is organized into packs with explicit public APIs; private constants
   are enforced, not aspirational.
2. Dependencies are one-directional by layer: packs may depend inward
   (toward shared foundations), never outward.
3. Public API surfaces are declared files; anything else is private and a
   boundary violation to reference.
4. New violations are inadmissible; the `packwerk_todo` baseline only shrinks
   (ratchet `packwerk_violations`).
5. A pack is the unit of review: PRs that cut across packs carry the
   `packwerk` label and a boundary note.

## Enforcement

- `packwerk` gate in the app's CI (A21 for the exact wiring and todo policy).

## Deterministic fixes

- Cross-pack reference → expose an explicit public API or move the constant.
- Circular dependency → extract shared foundation to the innermost layer.
