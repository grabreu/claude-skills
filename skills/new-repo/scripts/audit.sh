#!/usr/bin/env bash
# Read-only check of a repo against the baseline.
# Usage: audit.sh <owner/repo>
# Exit code is the number of failed checks.
set -uo pipefail

repo="${1:?usage: audit.sh <owner/repo>}"
fail=0
ok()   { echo "OK    $1"; }
bad()  { echo "FAIL  $1"; fail=$((fail + 1)); }
check() { if eval "$2" >/dev/null 2>&1; then ok "$1"; else bad "$1"; fi; }

check "ruleset 'main' active on default branch" \
  "gh api repos/$repo/rulesets -q '.[] | select(.name==\"main\" and .enforcement==\"active\")' | grep -q ."
check "main ruleset requires pull request and linear history, blocks deletion and force push" \
  "id=\$(gh api repos/$repo/rulesets -q '.[] | select(.name==\"main\") | .id'); gh api repos/$repo/rulesets/\$id -q '[.rules[].type]|join(\",\")' | grep -q 'deletion' && gh api repos/$repo/rulesets/\$id -q '[.rules[].type]|join(\",\")' | grep -q 'non_fast_forward' && gh api repos/$repo/rulesets/\$id -q '[.rules[].type]|join(\",\")' | grep -q 'required_linear_history' && gh api repos/$repo/rulesets/\$id -q '[.rules[].type]|join(\",\")' | grep -q 'pull_request'"
check "actions SHA pinning required" \
  "[ \"\$(gh api repos/$repo/actions/permissions -q .sha_pinning_required)\" = true ]"
check "artifact and log retention is 7 days" \
  "[ \"\$(gh api repos/$repo/actions/permissions/artifact-and-log-retention -q .days)\" = 7 ]"
check "dependabot alerts enabled" \
  "gh api -i repos/$repo/vulnerability-alerts | head -1 | grep -q 204"
check "dependabot security updates enabled" \
  "[ \"\$(gh api repos/$repo/automated-security-fixes -q .enabled)\" = true ]"
check "secret scanning enabled" \
  "[ \"\$(gh api repos/$repo -q .security_and_analysis.secret_scanning.status)\" = enabled ]"
check "secret scanning push protection enabled" \
  "[ \"\$(gh api repos/$repo -q .security_and_analysis.secret_scanning_push_protection.status)\" = enabled ]"

dep="$(gh api repos/$repo/contents/.github/dependabot.yml -q .content 2>/dev/null | base64 -d 2>/dev/null)"
if [[ -z "$dep" ]]; then
  bad "dependabot.yml exists"
else
  ok "dependabot.yml exists"
  entries=$(grep -c 'package-ecosystem:' <<<"$dep")
  [[ "$(grep -c 'commit-message:' <<<"$dep")" -ge "$entries" ]] && ok "dependabot: commit-message on every ecosystem" || bad "dependabot: commit-message on every ecosystem"
  [[ "$(grep -c 'groups:' <<<"$dep")" -ge "$entries" ]] && ok "dependabot: groups on every ecosystem" || bad "dependabot: groups on every ecosystem"
fi

echo "MANUAL  check Settings > Advanced Security: dependency graph, malware alerts, grouped security updates"
exit "$fail"
