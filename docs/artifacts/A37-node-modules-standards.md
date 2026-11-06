# A37 — Node.js Modules and Package Standards

**Layer:** static · **Stacks:** nodejs · **Mirror:** node-modules-standards

## Scope

Module systems, package manifests, runtime pins, dependency discipline, and
script conventions for Node.js packages and services.

## Standards

1. ESM is the module format for new code (`"type": "module"` or `.mjs`);
   CommonJS interop exists only at legacy boundaries — mixed module
   systems inside one package are defects.
2. `package.json` is the single home for the runtime pin: `engines.node`
   states the supported range; the pin is verified in CI, never guessed
   (R7 discipline — the same role `.ruby-version` plays for Ruby).
3. Public packages define the `exports` field with explicit entry points;
   consumers reaching past `exports` into deep paths are defects.
4. One package manager per project; the lockfile is the single home for
   dependency pins — committed with integrity, `npm ci`-style frozen
   installs in production (A35 supply-chain rules apply).
5. Dependencies are minimal: direct deps only what the code imports;
   duplicate functionality (two date libraries, two HTTP clients) is a
   defect.
6. Scripts follow the naming convention (`lint`, `typecheck`, `test`,
   `e2e`) so the registered gates (`web_lint`, `web_typecheck`,
   `web_test`, `web_e2e`) resolve — command strings live only in the
   gates registry (Law 3).
7. Install scripts (`postinstall` and friends) run nothing unreviewed
   (A35).

## Enforcement

- `web_lint` and `web_typecheck` in CI; `npm_audit` for dependency risk;
  review checklist applies the module and dependency rules (A13).

## Agent Digest

- ESM for new code; CommonJS interop at legacy boundaries only — mixed module systems in one package are defects.
- package.json engines.node is the single home for the runtime pin — verified in CI, never guessed (R7 discipline).
- Public packages expose explicit `exports` entry points; deep-path imports are defects.
- One package manager per project; the lockfile is the single home for dependency pins (A35); production installs are frozen.
- Scripts follow the lint/typecheck/test/e2e naming convention so the registered gates resolve (Law 3).
