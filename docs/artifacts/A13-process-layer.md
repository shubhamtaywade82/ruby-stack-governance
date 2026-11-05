# A13 — Process Layer Standards

**Layer:** process · **Stacks:** ruby, rails · **Mirror:** enforcement-workflow

## Scope

How change reaches main: PR template, labels, hooks, ratchet ceremony, and the
Boy Scout rule.

## Standards

1. Every PR passes the template checklist: gates green, Boy Scout, single
   homes respected, mirrors regenerated, IP clean.
2. Labels are the machine-readable record of intent (`ratchet`,
   `todo-baseline-change`, `mcp-contract-change`, `packwerk`, `query-budget`,
   `docs-corpus`, `react`); a PR without a label is misclassified, not
   merely unlabeled.
3. Boy Scout rule: a PR that touches a file in `.rubocop_todo.yml` must remove
   that file's entry — shrinking the baseline, never growing it.
4. Ratchet moves are their own PRs: one registry file (`docs/ratchets.yml`),
   one direction, weekly cadence, `ratchet` label.
5. Hooks: this repo uses `.githooks/` (installed by `bin/setup`); target apps
   may adopt overcommit — one hook system per repo (Law 1).
6. IP tracker: pasted third-party code without a recorded license is
   inadmissible; "found on the internet" is not a source.
7. Corpus edits regenerate mirrors in the same PR — the drift gate makes a
   stale mirror unmergeable (Law 5).

## Enforcement

- Pre-commit `.githooks/pre-commit`; CI `agent-interface`; CODEOWNERS review
  on every PR.

## Agent Digest

- Every PR passes the template checklist: gates green, Boy Scout, single homes, mirrors regenerated, IP clean.
- Boy Scout rule: touching a file listed in .rubocop_todo.yml requires removing its entry — the baseline never grows.
- Ratchet moves are standalone PRs — one registry file (docs/ratchets.yml), one direction (tightening), `ratchet` label, weekly cadence.
- Labels are intent records (ratchet, todo-baseline-change, mcp-contract-change, packwerk, query-budget, docs-corpus, react) — no PR ships unlabeled.
- Corpus edits (docs/artifacts/**, docs/ratchets.yml) regenerate mirrors via `bin/rake agent:mirror` in the same PR.
- Third-party code without a recorded license is inadmissible — the IP tracker is part of review.
