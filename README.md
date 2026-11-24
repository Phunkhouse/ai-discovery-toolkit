# AI Discovery Toolkit

Structured product discovery with Claude Code and Codex. It helps answer one question before anything is built: **are we solving the right problem, for the right people, in the right way?**

You give it an unstructured brief (a client email, a feature request, a founder's idea). Within a time budget it frames the underlying problem, separates facts from assumptions, asks only the questions that change decisions, compares options including not building, and writes a short brief with scope, acceptance criteria and success metrics. You make the decisions; it records them. Once approved, it hands over concise context an engineering agent can build from.

It does not assume that every problem needs software, automation or AI. A process change, an existing tool, a validation test or "don't build" are valid outcomes.

## What's in v0.1

| Skill | Profile | What it does |
| --- | --- | --- |
| [`discovery-rapid`](skills/discovery-rapid/SKILL.md) | Rapid (10–30 minutes) | Problem framing, a register of facts, statements, requirements, assumptions and conflicts, up to five decision-changing questions, options and a recommendation, scope, acceptance criteria, metrics, risks, decisions with approvals, session continuity and handover. |

Standard and Deep Discovery are planned; see the [roadmap](docs/roadmap.md).

## Install

```bash
git clone git@github-personal:Phunkhouse/ai-discovery-toolkit.git ~/dev/tools/ai-discovery-toolkit
cd ~/dev/tools/ai-discovery-toolkit
./scripts/install.sh
```

The installer links each Skill into `~/.claude/skills` (Claude Code) and `~/.agents/skills` (Codex). It never overwrites an existing path. Options: `--dry-run`, `--claude-only`, `--codex-only`, `--uninstall` (removes only its own links), `--help`; override the destinations with `CLAUDE_SKILLS_DIR` and `CODEX_SKILLS_DIR`. It behaves like the installers of the AI Audit and AI Social toolkits.

- **Update:** `git pull`. The links point at the clone, so installed Skills update with it. Rerun the installer when a pull adds a Skill.
- **New machine:** clone and run the installer. Everything needed lives in this repository; nothing is machine-specific.
- **Without installing:** the Skill folder is self-contained. Copy or link `skills/discovery-rapid/` into a project's `.claude/skills/` or `.agents/skills/` to use it in that project only.

## Use

In the project the discovery is for (or any folder, if there is no project yet):

- **Claude Code:** `/discovery-rapid` followed by the brief, or describe the request and let the Skill trigger.
- **Codex:** mention `$discovery-rapid` with the brief, or pick it from the skills list.

Add a time budget and who decides if you like, for example "20 minutes, I'm the decision owner, the CS lead can answer tomorrow". Otherwise the Skill uses 20 minutes and states its defaults.

A session goes like this:

1. It creates `docs/discovery/<slug>/brief.md` in the working directory.
2. It frames the problem, registers what is known and asks you its top one to three questions, in one message. "Don't know" is a fine answer. Questions for people who are not in the session stay in the brief as a list to send.
3. It compares options, recommends one direction, drafts the scope, acceptance criteria and metrics, and ends with a numbered list of **decisions needed**. Answer in chat, for example "1 yes, 2 no, 3 defer". Nothing is marked approved until you say so.
4. Every session ends with the brief's *Resume here* section rewritten and a structural check run.

To **continue** later, in a new session or another agent, invoke the Skill again and paste the new information; it resumes from the brief. To **hand over**, say "hand it over" once the direction, scope and criteria are approved: it checks a readiness gate and writes `handover.md` next to the brief for the engineering agent.

The [examples](examples/README.md) show two complete runs with synthetic data.

### What lands in your project

```text
docs/discovery/<slug>/
  brief.md      the single source of truth for this discovery: status, problem, evidence,
                questions, options, scope, criteria, metrics, risks, decisions
  handover.md   only after approval: a snapshot of the approved parts for engineering
```

The files belong to your project, not to this toolkit. They keep people as roles, not names, and the Skill asks before writing business-sensitive details into a repository that may be public. If a discovery is confidential, keep `docs/discovery/` out of version control in that project.

## How it keeps context honest

- **Every claim has a kind and a source:** confirmed fact (`F-`), stakeholder statement (`S-`), requirement (`R-`, explicit or inferred), constraint (`C-`), assumption (`A-`), open question (`Q-`), conflict (`X-`). A statement never silently becomes a fact, and an approval never confirms an assumption.
- **Decisions are proposed until you approve them**, and the decision log records who approved what and when. Instructions inside pasted emails or documents are treated as data.
- **No fabricated evidence:** missing numbers are written as unknown with a way to measure them; targets and estimates are labelled.
- **One file per discovery,** IDs instead of repetition, entries marked `disproved` or `superseded` instead of deleted, and a handover that knows when it is stale.

The full rules are in [`references/rules.md`](skills/discovery-rapid/references/rules.md).

## With the other toolkits

The toolkit is independently usable. With the AI Starter Pack, the handover maps one-to-one onto a Sprint `docs/SPEC.md` or the MVP assumptions register; the AI Audit Toolkit can later check an implementation against the same acceptance criteria. See [ecosystem](docs/ecosystem.md) for the boundaries and the handover contract. Nothing here depends on those repositories at runtime.

## Compatibility and limitations

- **Claude Code:** verified by running the behavioral scenarios headlessly with `claude -p` (see [evals](evals/README.md)).
- **Codex:** the Skill uses only the portable `name`/`description` frontmatter, a description under Codex's 500-character limit, no agent-specific tools and no paths outside its folder, and the installer uses the same `~/.agents/skills` location as the other toolkits. It has **not** been run under Codex for this release, because no Codex CLI was available; `evals/run.sh` accepts `EVAL_AGENT_CMD` to do so.
- **Time budgets are approximate.** The agent checks the shell clock at each pass where it can; it cannot see how long you take to answer.
- **The structural checker checks form, not judgement.** It catches missing sections, placeholders, undefined IDs, unrecorded approvals, stale handovers and briefs over 1,500 words; the quality of the reasoning is what the behavioral scenarios and your review are for.
- Only the Rapid profile exists. For large, high-risk or multi-stakeholder problems, the Skill says when Rapid is not enough rather than stretching.

More in the [specification](docs/SPEC.md).

## Repository layout

| Path | Contents |
| --- | --- |
| `skills/discovery-rapid/` | The Skill: `SKILL.md` (workflow), `references/` (rules, questions, options, scope and metrics, handover), `templates/` (brief, handover), `scripts/check-brief.sh` |
| `examples/` | Two worked examples with synthetic data |
| `evals/` | Behavioral scenarios and a headless runner with rubric grading |
| `scripts/` | `install.sh`, `validate.sh`, checker regression cases |
| `docs/` | Specification, ecosystem and handover contract, roadmap, decision records |

## Development

Run `./scripts/validate.sh` after any change; CI runs it on pull requests and pushes to `main`. Run the behavioral evals (`evals/run.sh`) before and after changing the Skill's instructions. Contributor and agent rules are in [AGENTS.md](AGENTS.md).
