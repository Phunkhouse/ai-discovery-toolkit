# 0003. Shared method files as synced copies

Date: 2026-11-24  
Status: accepted

## Context

v0.2 adds Skills beyond `discovery-rapid` (a handover Skill now, `discovery-standard` next) that need the same rules, references, handover template and checker. Decision [0001](0001-self-contained-rapid-skill.md) made the Rapid Skill self-contained and named this moment as its revisit condition. Copying a single Skill folder into a project must keep working, and the slash commands should stay stable.

## Decision

- **One source in `shared/`**, mirroring the Skill layout (`shared/references/`, `shared/templates/`, `shared/scripts/`).
- **Each Skill lists what it uses** in `skills/<name>/shared.txt`, one path per line relative to `shared/`.
- **`scripts/sync-shared.sh` copies** those files into the Skill at the same relative path, with a first-line marker saying the file is generated and where to edit it. `--check` regenerates in memory and fails on any difference; `validate.sh` runs it, so CI catches an edited copy or a forgotten sync.
- **Skills never call each other.** `discovery-rapid` still performs handovers itself from the shared handover reference; `discovery-handover` is a separate entry point for the same procedure, usable on any brief.
- The owner chose this option on 2026-11-24 over one Skill with profiles inside, a `../../` shared folder like the sibling toolkits, and fine-grained step Skills.

## Alternatives considered

- **One `discovery` Skill with profile workflows inside:** no duplication, but renames the command and grows one Skill with every profile.
- **A shared folder read through `../../`, as in the AI Audit and AI Social toolkits:** no copies, but a Skill copied alone stops working, reversing 0001.
- **Fine-grained step Skills (frame, questions, options, handover) orchestrated by profile Skills:** the most modular, but more to install, and a step run on its own lacks the context the profile Skill carries. Only handover is a step people genuinely invoke on its own, so only it becomes a Skill.

## Consequences

- Copies are committed, so a Skill folder is complete on its own and `git pull` updates everything.
- Editing a copy instead of `shared/` fails validation with a message naming the source file.
- The repository holds duplicate text by design; reviews should read `shared/` and skip generated copies.
- Revisit if the number of Skills makes the copies unwieldy, or if both agents gain a standard way to share files between Skills.
