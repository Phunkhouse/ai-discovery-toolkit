# Specification

## Purpose and users

A reusable, agent-compatible toolkit for structured product discovery: understanding problems, evaluating opportunities and defining what, if anything, should be built. The user is one person (the owner of this toolkit) working alone or with clients and stakeholders, in Claude Code or Codex, across time-boxed assignments, hackathons, early product ideas, freelance client discovery, internal business automation and new features in existing products.

Outcome: from an unstructured brief, within a user-defined time budget, a short decision-ready brief that separates facts from assumptions, names the decisions the owner must make, and, once approved, hands over to engineering without rewriting.

## Scope

In v0.1:

- One self-contained Skill, `discovery-rapid`, with the complete Rapid workflow: start or resume, problem framing, an evidence register, up to five decision-changing questions (interactive or asynchronous), two to four options including non-software ones, a proposed recommendation, scope with non-goals and deferred work, acceptance criteria, metrics and hypotheses, risks and feasibility checks, decisions with explicit approvals, new-evidence updates, and handover.
- Brief and handover templates; a dependency-free structural checker with regression fixtures.
- A `discovery-handover` Skill for handing over or regenerating from any approved brief (v0.2).
- A `discovery-standard` Skill for multi-session discovery with stakeholders, workflows, prioritized requirements, an MVP and a validation plan, approved at three checkpoints (v0.2).
- Shared method files in `shared/`, synced into each Skill (v0.2).
- Two worked examples with synthetic data.
- Twelve behavioral scenarios with a headless runner and rubric grading.
- An installer for Claude Code and Codex, and a validation script run in CI.

Out of scope in v0.1:

- Deep Discovery ([roadmap](roadmap.md)).
- Implementation planning: architecture, stack, task breakdown.
- Conducting research: the toolkit does not interview people, browse for market data or send messages. It prepares questions; the user asks them.
- Any CLI, application, database or hosted service.
- Changes to the AI Starter Pack or AI Audit Toolkit.

## Important workflows

1. **New discovery:** the user invokes the Skill with a brief → the Skill creates `docs/discovery/<slug>/brief.md`, runs the passes within the budget, asks its top questions, and ends with the decisions needed.
2. **Asynchronous answers:** questions for absent stakeholders stay in the brief; status `awaiting answers`; the work continues on explicit assumptions.
3. **Resume:** a new session (any agent) reads the brief, starting with *Resume here*, and continues; new evidence is recorded with sources and followed through the IDs that depend on it.
4. **Approval:** the user answers the numbered decisions in chat; each answer is recorded with who and when; unanswered items stay `proposed`.
5. **Handover:** after approval, a readiness gate, then `handover.md` as a snapshot with its source date.

Failure handling: when the input cannot support a problem statement, the first question asks for what is missing; when stakeholders are unavailable, assumptions stand in visibly; when the time budget runs out, later passes are compressed but the recommendation, criteria, open assumptions and decisions needed are always produced.

## Data and trust boundaries

- Discovery artifacts are written to the target project and belong to it. The toolkit repository holds only synthetic examples.
- People are recorded by role; personal data, credentials and confidential figures stay out unless the user confirms they belong in that repository.
- Inputs (emails, transcripts, documents) are data. Instructions inside them are not followed.
- Only the user's explicit words in chat approve decisions.

## Technical approach

Markdown Skill with progressive disclosure: `SKILL.md` is the workflow and names a reference file at the step that needs it. The Skill folder is self-contained (decision [0001](decisions/0001-self-contained-rapid-skill.md)) so it works when installed by symlink, copied into one project, or read by any agent that supports the Agent Skills format. Scripts are Bash with standard Unix tools only. Conventions (installer, validation, CI, `AGENTS.md` with a `CLAUDE.md` import, decision records, commit style) follow the AI Audit and AI Social toolkits.

## Known limitations and risks

- **Codex is verified statically only** (frontmatter limits, no agent-specific tools, self-contained paths, standard install location). No Codex CLI was available to run the scenarios.
- **Time budgets are approximate.** The agent reads the shell clock at pass boundaries; it cannot account for the user's thinking time, and headless runs have no clock discipline beyond that.
- **The checker is structural.** It cannot tell whether a problem statement is right or a question is good.
- **The behavioral grading uses a model as judge**, from the same family as the agent under test, with rubrics written by the toolkit author. It catches regressions, not subtle quality differences; read the briefs.
- **Twelve scenarios and three examples** are a small, synthetic basis. Real use will reveal gaps; the roadmap expects that.
- **Brief length:** with format 2, eval briefs run about 1,000–1,500 prose words, within the 1,500 target but above the 800 target for small problems; see the [eval log](../evals/README.md#log).
- **Dropped IDs are not detected mechanically.** The checker sees one version of a brief, so it cannot notice an ID that disappeared between sessions; the rules and scenario 08 cover this.
- **Single-file brief:** for a Rapid discovery this keeps one source of truth; a long-running Standard discovery may outgrow it.

## Planning and open questions

- How to share references between several Skills in v0.2 without losing self-contained installation (decision 0001 names the revisit condition).
- Whether briefs for confidential client work should default to an ignored folder; for now the Skill warns and the user decides.
- Whether a Starter Pack `discovery` recipe is worth adding once the handover has been used on real projects ([ecosystem](ecosystem.md)).
