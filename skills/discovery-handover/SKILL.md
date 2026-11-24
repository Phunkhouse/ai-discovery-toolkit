---
name: discovery-handover
description: Hand over an approved discovery brief in docs/discovery/ to engineering, or regenerate a stale handover - check the readiness gate, write handover.md from the approved parts only, and mark the brief handed over. Use when a discovery is approved and someone asks to hand it over, start building from it, or refresh its handover.
---

# Discovery handover

Turn an approved discovery brief into `handover.md`: short, actionable context for whoever builds it, carrying only what the owner approved plus the open assumptions and questions the builders must know about. This Skill does not run discovery and does not make product decisions.

Files in this Skill are relative to this `SKILL.md`. Read `references/rules.md` first; it applies throughout. Then read `references/handover.md`, which defines the readiness gate and how to write the handover.

## 1. Find the brief

- Use the path the user gives. Otherwise look for `docs/discovery/*/brief.md` under the working directory. If there are several, list them with their status and ask which one. If there are none, say so: a discovery has to come first.
- Run `bash scripts/check-brief.sh <path to brief.md>`. If it reports a format 1 brief, ask the user to resume it with the discovery Skill (for example `discovery-rapid`) to convert it first; do not convert it here. Fix nothing else in the brief silently; report other errors.

## 2. Check the readiness gate

Go through each gate item in `references/handover.md` against the brief and report the result in a short list, naming the IDs involved (for example "D-3 still proposed", "X-1 open and affects R-2", "A-2 has no check").

- **All met:** continue.
- **Not met:** do not write the handover. Show what is missing and offer two ways forward:
  1. **Resolve now:** the user approves, rejects or accepts the named items in chat. Record each answer in the brief as the rules require (who, when; an accepted assumption stays unverified), then check the gate again.
  2. **Hand over with named gaps:** only if the user explicitly says so. Record that decision in the brief's decision log with who and when, and list every gap in the handover's open assumptions or open questions, so the builders see it.

Never treat a request to hand over as approval of anything still `proposed`.

## 3. Write or regenerate

- **New handover:** follow "Writing it" in `references/handover.md`, using `templates/handover.md`. Remove all template comments, including the generated-file marker on its first line.
- **Existing handover:** if the brief's `Updated` date is later than the handover's source date, the handover is stale. Re-check the gate (later changes may have reopened decisions), then rewrite `handover.md` from the current brief. Do not patch the old one by hand; Git keeps its history.
- If the direction is not a build (change a process, adopt a tool, validate first, defer, don't build), the handover describes that next step and says plainly that no software is in scope.

## 4. Finish

1. In the brief: set `Status` to `handed over`, add the handover to the decision log, rewrite *Resume here*, and set `Updated` to the date written into the handover's source line.
2. Run `bash scripts/check-brief.sh <path to brief.md>` again; it also checks `handover.md`. Fix every error.
3. Report in chat: where the handover is, the direction, the open assumptions and questions the builders must know about, and how to use it: give `handover.md` to the engineering agent, or, with the AI Starter Pack, fill the project's specification from it as `references/handover.md` describes.
