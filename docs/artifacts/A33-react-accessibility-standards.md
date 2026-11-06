# A33 — React Accessibility Standards

**Layer:** runtime · **Stacks:** react · **Mirror:** react-accessibility-standards

## Scope

Semantic markup, keyboard interaction, focus management, accessible names,
live regions, and composite ARIA widgets.

## Standards

1. Semantic HTML first; ARIA is a polyfill for what HTML cannot express —
   a `role` restating an existing element semantic is a defect.
2. Every interaction is reachable and operable by keyboard alone;
   pointer-only paths are defects; tab order follows DOM order, and
   positive `tabindex` is banned.
3. Focus is managed: dialogs trap and restore focus; route changes move
   focus to the new content; focus never remains on a removed node.
4. Every control has an accessible name; icon-only controls carry a
   visible-on-focus label or screen-reader text.
5. Composite widgets follow the WAI-ARIA APG patterns exactly — keyboard
   maps, selection semantics, and live-region announcements; divergence
   from APG is a defect.
6. Axe scans run in the suite; violations feed the `axe_violations`
   ratchet — read `docs/ratchets.yml`, never restate the number here.

## Enforcement

- `web_test` and `web_e2e` (axe); `axe_violations` ratchet.

## Agent Digest

- Semantic HTML first — ARIA only where HTML cannot express the semantics; restated roles are defects.
- Keyboard-only paths for every interaction; DOM order is tab order; positive tabindex is banned.
- Focus is managed — dialogs trap/restore, routes move focus to new content, removed nodes never hold focus.
- Icon-only controls carry accessible names; composite widgets follow APG patterns exactly.
- Violations count into the axe_violations ratchet — read `docs/ratchets.yml`, never restate the number.
