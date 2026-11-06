# A25 — React Component Engineering Standards

**Layer:** static · **Stacks:** react · **Mirror:** react-component-standards

## Scope

Designing, implementing, and reviewing React component APIs, props,
composition boundaries, reusable UI primitives, and component-level
contracts.

## Standards

1. Components are single-purpose and named for what they render; a
   component that fetches, formats, and lays out in one body is a defect —
   extract until each part has one reason to change.
2. Props are a typed contract: an explicit interface, no `...rest`
   pass-through except deliberate boundary forwarding, and no boolean
   traps — two props that cannot be true together are a discriminated
   union (A32).
3. Composition over configuration: variants via children and slots, not an
   ever-growing options object.
4. Render is pure: no DOM writes, no subscriptions, no side effects outside
   effects. StrictMode double-render is the norm and must never break
   behavior (compiler-compatible rendering, A26).
5. Shared UI primitives live in the design-system layer with tokens and
   variants; feature components never import from another feature's tree —
   module ownership mirrors the packwerk discipline of A05.
6. `dangerouslySetInnerHTML` is banned; untrusted content goes through the
   security controls of A35.
7. Values derivable at render time are derived, never copied into state
   (A27).

## Enforcement

- `web_lint` (typescript-eslint + react rules) and `web_typecheck` in CI;
  review checklist applies the composition boundary rules (A13).

## Agent Digest

- Single-purpose components; composition over configuration; props are a typed contract — no `...rest` passthrough, no boolean traps (discriminated unions, A32).
- Render is pure — no side effects outside effects; StrictMode double-render must be harmless (A26).
- Design-system primitives own shared UI; features never import across feature boundaries (A05 discipline).
- No dangerouslySetInnerHTML — untrusted content goes through A35 controls.
- Derived values stay derived; never mirrored into state (A27).
