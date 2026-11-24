#!/usr/bin/env bash
# Runs behavioral scenarios headlessly and grades them against their rubrics.
set -euo pipefail

evals_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"
repo_dir="$(cd -- "$evals_dir/.." && pwd -P)"
checker="$repo_dir/skills/discovery-rapid/scripts/check-brief.sh"
model=''
judge_model=''
grade=1
keep=0
scenarios=()

usage() {
  cat <<'USAGE'
Usage: evals/run.sh [--model MODEL] [--judge-model MODEL] [--no-grade] [--keep] [SCENARIO ...]

Runs each scenario (a file or a number such as 03; default: all) in a fresh
temporary project with the discovery-rapid Skill linked into .claude/skills and
.agents/skills, and copies any "Seed:" files into it. Every "## Turn N" block runs as a separate headless session, so
later turns test recovery from the files alone. After the turns, the brief checker
runs on every brief produced and, unless --no-grade, a judge session scores the
transcripts and briefs against the scenario's rubric.

Results go to evals/results/<timestamp>-<scenario>/ and a line per run is added
to evals/results/results.tsv. Each run costs model usage.

Environment:
  EVAL_AGENT_CMD  Run a different agent per turn instead of claude. It runs in the
                  project directory with the prompt in EVAL_PROMPT, for example
                  EVAL_AGENT_CMD='codex exec --full-auto "$EVAL_PROMPT"'.
USAGE
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --model) model="${2:?}"; shift 2 ;;
    --judge-model) judge_model="${2:?}"; shift 2 ;;
    --no-grade) grade=0; shift ;;
    --keep) keep=1; shift ;;
    -h|--help) usage; exit 0 ;;
    -*) printf 'Unknown option: %s\n' "$1" >&2; usage >&2; exit 2 ;;
    *) scenarios+=("$1"); shift ;;
  esac
done

