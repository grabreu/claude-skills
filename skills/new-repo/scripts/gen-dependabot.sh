#!/usr/bin/env bash
# Print a dependabot.yml to stdout.
# Usage: gen-dependabot.sh [ecosystem ...]   e.g. gen-dependabot.sh nuget
# github-actions is always included. Ecosystems: nuget, npm, uv, ...
set -euo pipefail

cat <<'EOF'
version: 2
updates:
  - package-ecosystem: "github-actions"
    directory: "/"
    schedule:
      interval: "weekly"
    commit-message:
      prefix: "chore(ci)"
    groups:
      actions:
        update-types:
          - "minor"
          - "patch"
EOF

for eco in "$@"; do
  cat <<EOF

  - package-ecosystem: "$eco"
    directory: "/"
    schedule:
      interval: "weekly"
    commit-message:
      prefix: "chore(deps)"
    groups:
      $eco:
        update-types:
          - "minor"
          - "patch"
EOF
done
