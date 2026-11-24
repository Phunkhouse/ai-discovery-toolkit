# Changelog

## Unreleased (v0.2)

- Rules: a system, dataset or capability the inputs do not mention is treated as an assumption wherever an option, requirement or criterion depends on it (found in eval scenario 01).
- **New Skill `discovery-standard`** ([decision 0004](docs/decisions/0004-standard-profile-one-brief.md)): stakeholder map (`P-`), question packs and out-of-order replies, user workflows (`W-`), must/should/could/won't requirements, MVP scope, a validation plan with thresholds set before testing, and three approval checkpoints. Upgrades a Rapid brief in place. Rerun `./scripts/install.sh` to install it.
- The shared checker selects required sections from the profile line and applies Standard's limits (3,500 words, 10 open questions); the shared rules list limits per profile; the handover template gains an optional User workflows section and the readiness gate a Standard item.
- Third worked example (Standard, a freelance client engagement) and eval scenarios 11 and 12.
- **Shared method files** ([decision 0003](docs/decisions/0003-shared-method-synced-copies.md)): rules, references, the handover template and the checker live once in `shared/` and are copied into each Skill by `scripts/sync-shared.sh`; `validate.sh` fails on drift. Skill folders stay self-contained.
- **New Skill `discovery-handover`:** hands over an approved brief or regenerates a stale handover, with the readiness gate reported item by item. Rerun `./scripts/install.sh` to install it.
- **Brief format 2** ([decision 0002](docs/decisions/0002-compact-brief-format.md)): one register table for facts, statements, requirements, constraints, assumptions, conflicts and risks; scope as labelled lines; a `Format: 2` header. IDs, statuses, approval rules and the handover are unchanged.
- The Skill converts a v0.1 (format 1) brief when it resumes one, keeping every ID; the checker reports format 1 briefs as needing conversion.
- The checker warns when a brief exceeds 1,500 prose words.
- Examples and checker fixtures converted; new eval scenario 08 (resume a v0.1 brief) and `Seed:` support in `evals/run.sh`.

## v0.1.0 — 2026-11-24

First release: Rapid Discovery.

- `discovery-rapid` Skill: time-boxed problem framing, evidence register, decision-changing questions (interactive or asynchronous), options including non-software and no-build outcomes, scope, acceptance criteria, metrics, risks, explicit owner approvals, resume from the brief in a new session, and handover to engineering.
- Brief and handover templates; `check-brief.sh` structural checker with regression fixtures.
- Two worked examples with synthetic data.
- Seven behavioral eval scenarios with a headless runner and rubric grading.
- `install.sh` for Claude Code and Codex, `validate.sh`, and a CI workflow.
- Documentation: specification, ecosystem boundaries and handover contract, roadmap, decision record 0001.
