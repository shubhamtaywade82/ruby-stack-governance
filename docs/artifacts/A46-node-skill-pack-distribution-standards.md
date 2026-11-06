# A46 — Node.js Skill Pack Distribution and Release Standards

**Layer:** process · **Stacks:** nodejs · **Mirror:** node-skill-pack-distribution-standards

## Scope

Packaging, distributing, releasing, and consuming an Agent Skills pack outside
its source repository — payload discipline, integrity metadata, provenance,
and the release gate contract (node-agent-skills distribution skills).

## Standards

1. A distribution payload is an allowlist: skills, adapters, router,
   validator, manifest, and docs ship; environment-specific files (secrets,
   lockfile caches, node_modules, tool output) never do. Relative paths are
   preserved so the payload stays portable.
2. Every distribution carries integrity metadata — checksums over the
   payload — plus version and source identity; consumers verify before
   install (supply-chain rule, the pack analogue of A08/A35).
3. Exported or generated artifacts are derived outputs with a generator and
   a drift gate; a shipped artifact that diverges from regeneration is a
   defect (Laws 4–6 applied to the pack itself).
4. Releases never weaken gates to ship: the release workflow runs the full
   registered gate set — manifest sync, cross-pack verify, routing evals —
   before a tag exists.
5. The runtime surface is zero-dependency and additive-only: the loader and
   the stdio MCP server keep their tool contracts stable; new tools and
   manifest fields are additive, never breaking (A47).
6. Source governance records where the pack came from and who owns it;
   published artifacts carry provenance attestation.

## Enforcement

- Export script emits the allowlist payload + checksums; verifier re-checks
  integrity on consumption; release workflow gates fail closed (A13).

## Agent Digest

- Distribution payloads are allowlists — skills, adapters, router, manifest, docs; environment-specific files never ship; relative paths stay portable.
- Every distribution carries checksums plus version/source identity, and consumers verify before install.
- Exported or generated artifacts are derived outputs with a generator and a drift gate — shipped divergence from regeneration is a defect.
- Releases never weaken gates to ship — manifest sync, cross-pack verify, and routing evals run before a tag exists.
- The runtime loader and stdio MCP server stay zero-dependency and additive-only; published artifacts carry provenance attestation.
