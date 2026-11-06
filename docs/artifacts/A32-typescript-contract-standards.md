# A32 — TypeScript Contract Standards

**Layer:** static · **Stacks:** react, typescript · **Mirror:** typescript-contract-standards

## Scope

Type modeling, generics, public API surfaces, and the runtime contracts
that guard every untrusted edge of typed code.

## Standards

1. `any` is banned in exports and function signatures — `unknown` plus
   narrowing at boundaries; non-null assertions on untrusted data are
   defects.
2. Domain states are discriminated unions with exhaustive handling; the
   compiler error on an unhandled case is the contract working; boolean
   pairs are replaced by unions.
3. Runtime contracts at every untrusted edge — HTTP responses, JSON, env
   values, browser storage, `postMessage` — parse through the app's
   schema validator (its single home); `as` casts at these edges are
   defects.
4. Public types change additively; breaking changes bump the version and
   ship a migration note (A09 discipline applied to the web contract).
5. Typed linting runs where type information improves defect detection;
   the typescript-eslint project-service config is the app's single
   home (`web_lint`).
6. `web_typecheck` (tsc) is the gate before any transpile-only bundler
   pass — types decide, bundlers follow.

## Enforcement

- `web_typecheck` and `web_lint` in CI.

## Agent Digest

- No any in exports — unknown + narrowing at boundaries; non-null assertions on untrusted data are defects.
- Domain states are discriminated unions with exhaustive handling; compiler exhaustiveness is the contract.
- Untrusted edges (HTTP, JSON, env, storage, postMessage) parse through the schema validator — as-casts there are defects.
- Public types change additively — breaking changes bump versions with migration notes (A09 discipline).
- tsc is the gate before bundler transpile passes (web_typecheck).
