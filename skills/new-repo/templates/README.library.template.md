<!--
  README.md template for a library/CLI repo published to a package registry,
  derived from aduana, desfecho, and ramus. Fill in the bracketed
  placeholders; drop sections that don't apply.
-->

# [project-name]

[![CI](https://github.com/[owner]/[repo]/actions/workflows/ci.yml/badge.svg?branch=main)](https://github.com/[owner]/[repo]/actions/workflows/ci.yml)
[![CD](https://github.com/[owner]/[repo]/actions/workflows/cd.yml/badge.svg?branch=main)](https://github.com/[owner]/[repo]/actions/workflows/cd.yml)
[![[Registry]](https://img.shields.io/[registry]/v/[package].svg?style=flat-square&logo=[registry]&label=[package])]([registry package URL])
[![License](https://img.shields.io/github/license/[owner]/[repo]?style=flat-square)](LICENSE)

[One sentence description of what this package/CLI does.]

```bash
[install command]
```

## Tech stack

[Language/runtime] · [test framework] · [key build/lint tooling]

## Why

[Prose: the problem this solves and why it exists, 2-4 sentences.]

```[language]
[minimal runnable example]
```

[Optional additional sections for other public-API surfaces, e.g. ## Errors, ## Usage, ## Interceptors, one section per documented capability, each with a short code example.]

## Development

```bash
[install/setup command]
[build command]
[test command]
[lint/format command]
```

## Deployment

Versioning, changelog, and [registry] publish are automated by [release-please](https://github.com/googleapis/release-please): merges to `main` update a release PR from Conventional Commits, and merging that PR tags the release and publishes to [registry] via GitHub Actions[, using trusted publishing (OIDC) | , authenticated with an API key stored as a repo secret].

## License

Licensed under the [MIT License](LICENSE).
