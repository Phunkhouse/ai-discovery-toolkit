# Project instructions

Project overview: `README.md`. Scope, limitations and open questions: `docs/SPEC.md`. Boundaries with the other toolkits: `docs/ecosystem.md`. Decision records: `docs/decisions/`.

This repository is a toolkit, not an application: Skills, references, templates and small shell scripts that other projects use. Discovery artifacts belong to the projects being discovered, never to this repository. Changes here reach every project that uses the toolkit, so keep them general and deliberate.

## Commands

- `./scripts/validate.sh` — checks Skill frontmatter (portable to Claude Code and Codex), bundled file references, Markdown links, script syntax, the brief checker against the template, examples and regression fixtures, and the eval scenario format. Run it before finishing any change.
- `./scripts/sync-shared.sh [--check]` — copies the files each Skill lists in its `shared.txt` from `shared/` into the Skill, with a generated-file marker; `--check` fails if any copy differs. Run it after editing anything in `shared/`.
- `./scripts/test-check-brief.sh` — the brief checker's regression cases alone (run against `shared/scripts/check-brief.sh`).
- `bash shared/scripts/check-brief.sh [--template] <brief.md>` — the structural check the Skill runs on a brief (and its handover).
- `./scripts/install.sh [--dry-run] [--claude-only | --codex-only] [--uninstall]` — links the Skills into `~/.claude/skills` and `~/.agents/skills`. Do not run it without `--dry-run` unless the user asks.
- `evals/run.sh [--model M] [--no-grade] [--keep] [scenario …]` — behavioral scenarios, run headlessly and graded against their rubrics. Costs model usage; run only when the user asks or before releasing a change to the Skill's instructions, and say so.

Bash and standard Unix tools only; no package dependencies. When adding or changing a script, update this section.

## Toolkit rules

- **Problem first, evidence over assumptions, the owner decides.** No change may let a Skill mark something approved without the user's explicit words, turn a statement or assumption into a fact without a source, or present an estimate as a measurement. Changes that touch these rules need a decision record.
- **Skills are self-contained** (decision 0001): everything a Skill reads lives in its own folder and is referenced relative to its `SKILL.md`. No `../../` paths. Skills never call or require each other.
- **Shared files are edited only in `shared/`** (decision 0003). A Skill lists the ones it uses in `shared.txt`; run `./scripts/sync-shared.sh` and commit the regenerated copies with the change. Never edit a file that starts with a "Generated from shared/" marker. Frontmatter has only `name` (equal to the folder) and a single-line `description` of at most 500 characters saying what it does and when to use it.
- **Agent-neutral wording:** write "ask in chat", not tool names of one agent. Anything that only works in one agent is documented as a limitation.
- **Progressive disclosure:** `SKILL.md` holds the workflow; detail goes to `references/` files that the workflow names at the step where they are needed.
- **IDs and the brief format are a contract.** Projects keep briefs for a long time. Never rename an ID prefix, status value or required heading without updating `check-brief.sh`, the templates, the examples and the fixtures together, and add a decision record if existing briefs would stop passing.
- **Proportionality:** Rapid stays small. A capability that needs more belongs in a later profile, not in Rapid.
- **Behavioral changes need evidence:** when changing the Skill's instructions, add or update an eval scenario that would catch a regression, and record any eval run in `evals/README.md`.

## Changes

- Keep diffs focused. Record lasting trade-offs in `docs/decisions/` (copy `template.md`, next free number).
- Name commits `type: short imperative summary`, using lowercase `feat`, `fix`, `docs`, `refactor`, `test` or `chore`.
- Update `CHANGELOG.md` for every user-visible change.
- **Assume this repository is public.** No secrets, real client briefs, real stakeholder names or real business data. Examples and scenarios use invented organizations and synthetic numbers.

## Pull requests

- Work through multiple PRs sequentially, at most one agent-authored PR awaiting review at a time, unless the user asks for parallel work.
- When a change requires action in projects that use the toolkit (a changed brief format, a renamed status), put a `> [!IMPORTANT]` block at the top of the PR description saying what to do and how to verify it, and repeat it in chat.
- Leave the merge to the user unless they explicitly ask you to perform it.
