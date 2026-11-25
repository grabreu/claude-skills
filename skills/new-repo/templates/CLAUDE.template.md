<!--
  CLAUDE.md template, derived from slug-pages/product-catalog (apps) and
  aduana/desfecho/ramus (libraries). Fill in the bracketed placeholders and
  delete whichever bracketed alternative doesn't apply.

  Sections that never change (copy verbatim): General Rules, Git,
  Documentation > Content Rules.
-->

# [project-name]

## Repository

[One or two sentences: what this project is and what problem it solves.]

Read `README.md` before making changes: it documents [the project pitch and business rules | the actual public API/CLI]. [App only: Read `docs/architecture.md` for the domain model and request flow. Significant, hard-to-reverse decisions are recorded in `docs/adr/`; check it before revisiting one, and add an entry when making a new one.]

## General Rules

- Keep changes scoped to the requested change.
- Prefer existing patterns over introducing new abstractions.
- Do not add dependencies unless they are necessary.
- Do not fill gaps with assumptions when the user hasn't given the information: ask, or mark it as pending.
- Do not claim a validation command passed unless it was actually run.
- Code, comments, commit messages, and documentation are always written in English.
- Do not use em dashes; use a comma, colon, semicolon, parentheses, or a separate sentence instead.

## Git

- Do not create or switch branches unless explicitly requested.
- Do not create commits unless explicitly requested.
- Do not push unless explicitly requested.
- Keep commits focused on the requested change.
- Commit messages follow [Conventional Commits](https://www.conventionalcommits.org/) (`type: summary`).

## Documentation

### Audience

[App: Future-you revisiting this months later, or someone browsing the portfolio to see how it works.]
[Library: A developer evaluating whether to add this as a dependency / install this CLI.]
Not onboarding material; keep it concise and skimmable.

### Content Rules

- State facts concisely. Avoid unnecessary explanations or trailing rationale.
- Do not document information that is already obvious from the repository structure or configuration.
- Do not invent features, API shapes, or future direction: mark undecided things as TODO.
- Document a capability only after it is implemented and verified.
- Use proper Markdown headings (`##`, `###`), not bold text as headings.

---

## Project-Specific Guidelines

### Source

- `[path]` - [what it contains / does].
- `[path]` - [what it contains / does].

[Optional: "Every X should have a matching Y test file.", the coverage convention for this repo.]

### Validation

Run `[cmd 1]`, `[cmd 2]`, ... before considering a change done; CI (`.github/workflows/ci.yml`) runs the same on push/PR to `main`.

### Open Questions

[Optional section, only if real, currently-true TODOs exist. Delete if there are none.]

- TODO: [pending decision or unimplemented capability].
