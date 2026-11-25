<!--
  README.md template for an app repo (deployed service, not a published
  package), derived from slug-pages and product-catalog. Fill in the
  bracketed placeholders; drop sections that don't apply.
-->

# [project-name]

[![CI](https://github.com/[owner]/[repo]/actions/workflows/ci.yml/badge.svg?branch=main)](https://github.com/[owner]/[repo]/actions/workflows/ci.yml)
[![CD](https://github.com/[owner]/[repo]/actions/workflows/cd.yml/badge.svg?branch=main)](https://github.com/[owner]/[repo]/actions/workflows/cd.yml)
[![License](https://img.shields.io/github/license/[owner]/[repo]?style=flat-square)](LICENSE)

[One or two sentence description of what this app does.]

[Optional: **[Try it live →]([public URL])**, only if there's a public deployment worth linking.]

## Tech stack

[Framework/runtime] · [hosting platform] · [database/ORM] · [other key libs]

## Features

- **[Feature name]**: [one line describing it].
- **[Feature name]**: [one line describing it].

See [docs/architecture.md](docs/architecture.md) for the domain model and request flow, and [docs/adr/](docs/adr/) for the reasoning behind these decisions.

## Development

Requires [prerequisite, e.g. a runtime/SDK/CLI].

```bash
[install command]
[any local setup step, e.g. db migration]
[dev-server command]
```

[Optional one line explaining a non-obvious setup step.]

Other commands: `[cmd]` ([what it does]), `[cmd]` ([what it does]).

## Deployment

Auto-deployed to [hosting target] on every merge to `main` via GitHub Actions, authenticated with [auth mechanism, e.g. an OIDC federated credential / API token scoped to X]. [Optional: note about migrations/IaC, e.g. "no Terraform or Bicep."]

## License

Licensed under the [MIT License](LICENSE).
