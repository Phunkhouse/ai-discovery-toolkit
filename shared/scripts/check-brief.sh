#!/usr/bin/env bash
# Structural check for a Rapid or Standard discovery brief (and its handover, when handed over).
# It checks structure and traceability, not the quality of the thinking.
set -euo pipefail

usage() {
  cat <<'USAGE'
Usage: check-brief.sh [--template] <brief.md>

Checks a format 2 discovery brief: header fields, required sections, unfilled placeholders,
duplicate or undefined IDs, recorded approvals, the content a brief needs before
approval, and, when handed over, that handover.md exists, is current and cites only
IDs the brief defines. The profile line (Rapid or Standard) selects the required
sections. Warns when a brief exceeds its profile's length target (1,500 prose words
for Rapid, 3,500 for Standard) or open-question limit (5 or 10).
--template checks only the structure (for the template itself).
Exit status: 0 no errors (warnings may be printed), 1 errors found, 2 usage error.
USAGE
}

template=0
brief=''
for arg in "$@"; do
  case "$arg" in
    --template) template=1 ;;
    --help|-h) usage; exit 0 ;;
    -*) printf 'Unknown option: %s\n' "$arg" >&2; usage >&2; exit 2 ;;
    *) [[ -z "$brief" ]] || { usage >&2; exit 2; }; brief="$arg" ;;
  esac
done
[[ -n "$brief" ]] || { usage >&2; exit 2; }
[[ -f "$brief" ]] || { printf 'error: %s: file not found\n' "$brief" >&2; exit 2; }

handover="$(dirname -- "$brief")/handover.md"
files=("$brief")
status_line="$(grep -m1 -E '^- \*\*Status:\*\* ' "$brief" || true)"
if [[ "$template" -eq 0 && "$status_line" == *'handed over'* && -f "$handover" ]]; then
  files+=("$handover")
fi

