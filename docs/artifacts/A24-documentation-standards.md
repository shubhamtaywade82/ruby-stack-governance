# A24 — Documentation Standards

**Layer:** agent-context · **Stacks:** ruby, rails · **Mirror:** never (meta)

## Scope

What documentation exists, where its home is, and how it stays true.

## Standards

1. This repo is the W5H documentation home: corpus artifacts (A01–A24, then
   A25+) are the standard; app-repo READMEs are thin pointers here.
2. YARD coverage is ratcheted (`yard_coverage`) in the target app; the
   number lives in `docs/ratchets.yml`.
3. Public APIs in packs (A05) carry YARD examples; example code in docs must
   parse — docs that lie are defects like tests that lie.
4. Schema/API mirrors (swagger per A22, skills/rules mirrors per A13) are
   generated and drift-gated — prose that describes generated mirrors is
   itself a mirror of a mirror and is forbidden (Law 1 applied to prose).
5. A doc change is a `docs-corpus` PR: content edit + regenerated mirrors in
   the same PR, per the checklist.

## Enforcement

- `agent_mirror` drift gate keeps README-adjacent mirrors honest;
  `yard_coverage` ratchet keeps the app's inline docs honest.

## Deterministic fixes

- Doc drift discovered → regenerate mirrors (`bin/rake agent:mirror`), then
  fix the source artifact — never the mirror.
