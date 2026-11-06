# A27 — React State Management Standards

**Layer:** static · **Stacks:** react · **Mirror:** react-state-standards

## Scope

Deciding where UI state lives: component state, reducers, context, or shared
stores — and what never becomes client state at all.

## Standards

1. Server state (API data) is owned by the data layer (A28) and never
   copied into client stores; a store that mirrors API responses is a
   defect.
2. State lives at the lowest common owner; lifting state is a deliberate
   design decision, not a reflex.
3. Derived values are computed, never synced into state; a state field
   recalculable from other state is a defect — effects that "keep two
   sources in sync" are banned outright.
4. Context is for dependency injection (theme, session, feature flags),
   not high-frequency update distribution; putting live data in context
   without a measured reason is a defect.
5. One shared-store paradigm per app (zustand, redux, jotai, or xstate) —
   the app's choice and its conventions live in the app's config home;
   mixing paradigms inside one feature is a defect.
6. Multi-step flows are state machines (reducer unions or xstate); boolean
   webs for flow control are defects.
7. State that must survive navigation is serialized through the URL or
   storage deliberately — with a single home for its shape (A32).

## Enforcement

- `web_lint` for store/selector patterns; review checklist (A13) for
  ownership decisions.

## Agent Digest

- Server state belongs to the data layer (A28) — client stores hold UI state only; no mirroring API data into stores.
- State at the lowest common owner; derived values stay derived — never copied into state, never effect-synced.
- Context injects dependencies, not high-frequency data; live data in context needs a measured reason.
- One store paradigm per app, written in the app's config home; multi-step flows are state machines, not boolean webs.
