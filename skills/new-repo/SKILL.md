---
name: new-repo
description: Create a new GitHub repo with the standard baseline (templates, dependabot, ruleset, Actions pinning, security settings), or audit an existing repo against that baseline. Use when the user says "new repo", "create a repo", "/new-repo", or asks to audit or standardize a repo's settings.
---

# new-repo

Creates a GitHub repo ready to use, or audits an existing one. Requires `gh` authenticated with the `repo` scope.

Paths below are relative to this skill's directory.

## Modes

- `/new-repo [name]`: create a repo (see Create).
- `/new-repo audit [owner/repo]`: read-only check. Defaults to the repo in the current directory (`gh repo view --json nameWithOwner`). Run `scripts/audit.sh <owner/repo>`, show the result, and ask before fixing anything.

## Create

### 1. Ask

Ask only what is missing, in one batch:

- Name (kebab-case) and one-line description.
- Visibility: public or private.
- Kind: app (deployed service) or library (package or CLI).
- Stack: `.NET`, `Node`, `Python`, or none yet.
- Parent directory for the clone (default: current directory).

Do not guess unanswered values. Anything the user cannot answer yet goes into the generated files as `TODO`.

### 2. Create and clone

```bash
gh repo create <owner>/<name> --<public|private> --description "<description>" --license mit --clone
```

### 3. Generate files

Work inside the clone. Copy from `templates/` and fill what is known; leave undecided placeholders as `TODO`, never invent content.

- `CLAUDE.md` from `templates/CLAUDE.template.md` (app or library variant).
- `README.md` from `templates/README.app.template.md` or `templates/README.library.template.md`. Replace `[owner]` and `[repo]`. Remove the CI and CD badges: this skill does not create workflows.
- App only: `docs/architecture.md` from `templates/ARCHITECTURE.template.md`, and `docs/adr/` with the ADR template available as `templates/ADR.template.md`, only if the user wants them now.
- `.github/dependabot.yml`: `scripts/gen-dependabot.sh <ecosystem>` with `nuget` for .NET, `npm` for Node, `uv` for Python. No stack: no ecosystem argument.
- No `ci.yml` or `cd.yml`: this skill does not create workflows. The user adds them later.
- Stack-specific `.gitignore` if the stack is known.

### 4. First commit goes straight to main

The ruleset blocks direct pushes to main, so commit and push before applying settings:

```bash
git add -A && git commit -m "chore: initial project setup" && git push origin main
```

Show the user what is being committed first if anything was not from a template.

### 5. Apply settings

```bash
scripts/apply-settings.sh <owner>/<name>
```

Set `DRY_RUN=1` to print the calls without running them. Once the user adds CI, re-run with `--checks "<job>,<job>"` (job names as they appear in the PR checks) to require them in the ruleset.

### 6. Verify

Run `scripts/audit.sh <owner>/<name>` and report the result honestly. Always tell the user the manual items the API cannot set or read: dependency graph, malware alerts, grouped security updates (Settings > Advanced Security).

## Baseline

- Ruleset `main` on the default branch, no bypass: block deletion and force push, linear history, pull request required (0 approvals), no required status checks until CI exists (see step 5).
- Actions: SHA pinning required, artifact and log retention 7 days.
- Dependabot: alerts and security updates; `dependabot.yml` weekly with `chore(ci)` and `chore(deps)` prefixes and grouped minor and patch updates.
- Secret scanning and push protection.

## Notes

- Everything here is public-safe: no personal paths or tokens in templates. Keep it that way.
- Do not push, create branches, or open PRs on an existing repo without the user asking.
