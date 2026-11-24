#!/usr/bin/env bash
# Regression cases for shared/scripts/check-brief.sh.
set -euo pipefail

script_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"
repo_dir="$(cd -- "$script_dir/.." && pwd -P)"
# The source in shared/; the copies in each Skill are checked against it by sync-shared.sh --check.
checker="$repo_dir/shared/scripts/check-brief.sh"
testdata="$script_dir/testdata"
failures=0

# expect <brief> <expected exit> <text the output must contain>
expect() {
  local brief="$1" want_exit="$2" want_text="$3" output got_exit=0
  output="$(bash "$checker" "$brief" 2>&1)" || got_exit=$?
  if [[ "$got_exit" != "$want_exit" ]] || ! grep -qF -- "$want_text" <<<"$output"; then
    printf 'FAIL %s: expected exit %s and "%s", got exit %s:\n%s\n' "${brief#"$repo_dir"/}" "$want_exit" "$want_text" "$got_exit" "$output" >&2
    failures=$((failures + 1))
  else
    printf 'ok   %s\n' "${brief#"$repo_dir"/}"
  fi
}

expect "$repo_dir/examples/internal-process/brief.md" 0 'OK:'
expect "$repo_dir/examples/early-product/brief.md" 0 'OK:'
expect "$testdata/bad-approval/brief.md" 1 'D-1 is approved but "By and date" has no YYYY-MM-DD date'
expect "$testdata/bad-undefined-id/brief.md" 1 'R-9 is referenced but not defined'
expect "$testdata/bad-placeholder/brief.md" 1 'unfilled placeholder'
expect "$testdata/bad-missing-handover/brief.md" 1 'handover.md is missing'
expect "$testdata/bad-awaiting-approval/brief.md" 1 'needs at least one non-goal'
expect "$testdata/bad-handover-id/brief.md" 1 'C-7 is referenced but not defined'
expect "$testdata/stale-handover/brief.md" 0 'regenerate the handover'
expect "$testdata/format-1/brief.md" 1 'format 1 brief (v0.1); ask discovery-rapid to convert it'

template_output="$(bash "$checker" --template "$repo_dir/skills/discovery-rapid/templates/brief.md" 2>&1)" || {
  printf 'FAIL template structure:\n%s\n' "$template_output" >&2; failures=$((failures + 1)); }
unfilled_exit=0
bash "$checker" "$repo_dir/skills/discovery-rapid/templates/brief.md" >/dev/null 2>&1 || unfilled_exit=$?
if [[ "$unfilled_exit" -ne 1 ]]; then
  printf 'FAIL the unfilled template must fail the full check (exit %s)\n' "$unfilled_exit" >&2
  failures=$((failures + 1))
fi

if [[ "$failures" -gt 0 ]]; then
  printf '%s checker case(s) failed.\n' "$failures" >&2
  exit 1
fi
printf 'All checker cases passed.\n'