if [[ "${#scenarios[@]}" -eq 0 ]]; then
  scenarios=("$evals_dir"/scenarios/*.md)
fi
if [[ -z "${EVAL_AGENT_CMD:-}" || "$grade" -eq 1 ]]; then
  command -v claude >/dev/null || { printf 'claude CLI not found; set EVAL_AGENT_CMD and use --no-grade\n' >&2; exit 2; }
fi

toolkit_commit="$(git -C "$repo_dir" rev-parse --short HEAD 2>/dev/null || echo uncommitted)"
toolkit_state=clean
[[ -z "$(git -C "$repo_dir" status --porcelain -- skills 2>/dev/null)" ]] || toolkit_state=modified
results_root="$evals_dir/results"
mkdir -p "$results_root"
summary="$results_root/results.tsv"
[[ -f "$summary" ]] || printf 'time\ttoolkit\tstate\tscenario\tagent\tturns\tchecker\tscore\n' > "$summary"

allowed='Read,Grep,Glob,Write,Edit,Skill,Bash(date:*),Bash(ls:*),Bash(mkdir:*),Bash(cp:*),Bash(cat:*),Bash(find:*),Bash(wc:*),Bash(bash:*)'

# turn_prompt <scenario> <n>: the text block under "## Turn n".
turn_prompt() {
  awk -v want="## Turn $2" '
    $0 == want { inside = 1; next }
    inside && /^## / { exit }
    inside && /^```text$/ { block = 1; next }
    inside && block && /^```$/ { exit }
    inside && block { print }
  ' "$1"
}

for scenario in "${scenarios[@]}"; do
  if [[ ! -f "$scenario" ]]; then
    match=("$evals_dir"/scenarios/"$scenario"*.md)
    [[ -f "${match[0]}" ]] || { printf 'No scenario %s\n' "$scenario" >&2; exit 2; }
    scenario="${match[0]}"
  fi
  id="$(basename "$scenario" .md)"
  stamp="$(date +%Y%m%dT%H%M%S)"
  out="$results_root/$stamp-$id"
  mkdir -p "$out"
  work="$(mktemp -d)"
  project="$work/project"
  mkdir -p "$project/.claude/skills" "$project/.agents/skills"
  ln -s "$repo_dir/skills/discovery-rapid" "$project/.claude/skills/discovery-rapid"
  ln -s "$repo_dir/skills/discovery-rapid" "$project/.agents/skills/discovery-rapid"
  printf '[%s] %s in %s\n' "$stamp" "$id" "$project"

  # Seed lines put files into the project before the first turn: "Seed: <repo path> -> <project path>".
  while IFS= read -r seed; do
    from="${seed%% -> *}"; to="${seed##* -> }"
    mkdir -p "$(dirname "$project/$to")"
    cp "$repo_dir/$from" "$project/$to"
  done < <(sed -n 's/^Seed: `\(.*\)` -> `\(.*\)`$/\1 -> \2/p' "$scenario")

  turns="$(grep -c '^## Turn [0-9]' "$scenario")"
  checker_result=passed
  for ((n = 1; n <= turns; n++)); do
    prompt="$(turn_prompt "$scenario" "$n")
(Headless evaluation run: nobody will reply within this session. Finish the session as the Skill describes.)"
    log="$out/turn-$n.txt"
    status=0
    if [[ -n "${EVAL_AGENT_CMD:-}" ]]; then
      (cd "$project" && EVAL_PROMPT="$prompt" sh -c "$EVAL_AGENT_CMD") >"$log" 2>&1 || status=$?
    else
      args=(-p "$prompt" --permission-mode acceptEdits --add-dir "$repo_dir" --allowedTools "$allowed" --no-session-persistence)
      [[ -n "$model" ]] && args+=(--model "$model")
      (cd "$project" && claude "${args[@]}" </dev/null) >"$log" 2>&1 || status=$?
    fi
    [[ "$status" -eq 0 ]] || printf '  turn %d: agent exited with %d\n' "$n" "$status"

    mkdir -p "$out/turn-$n"
    [[ -d "$project/docs/discovery" ]] && cp -R "$project/docs/discovery" "$out/turn-$n/"
    briefs=()
    while IFS= read -r b; do briefs+=("$b"); done < <(find "$project/docs/discovery" -name brief.md -type f 2>/dev/null | sort)
    if [[ "${#briefs[@]}" -eq 0 ]]; then
      printf 'no brief written\n' >"$out/turn-$n/check.txt"
      checker_result=failed
    else
      for b in "${briefs[@]}"; do
        bash "$checker" "$b" >>"$out/turn-$n/check.txt" 2>&1 || checker_result=failed
      done
    fi
    printf '  turn %d: %s\n' "$n" "$(tail -n 1 "$out/turn-$n/check.txt")"
  done

  score='not graded'
  if [[ "$grade" -eq 1 ]]; then
    {
      printf 'You are grading a product discovery agent against a rubric. Be strict and literal.\n'
      printf 'For each rubric line output one line: PASS, FAIL or N/A, the rubric line, and a short reason citing the evidence.\n'
      printf 'MUST/MUST NOT lines that fail are failures; SHOULD lines are reported but count only as PASS or FAIL in the score like the others.\n'
      printf 'End with exactly one line: SCORE: <passed>/<graded>\n\n'
      printf '# Scenario\n\n'; cat "$scenario"
      for ((n = 1; n <= turns; n++)); do
        printf '\n\n# Agent final message, turn %d\n\n' "$n"; cat "$out/turn-$n.txt"
        printf '\n\n# Brief checker output, turn %d\n\n' "$n"; cat "$out/turn-$n/check.txt"
        while IFS= read -r f; do
          printf '\n\n# File after turn %d: %s\n\n' "$n" "${f#"$out/turn-$n/"}"; cat "$f"
        done < <(find "$out/turn-$n" -name '*.md' -type f | sort)
      done
    } >"$out/judge-input.md"
    judge_args=(-p 'Grade the evaluation in the input as instructed in it.' --tools '' --no-session-persistence)
    [[ -n "$judge_model" ]] && judge_args+=(--model "$judge_model")
    claude "${judge_args[@]}" <"$out/judge-input.md" >"$out/grade.md" 2>&1 || true
    score="$(grep -oE 'SCORE: [0-9]+/[0-9]+' "$out/grade.md" | tail -n 1 | cut -d' ' -f2)"
    [[ -n "$score" ]] || score='grading failed'
    printf '  rubric: %s (see %s)\n' "$score" "${out#"$repo_dir"/}/grade.md"
  fi

  agent="${EVAL_AGENT_CMD:+custom}"
  printf '%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\n' "$stamp" "$toolkit_commit" "$toolkit_state" "$id" "${agent:-claude${model:+ $model}}" "$turns" "$checker_result" "$score" >>"$summary"
  if [[ "$keep" -eq 1 ]]; then printf '  kept %s\n' "$project"; else rm -rf "$work"; fi
done
