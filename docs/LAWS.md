# The Six Universal Laws

The corpus enforcement system is governed by six laws. Every artifact, gate,
and mirror in this repo must comply. When a decision seems ambiguous, resolve it
by appeal to a law — deterministically, never by taste.

## 1. One deterministic home

Every corpus entry (rule, limit, standard, fix procedure) has exactly **one**
home. All other appearances are derived mirrors, and mirrors must be gated
(Law 4). Hand-editing a mirror is a lie about its source.

## 2. Every home has a ratchet

Every enforcement surface has a measurable metric with a one-way target — it
only tightens, never loosens. Baselines live in `docs/ratchets.yml`. Loosening
a ratchet requires an incident record and is always reversible-by-PR only.

## 3. Numbers have exactly one source

- Code limits → `.rubocop.yml`
- Ruby version → `.ruby-version`
- Gem pins → `Gemfile.lock`
- Ratchet targets → `docs/ratchets.yml`
- Gate commands → `config/gates.yml`

Restating a number in docs, code, chat, or mirrors is a defect. Tools read the
source at call time (`get_limit`, `get_ratchet`); humans read the file.

## 4. Tool-contract mirrors must be gated

"Mirrors may exist; lies may not." Any format an external tool demands (SKILL.md,
`.mdc`, `.cursorrules`, `AGENT_CONTEXT.md`, contract snapshots) is a mirror and
must carry a generator plus a drift gate.

## 5. Generated means drift-gated

Every generated artifact has a check that fails when committed output diverges
from regeneration (`bin/rake agent:mirror:check` in CI and pre-commit).

## 6. Generated means idempotent

Generators are byte-stable: no timestamps, no wall-clock, no network, sorted
and deterministic output. Running twice must produce identical bytes — verified
by `spec/mcp/agent_mirror_spec.rb`.

## Naming rule

Platform names never contain a tool name (a platform is not named after one of
its components) and are stack-neutral enough to admit new stacks. See
`docs/NAMING.md` for the applied decision (repo name `ruby-stack-governance`).
