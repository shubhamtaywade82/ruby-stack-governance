# A29 — React Forms and Validation Standards

**Layer:** runtime · **Stacks:** react · **Mirror:** react-forms-standards

## Scope

Forms, multi-step workflows, field validation, submission behavior, and the
accessible display of errors.

## Standards

1. Validation is schema-driven: the app's chosen validator is the single
   home for rules; hand-rolled per-field regex checks are defects.
2. Errors are announced: each field error is tied to its input
   (`aria-describedby`), and a failed submit moves focus to the first
   error (A33).
3. Inputs are uncontrolled-first (registration pattern); controlled state
   only where live derivation is genuinely required.
4. Pending state blocks double submission on the client; every server
   response is revalidated at the boundary before display (A32).
5. Multi-step flows persist user input through the flow owner — back
   navigation that loses input is a defect.
6. React 19 form Actions are used only with installed-version evidence
   (A26 discipline) and with an explicit contract for pending, success,
   failure, and optimistic states.

## Enforcement

- `web_test` exercises validation, submission, and error-focus paths;
  `web_lint` for controlled/uncontrolled discipline.

## Agent Digest

- Validation is schema-driven at the boundary — one home for rules; hand-rolled field regexes are defects.
- Errors are announced — aria-describedby ties errors to inputs; failed submit focuses the first error (A33).
- Uncontrolled-first inputs; pending state blocks double submit; server responses revalidated at the boundary (A32).
- Multi-step flows never lose user input on back navigation.
- React 19 Actions require installed-version evidence and explicit pending/success/failure contracts (A26).
