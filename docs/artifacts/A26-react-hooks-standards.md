# A26 — React Hooks and Effects Standards

**Layer:** static · **Stacks:** react · **Mirror:** react-hooks-standards

## Scope

Writing and reviewing hooks, effects, refs, memoization, subscriptions, and
synchronization with systems outside React.

## Standards

1. Effects exist only to synchronize React with external systems (DOM
   APIs, subscriptions, timers, network) — an effect that "runs logic"
   instead of syncing is a defect: derive state or move the work into
   event handlers.
2. Dependency arrays are exhaustive; suppressing the hooks lint rule is
   banned — the linter is the single enforcement home for dependency
   correctness.
3. Every subscription and effect cleans up on unmount and on dependency
   change; a leak or a duplicate fire under StrictMode is a defect.
4. Refs hold external-system handles and non-render values only — never
   reactive data that should be state; reading a ref during render is a
   defect.
5. Hooks are never called conditionally; custom hooks are named `use*` and
   return stable identities where consumers depend on them.
6. Memoization is not speculative: `useMemo`/`useCallback` only where
   measured or where the React Compiler is not in charge; hand-written
   memo sprinkles alongside the compiler are removed.
7. Modern (19+) APIs — Actions, `use()`, compiler directives — are used
   only when installed-version evidence confirms support, never
   speculatively.

## Enforcement

- `web_lint` (react-hooks rules + React Compiler diagnostics) in CI;
  `web_typecheck` for identity and signature drift.

## Agent Digest

- Effects synchronize with external systems only — logic-effects are defects; derive state or move work to event handlers.
- Exhaustive deps with zero lint suppressions; cleanup on every path; StrictMode double-invoke must be harmless.
- Refs hold external handles and non-render values only; reading a ref during render is a defect.
- No speculative memoization — measured hot paths only, or the compiler owns memoization.
- 19+ APIs require installed-version evidence, never speculation.
