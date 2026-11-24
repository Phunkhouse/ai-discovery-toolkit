# 0001. One self-contained Rapid Discovery Skill, Markdown-first

Date: 2026-11-24  
Status: accepted

## Context

The toolkit must work in Claude Code and Codex, install and update easily across machines, add no runtime dependencies, load context progressively, and keep discovery artifacts in the target project. The sibling toolkits (AI Audit, AI Social) use one folder per Skill under `skills/`, shared files in top-level `references/` and `templates/` read through `../../` paths, a symlinking `install.sh` for `~/.claude/skills` and `~/.agents/skills`, and a `validate.sh` run in CI. Their READMEs note that a single Skill folder copied elsewhere stops working because the shared files are outside it.

v0.1 needs one complete workflow (Rapid), not a family of Skills.

## Decision

- **One Skill, `discovery-rapid`, containing everything it reads:** `SKILL.md` (the workflow), `references/` (rules, questions, options, scope and metrics, handover), `templates/` (brief, handover) and `scripts/check-brief.sh`, all referenced relative to `SKILL.md`. Paths never leave the folder.
- **Progressive disclosure inside the Skill:** `SKILL.md` names each reference at the step that needs it; only `rules.md` is read up front.
- **Two artifacts per discovery in the target project:** `docs/discovery/<slug>/brief.md`, the single source of truth with a rewritten *Resume here* section for session continuity, and `handover.md`, a dated snapshot written only after approval. No separate notes, logs or state files.
- **Typed IDs** (`F-`, `S-`, `R-`, `A-`, `Q-`, `X-`, `D-`, `AC-`, …) for lightweight traceability, and a Bash/awk checker for structure and references.
- **Sibling conventions otherwise:** the same installer (behavior and options), `validate.sh` with a single CI job, `AGENTS.md` canonical with `CLAUDE.md` importing it, decision records, commit style.
- **No `workflows/` directory.** In a skill-first design the workflow is the Skill; a separate workflow file would duplicate it.

## Alternatives considered

- **Shared top-level `references/` and `templates/`, as in the sibling toolkits:** consistent with them and ready for several Skills, but breaks when the Skill is copied into a single project or a client machine, and relies on agents resolving `../../` through a symlink. Not needed while there is one Skill.
- **Several modular Skills now (frame, questions, options, handover):** closer to the v0.2 goal, but more installation surface and more chances for the agent to run a step out of context, before real usage shows where the seams are.
- **Separate files per concern in the target project (assumptions register, decision log, questions, status):** mirrors the Starter Pack's MVP profile, but spreads one Rapid discovery over several files that drift; a single brief with IDs keeps one source of truth.
- **A CLI or structured data (YAML/JSON) for the register:** machine-checkable, but adds tooling, is harder to read and edit in conversation, and is not needed for the checks v0.1 makes.

## Consequences

- The Skill works when symlinked by the installer, copied into one project's `.claude/skills/` or `.agents/skills/`, or read directly.
- The brief format (headings, ID prefixes, status values) is a contract with every project that keeps briefs; changing it needs the checker, templates, examples and fixtures to change together.
- **Revisit** when v0.2 adds a second Skill that needs the same references: choose between a shared folder resolved by the installer, duplication checked by `validate.sh`, or one Skill with profile-specific workflow files.
