# A47 — Cross-Pack Integration Standards

**Layer:** agent-interface · **Stacks:** ruby, react, nodejs · **Mirror:** cross-pack-integration-standards

## Scope

How the governed skill packs (ruby-agent-skills, react-agent-skills,
node-agent-skills) declare, verify, and route across their boundaries — the
cross-pack manifest schema v3, seam skills, pinned companions, and
eval-gated routing.

## Standards

1. Companion packs are declared in the manifest `cross_pack` section —
   repo, pinned ref, snapshot, seam skill, language. Undeclared companions
   are invisible to routing; the declaration is machine-checkable.
2. Companion refs are pinned and snapshotted; drift between the checked-in
   snapshot and the companion's live manifest fails the cross-pack verifier
   — snapshots are mirrors, and mirrors must be gated (Law 4).
3. Every seam is symmetric: each side names one primary seam skill, with
   secondary support justified by actual dependencies. Routing loads the
   primary for the boundary — it never loads every skill in the pack.
4. Manifest schema evolution is additive-only (v3 is a strict superset of
   the v1 and v2 shapes): no renames, no type changes, new fields
   optional; legacy parsers keep working, `schema_version` gates
   new-aware behavior.
5. Cross-pack routing is deterministic and eval-gated: language-aware
   boosting from the file under edit, a `route_cross_pack` tool plus CLI
   that route one prompt across every installed pack, and seam eval cases
   in the harness (LLM-as-judge) guarding routing quality.
6. Trigger collisions across packs resolve by explicit ownership recorded
   in the seam registry — never by alphabetical bias or install order.
7. The cross-pack name-collision registry is the single home for name
   overlaps; zero collisions is the checked-in state, and any new overlap
   is either renamed or explicitly owned before merge.

## Enforcement

- Cross-pack verifier in CI (strict-YAML re-parse, snapshot drift,
  collision registry); routing evals at every seam; review checklist
  applies the seam-symmetry rules (A13).

## Agent Digest

- Companion packs are declared in the manifest cross_pack section — repo, pinned ref, snapshot, seam skill, language — and the declaration is machine-checkable.
- Companion refs are pinned and snapshotted; snapshot drift against the live companion manifest fails the cross-pack verifier (mirrors must be gated).
- Seams are symmetric — one primary seam skill per side, secondaries justified by real dependencies; routing loads the boundary owner, never every skill.
- Schema evolution is additive-only — v3 stays a strict superset of v1/v2 shapes; no renames, no type changes, legacy parsers keep working.
- Routing is deterministic and eval-gated: language-aware file boosting, a route_cross_pack tool, and LLM-as-judge seam cases; trigger collisions resolve by recorded ownership, not alphabetical bias.