# The awk program prints "error: …" and "warning: …" lines.
output="$(awk -v template="$template" -v handover_expected="$([[ "$status_line" == *'handed over'* ]] && echo 1 || echo 0)" '
function trim(s) { gsub(/^[ \t]+|[ \t]+$/, "", s); gsub(/\*\*/, "", s); return s }
function err(msg) { printf "error: %s:%d: %s\n", FILENAME, FNR, msg; errors++ }
function errf(msg) { printf "error: %s: %s\n", FILENAME, msg; errors++ }
function warn(msg) { printf "warning: %s:%d: %s\n", FILENAME, FNR, msg }
function strip_code(s) { gsub(/`[^`]*`/, "", s); return s }
# Collect ID references on a line, skipping matches glued to a preceding letter or digit.
function collect_refs(s, is_brief,   rest, pre, id, offset) {
  rest = strip_code(s); pre = ""
  while (match(rest, /(SRC|RK|AC|F|S|R|C|A|Q|X|O|D|M|H|P|W)-[0-9]+/)) {
    id = substr(rest, RSTART, RLENGTH)
    pre = (RSTART > 1) ? substr(rest, RSTART - 1, 1) : ""
    if (pre !~ /[A-Za-z0-9]/) {
      if (!(id in refline)) { refline[id] = FNR; reffile[id] = FILENAME }
    }
    rest = substr(rest, RSTART + RLENGTH)
  }
}
function check_placeholders(s,   t) {
  t = strip_code(s)
  gsub(/<!--[^>]*-->/, "", t); gsub(/<!--.*/, "", t); gsub(/<\/?br *\/?>/, "", t)
  if (t ~ /<[A-Za-z][^<>]*>/) err("unfilled placeholder: " t)
}

FNR == 1 { file_index++ ; in_comment = 0 }

# ---------- the brief ----------
file_index == 1 {
  line = $0
  if (line ~ /<!--/ && line !~ /-->/) in_comment = 1
  if (line ~ /<!--/) comments++
  if (in_comment) { if (line ~ /-->/) in_comment = 0; next }

  if (!seen_title && line ~ /[^ \t]/) {
    seen_title = 1
    if (line !~ /^# Discovery brief: .+/) err("first line must be \"# Discovery brief: <title>\"")
  }
  if (line ~ /^## /) { section = substr(line, 4); subsection = ""; sections[section] = 1 }
  else if (line ~ /^### /) { subsection = substr(line, 5); subsections[section "/" subsection] = 1 }

  if (line ~ /^- \*\*Status:\*\* /) {
    status = line; sub(/^- \*\*Status:\*\* /, "", status); status = trim(status)
    if (status !~ /^(in progress|awaiting answers|awaiting approval|approved|handed over|closed)$/)
      err("Status must be one of: in progress, awaiting answers, awaiting approval, approved, handed over, closed")
  }
  if (line ~ /^- \*\*Profile:\*\* /) { profile = line; sub(/^- \*\*Profile:\*\* /, "", profile); sub(/[^A-Za-z].*$/, "", profile) }
  if (line ~ /^- \*\*Format:\*\* /) { format = line; sub(/^- \*\*Format:\*\* /, "", format); format = trim(format) }
  if (section == "Scope" && match(line, /^- \*\*(Must have|Optional|Non-goals|Deferred):\*\*/)) {
    label = substr(line, 5, RLENGTH - 7); scope_lines[label] = 1
    value = substr(line, RLENGTH + 1); value = trim(value)
    if (label == "Non-goals" && value != "" && value !~ /^None\.?$/) nongoals++
  }
  if (line ~ /^- \*\*Updated:\*\* /) {
    updated_seen = 1
    if (line !~ /^- \*\*Updated:\*\* [0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]/ && !template)
      err("Updated must start with a YYYY-MM-DD date")
  }

  if (template) next
  check_placeholders(line)

  # Definitions: first table cell, or a list item that starts with a bold ID.
  def = ""
  if (line ~ /^\|/) {
    n = split(line, cell, "|"); def = trim(cell[2])
  } else if (line ~ /^- (\[[ xX]\] )?\*\*[A-Z]+-[0-9]+/) {
    def = line; sub(/^- (\[[ xX]\] )?\*\*/, "", def); sub(/[^A-Z0-9-].*$/, "", def)
  }
  if (def ~ /^(SRC|RK|AC|F|S|R|C|A|Q|X|O|D|M|H|P|W)-[0-9]+$/) {
    if (def in defined) err("duplicate ID " def " (first defined on line " defined[def] ")")
    else defined[def] = FNR
    prefix = def; sub(/-.*/, "", prefix); count[prefix]++
    if (prefix == "D" && line ~ /^\|/ && section == "Decisions") {
      dstatus = trim(cell[5]); dby = trim(cell[6])
      if (dstatus ~ /^(approved|rejected)/) {
        if (dstatus ~ /^approved/) approved++
        if (dby !~ /[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]/) err(def " is " dstatus " but \"By and date\" has no YYYY-MM-DD date")
      }
    }
    if (prefix == "Q" && line ~ /^\|/) {
      qstatus = trim(cell[n - 1]); if (qstatus ~ /^open/) open_questions++
    }
  }
  collect_refs(line, 1)
  next
}

# ---------- the handover ----------
file_index == 2 {
  handover_seen = 1
  line = $0
  if (line ~ /<!--/ && line !~ /-->/) in_comment = 1
  if (in_comment) { if (line ~ /-->/) in_comment = 0; next }
  if (line ~ /^- \*\*Source:\*\*/) {
    source_seen = 1; src = line
    if (match(src, /Updated [0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]/)) handover_date = substr(src, RSTART + 8, 10)
    else err("Source line must name the brief'"'"'s Updated date as \"Updated YYYY-MM-DD\"")
  }
  check_placeholders(line)
  collect_refs(line, 0)
}

END {
  FILENAME = ARGV[1]
  if (("What we know" in sections) || format == "1") {
    errf("format 1 brief (v0.1); ask discovery-rapid to convert it to format 2, keeping every ID")
    printf "summary\t%s\t%d\t\n", status, errors; exit
  }
  if (format != "2") errf("missing \"- **Format:** 2\" line")
  if (status == "") errf("missing \"- **Status:** …\" line")
  if (!updated_seen) errf("missing \"- **Updated:** YYYY-MM-DD by …\" line")
  if (profile !~ /^(Rapid|Standard)$/) errf("Profile line must start with Rapid or Standard")
  split("Resume here|Problem|Register|Open questions|Options and recommendation|Scope|Acceptance criteria|Success|Decisions", req, "|")
  for (i in req) if (!(req[i] in sections)) errf("missing section \"## " req[i] "\"")
  if (profile == "Standard") {
    split("Stakeholders|User workflows|Requirements|Validation plan", reqstd, "|")
    for (i in reqstd) if (!(reqstd[i] in sections)) errf("missing section \"## " reqstd[i] "\" (Standard profile)")
  }
  split("Must have|Non-goals|Deferred", reqscope, "|")
  for (i in reqscope) if (!(reqscope[i] in scope_lines)) errf("missing \"- **" reqscope[i] ":** …\" line in Scope")
  if (template) { printf "summary\t%s\t%d\t\n", status, errors; exit }

  for (id in refline) if (!(id in defined))
    printf "error: %s:%d: %s is referenced but not defined in the brief\n", reffile[id], refline[id], id
  for (id in refline) if (!(id in defined)) errors++

  if (status ~ /^(awaiting approval|approved|handed over)$/) {
    if (count["AC"] < 1) errf("status \"" status "\" needs at least one acceptance criterion (AC-)")
    if (nongoals < 1) errf("status \"" status "\" needs at least one non-goal")
    if (count["M"] < 1) errf("status \"" status "\" needs at least one metric (M-)")
    if (count["D"] < 1) errf("status \"" status "\" needs a recommended decision (D-)")
    if (profile == "Standard") {
      if (count["P"] < 1) errf("status \"" status "\" needs at least one stakeholder (P-) in a Standard brief")
      if (count["W"] < 1) errf("status \"" status "\" needs at least one user workflow (W-) in a Standard brief")
      if (count["H"] < 1) errf("status \"" status "\" needs at least one hypothesis (H-) in the validation plan")
    }
  }
  if (status ~ /^(approved|handed over)$/ && approved < 1)
    errf("status \"" status "\" needs at least one decision marked approved, with who and when")
  if (handover_expected && !handover_seen) errf("status is \"handed over\" but handover.md is missing next to the brief")
  if (handover_seen && !source_seen) { printf "error: %s: missing \"- **Source:** brief.md, Updated YYYY-MM-DD\" line\n", ARGV[2]; errors++ }
  qlimit = (profile == "Standard") ? 10 : 5
  if (open_questions > qlimit) printf "warning: %s: %d open questions; %s Discovery keeps at most %d per round\n", ARGV[1], open_questions, profile, qlimit
  if (comments > 0 && status != "in progress") printf "warning: %s: template guidance comments remain\n", ARGV[1]
  printf "summary\t%s\t%d\t%s\n", status, errors, handover_date
}
' "${files[@]}")"

summary="$(printf '%s\n' "$output" | grep '^summary' || true)"
printf '%s\n' "$output" | grep -v '^summary' || true
errors="$(cut -f3 <<<"$summary")"
handover_date="$(cut -f4 <<<"$summary")"
brief_date="$(grep -m1 -oE '^- \*\*Updated:\*\* [0-9]{4}-[0-9]{2}-[0-9]{2}' "$brief" | grep -oE '[0-9]{4}-[0-9]{2}-[0-9]{2}' || true)"
# Count prose words: table pipes, separator rows and list markers are not words.
words="$(sed -E 's/\|/ /g; s/(^| )-{3,}( |$)/ /g; s/(^| )- (\[[ xX]\] )?/ /g' "$brief" | wc -w | tr -d ' ')"
if grep -qE '^- \*\*Profile:\*\* Standard' "$brief"; then
  limit=3500; target='a Standard brief aims for under about 3,500'
else
  limit=1500; target='a Rapid brief aims for under about 1,500 (under 800 for a small problem)'
fi
if [[ "$template" -eq 0 && "$words" -gt "$limit" ]]; then
  printf 'warning: %s: %s words; %s\n' "$brief" "$words" "$target"
fi
if [[ -n "$handover_date" && -n "$brief_date" && "$brief_date" > "$handover_date" ]]; then
  printf 'warning: %s: handover source date %s is older than the brief (Updated %s); regenerate the handover\n' "$handover" "$handover_date" "$brief_date"
fi

if [[ "${errors:-1}" -gt 0 ]]; then
  printf 'FAILED: %s (%s errors)\n' "$brief" "$errors"
  exit 1
fi
printf 'OK: %s\n' "$brief"
