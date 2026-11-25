#!/usr/bin/env bash
# Apply the baseline repo settings via the GitHub API.
# Usage: apply-settings.sh <owner/repo> [--checks "Format,Test"]
# Env:   DRY_RUN=1 prints the calls instead of running them.
# Requires: gh (authenticated with repo scope), python.
set -euo pipefail

repo="${1:?usage: apply-settings.sh <owner/repo> [--checks \"Format,Test\"]}"
checks=""
if [[ "${2:-}" == "--checks" ]]; then checks="${3:-}"; fi

api() {
  if [[ "${DRY_RUN:-0}" == "1" ]]; then echo "gh api $*"; else gh api "$@" >/dev/null; fi
}

echo "Security and analysis"
api -X PATCH "repos/$repo" --input - <<'JSON'
{"security_and_analysis":{"secret_scanning":{"status":"enabled"},"secret_scanning_push_protection":{"status":"enabled"}}}
JSON
api -X PUT "repos/$repo/vulnerability-alerts"
api -X PUT "repos/$repo/automated-security-fixes"

echo "Actions: SHA pinning and 7 day retention"
api -X PUT "repos/$repo/actions/permissions" --input - <<'JSON'
{"enabled":true,"allowed_actions":"all","sha_pinning_required":true}
JSON
api -X PUT "repos/$repo/actions/permissions/artifact-and-log-retention" --input - <<'JSON'
{"days":7}
JSON

echo "Ruleset: main"
body="$(CHECKS="$checks" python - <<'PY'
import json, os
rules = [
    {"type": "deletion"},
    {"type": "non_fast_forward"},
    {"type": "required_linear_history"},
    {"type": "pull_request", "parameters": {
        "required_approving_review_count": 0,
        "dismiss_stale_reviews_on_push": False,
        "required_reviewers": [],
        "require_code_owner_review": False,
        "require_last_push_approval": False,
        "required_review_thread_resolution": False,
        "require_extra_approval_for_unattributed_changes": True,
        "allowed_merge_methods": ["merge", "squash", "rebase"]}},
]
checks = [c.strip() for c in os.environ.get("CHECKS", "").split(",") if c.strip()]
if checks:
    rules.append({"type": "required_status_checks", "parameters": {
        "strict_required_status_checks_policy": False,
        "do_not_enforce_on_create": False,
        "required_status_checks": [{"context": c, "integration_id": 15368} for c in checks]}})
print(json.dumps({
    "name": "main", "target": "branch", "enforcement": "active",
    "conditions": {"ref_name": {"include": ["~DEFAULT_BRANCH"], "exclude": []}},
    "rules": rules, "bypass_actors": []}))
PY
)"

if [[ "${DRY_RUN:-0}" == "1" ]]; then
  echo "gh api repos/$repo/rulesets (create or update 'main') with: $body"
else
  id="$(gh api "repos/$repo/rulesets" -q '.[] | select(.name=="main") | .id')"
  if [[ -n "$id" ]]; then
    printf '%s' "$body" | gh api -X PUT "repos/$repo/rulesets/$id" --input - >/dev/null
  else
    printf '%s' "$body" | gh api -X POST "repos/$repo/rulesets" --input - >/dev/null
  fi
fi

echo "Done. Not settable via API, check Settings > Advanced Security: dependency graph, malware alerts, grouped security updates."
