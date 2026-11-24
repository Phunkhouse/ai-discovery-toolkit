# Changelog

## Unreleased (v0.2)

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
