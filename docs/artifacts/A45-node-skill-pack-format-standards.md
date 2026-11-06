# A45 — Node.js Skill Pack Format and Manifest Standards

**Layer:** static · **Stacks:** nodejs · **Mirror:** node-skill-pack-format-standards

## Scope

The structure of Agent Skills packs in the Node ecosystem — SKILL.md folders,
frontmatter, the central skill manifest, per-skill versioning, and cross-pack
naming — as practiced by the node-agent-skills pack (manifest schema v3).

## Standards

1. Every skill is a directory with exactly one `SKILL.md`; the frontmatter
   `name` matches the directory name and the manifest entry. The frontmatter
   `description` states when to use the skill (progressive disclosure) —
   discovery metadata stays separate from the detailed instructions in the
   body.
2. Frontmatter is strict-YAML valid: a `description` containing `": "` is a
   defect unless quoted. The pack's own line-regex loader tolerates bare
   colons, but v3-aware cross-pack loaders parse with real YAML parsers — a
   frontmatter only the tolerant loader accepts is a lie about its source.
3. `skill-manifest.yml` is the single machine-readable registry and the
   authoritative home for routing metadata (name, category, triggers). The
   manifest and the filesystem skill set stay 1:1 — stale entries, duplicate
   names, and unregistered directories fail validation.
4. Structural keys never mix YAML shapes: a skill-shaped sequence and an
   adapter metadata mapping never share one key (the v3 `adapter_skills`
   vs `adapters` split). Manifest changes are reviewed like code.
5. Per-skill semver is independent of the pack-level version; the version
   bump travels in the same change that touches the skill.
6. Skill names carry the pack prefix (`node-*`) so cross-pack namespaces
   stay disjoint; the cross-pack name-collision registry is the
   machine-checkable surface for that invariant.
7. Counts are never hardcoded in docs or tools — they are derived from the
   manifest at read time or contract-tested (manifest governance).
8. Core SKILL.md bodies stay vendor-neutral: no client-only commands;
   vendor-specific integrations live in separate adapter/compatibility
   surfaces (A46).

## Enforcement

- Pack validator + CI manifest/filesystem sync checks; cross-pack verifier
  re-parses the manifest with a strict YAML parser (A47); review checklist
  applies the frontmatter and naming rules (A13).

## Agent Digest

- One SKILL.md per skill directory; frontmatter name matches the directory and the manifest entry; descriptions state when to use the skill.
- Frontmatter must be strict-YAML valid — a description containing a bare colon-space is quoted or rewritten; tolerant-loader-only frontmatter is a defect.
- The manifest is the single routing home; manifest and filesystem skill set stay 1:1 — stale entries, duplicate names, and unregistered directories fail validation.
- Skill-shaped sequences and adapter metadata mappings never share one YAML key (v3 adapter_skills/adapters split); manifest changes are reviewed like code.
- Per-skill semver is independent of the pack version; names carry the pack prefix so cross-pack namespaces stay disjoint; counts are derived, never hardcoded.
