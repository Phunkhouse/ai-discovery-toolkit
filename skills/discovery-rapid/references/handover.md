# Handover to engineering

The handover turns an approved brief into short, actionable context for whoever builds it, human or agent. It carries only what is approved, plus the open assumptions and questions the builders must know about.

## Readiness gate

Write a handover only when all of these hold. Otherwise tell the user what is missing and offer to resolve it or to hand over with explicitly listed gaps.

1. The problem statement and the recommendation are `approved` in the decision log.
2. Must-have scope, non-goals and acceptance criteria are approved.
3. Every open assumption that a must-have depends on is either `accepted` by the owner or has a named check that happens before or during the build.
4. No conflict (`X-`) that affects the must-have scope is still open.
5. `scripts/check-brief.sh` passes on the brief.

If the approved direction is not a build (process change, adoption, validation, defer, don't build), say so: the handover then describes that next step, not software.

## Writing it

1. Copy `templates/handover.md` next to the brief as `handover.md`.
2. Fill it from the brief only. Keep IDs (`R-2`, `AC-3`, `A-4`) so every line can be traced back. Do not add requirements, criteria or rationale that are not in the brief.
3. Set the source line to the brief's current `Updated` date. Set the brief's status to `handed over`, add a decision-log entry for the handover, and rewrite *Resume here*.
4. Leave implementation choices to the builders unless the owner set them as constraints (`C-`).

## After handover

- The brief remains the record of why. If the project has its own specification (for example `docs/SPEC.md`), that specification becomes the source of truth for what is being built; the handover is the input to it.
- If engineering finds that an assumption is wrong or a criterion cannot be met, the change goes back through the brief: record the evidence, update the affected entries, get the owner's decision, and regenerate the handover. Do not patch `handover.md` by hand.

## Using it with the AI Starter Pack

Not required. When the target project uses the AI Starter Pack, the handover sections map directly:

| Handover section | Sprint `docs/SPEC.md` | MVP or Production |
| --- | --- | --- |
| Problem and outcome | Goal | `docs/SPEC.md` Purpose and users |
| Must have, acceptance criteria | Acceptance criteria (keep the `AC-` IDs) | `docs/SPEC.md` Scope; milestone acceptance checks |
| Non-goals | Non-goals | `docs/SPEC.md` Scope, out of scope |
| Deferred | Deferred | the project's backlog |
| Confirmed facts, approved requirements and constraints | Facts and assumptions, status `confirmed` | `docs/assumptions.md` Confirmed |
| Open assumptions | Facts and assumptions, status `assumption` | `docs/assumptions.md` Open, with "How it gets confirmed" |
| Decisions and rationale | Decision log, status `decided` | `docs/decisions/` for hard-to-reverse choices |
| Success metrics, material risks | README or SPEC notes | `docs/SPEC.md` Known limitations and risks; Purpose |

Status words map as: confirmed fact → `confirmed`; approved decision → `decided`; open or accepted assumption → `assumption`; proposed decision → `proposal`. Keep the discovery IDs in the source column (for example "discovery brief A-3") so the trail survives.

In a Sprint set-up, the handover can be pasted as "the brief" in the profile's set-up prompt.
