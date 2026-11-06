# A34 — React Performance Standards

**Layer:** runtime · **Stacks:** react · **Mirror:** react-performance-standards

## Scope

Render cost, list virtualization, code splitting, bundle sizes, and Web
Vitals budgets.

## Standards

1. Optimize after measurement — a change justified without a profile is
   speculative; memoization without a measured hot path is a defect
   (A26).
2. Core Web Vitals budgets (LCP, INP, CLS) are ratchets; the numbers live
   in the app's budget home and are read there — never restated in code,
   docs, or chat (Law 3).
3. Route-level code splitting is the default; component-level lazy
   loading only for measured heavy imports; a bundle that grows past
   budget blocks the PR.
4. Large lists virtualize past the app's committed threshold (its single
   home); unvirtualized long lists are defects.
5. Effects do not thrash layout — DOM reads and writes are batched;
   non-render work defers off the main thread.
6. Third-party scripts are budgeted, owned, and dated (A35); each has a
   removal or review date.

## Enforcement

- `web_test` perf guards; budget ratchets in the app's home; bundle
  budget blocks the PR (A13).

## Agent Digest

- Profile first — unmeasured optimization and speculative memoization are defects; the compiler owns memo where adopted (A26).
- Web Vitals budgets are ratchets in the app's budget home — read them there, never restate (Law 3).
- Route-level splitting by default; over-budget bundles block the PR.
- Lists virtualize past the app's committed threshold; effects never thrash layout.
- Third-party scripts are budgeted, owned, and dated (A35).
