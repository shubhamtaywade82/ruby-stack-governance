# A16 — Executable Knowledge Base Architecture

**Layer:** agent-context · **Stacks:** ruby, rails · **Mirror:** never (architecture record)

## Scope

The R5 decision: this corpus is an Executable Knowledge Base — every entry is
linked to its enforcing artifact, gate, and ratchet deterministically.

## Standards

1. Every artifact carries an Enforcement section naming its gates and
   ratchet metrics — an artifact without enforcement teeth is documentation,
   not corpus.
2. Every rule resolves to exactly one of: enforced by cop, enforced by guard
   spec, enforced by process checklist, or explicitly advisory (labelled).
   "Should" without a home is a defect (Law 1).
3. Deterministic fixes are procedures, not suggestions: ordered steps, one
   correct terminal state.
4. Artifact metadata (id, stacks, layer, mirror fields) lives in
   `docs/artifacts/MANIFEST.yml` — the manifest is the machine index, never
   the content.
5. Mirrors (skills, rules, AGENT_CONTEXT) are generated and gated (A13,
   Law 4/5); the MCP server reads sources directly at call time, so data
   cannot drift between corpus and tools.
6. Agents never invent numbers: they read registries via `get_limit` /
   `get_ratchet` or the owning files.

## Enforcement

- This artifact itself is enforced by: `agent_mirror` drift gate,
  `mcp_contract` snapshot, and the MANIFEST/coverage ratchet
  (`skills_corpus_coverage`).
