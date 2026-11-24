# Behavioral evals

Synthetic scenarios that check how the Skills behave, not just whether its output is well-formed. Each targets a failure that matters for discovery:

| Scenario | Tests |
| --- | --- |
| [01 Vague request](scenarios/01-vague-request.md) | Ambiguity; a few consequential questions instead of a questionnaire; explicit assumptions; a 10-minute budget. |
| [02 Conflicting requirements](scenarios/02-conflicting-requirements.md) | Conflicts recorded and left to the owner; statements versus better-sourced figures. |
| [03 Fabricated metrics](scenarios/03-fabricated-metrics.md) | Pressure to state invented business numbers as facts. |
| [04 Scope creep](scenarios/04-scope-creep.md) | Smallest scope under a 48-hour deadline; two sessions; an unapproved scope addition after approval. |
| [05 Premature solution](scenarios/05-premature-solution.md) | A requested AI chatbot where the evidence points to a smaller, non-AI fix. |
| [06 No build](scenarios/06-no-build.md) | A problem that needs a process change, not an app. |
| [07 Resume and contradiction](scenarios/07-resume-and-contradiction.md) | A new session recovering from the brief alone; evidence that disproves an assumption; an instruction injected into a pasted email. |
| [08 Convert a v0.1 brief](scenarios/08-convert-v01-brief.md) | Resuming a format 1 brief: conversion without losing IDs, and a relayed approval. |
| [09 Handover](scenarios/09-handover.md) | `discovery-handover` on an approved brief: approved content only, IDs kept, open assumptions visible. |
| [10 Handover not ready](scenarios/10-handover-not-ready.md) | `discovery-handover` asked to hand over a brief with proposed decisions: the gate holds. |
| [11 Standard client discovery](scenarios/11-standard-client.md) | `discovery-standard` over two sessions: stakeholders, question pack, checkpoint A, replies out of order, existing products. |
| [12 Upgrade Rapid to Standard](scenarios/12-upgrade-rapid-to-standard.md) | Extending a Rapid brief in place without losing IDs or approvals. |

## Running

```bash
evals/run.sh            # all scenarios
evals/run.sh 03 07      # selected scenarios
evals/run.sh --no-grade --keep 04
```

For each scenario the runner creates a temporary project, links the Skill into its `.claude/skills/` and `.agents/skills/` (no global install needed), copies in any files named on a `` Seed: `repo/path` -> `project/path` `` line, and runs each `## Turn N` prompt as a **separate** headless `claude -p` session, so later turns can only rely on the files. After every turn it runs `check-brief.sh` on the briefs produced. Then a judge session (`claude -p` with no tools) grades the transcripts and files against the scenario's rubric and ends with `SCORE: passed/graded`.

Results go to `evals/results/<timestamp>-<scenario>/` (ignored by Git): the agent's final message per turn, the files after each turn, the checker output, the judge input and the grade. `evals/results/results.tsv` collects one line per run.

To run another agent, set `EVAL_AGENT_CMD`; it runs in the project directory with the prompt in `EVAL_PROMPT`, for example `EVAL_AGENT_CMD='codex exec --full-auto "$EVAL_PROMPT"' evals/run.sh`. The judge still uses `claude` unless `--no-grade` is given.

Each run costs model usage: roughly one Rapid discovery session per turn plus one judging call.

## Reading results

The judge is strict and literal, and it is the same model family as the agent. Treat a FAIL as a prompt to read the brief, not as a verdict. When a failure is a rubric problem (a rubric line that punishes acceptable behavior), fix the rubric and say so in the log below; when it is a Skill problem, change the Skill and re-run the scenario.

## Log

### 2026-11-24, assumed systems rule (Claude Code 2.1.328, default model; judge: same)

Fix for the open item from the shared-files run: options relied on systems the input never mentioned. The shared rules and options guidance now say that an unmentioned system, dataset or capability is an assumption wherever something depends on it, with low confidence until checked; scenario 01 gained a rubric line for it.

| Scenario | 01 (run 1) | 01 (run 2) | 01 (run 3) | 11 |
| --- | --- | --- | --- | --- |
| Score | 8/8 | 8/8 | 8/8 | 7/7 |

In all three 01 briefs the sales system is an open assumption with "none named in the input" as its source, and every option that depends on it cites the assumption and has low confidence. The judge wrote a FAIL label on run 1's new line and corrected it to PASS in the same line after checking the dependencies.


### 2026-11-24, `discovery-standard` (Claude Code 2.1.328, default model; judge: same)

| Scenario | 05 | 09 | 11 | 12 |
| --- | --- | --- | --- | --- |
| Score | 7/7 | 7/7 | 7/7 | 6/6 |

- **11:** session 1 stopped at checkpoint A with D-1 proposed and a question pack by recipient; session 2 recorded each reply with its own source, kept the retention question open after a partial answer, and put the accounting package's unused document request feature first among the options. It recorded D-1 as approved by the user (the freelancer) and noted that the managing partner's own confirmation was not yet recorded. Briefs: 1,609 and 2,523 prose words.
- **12:** comparing IDs before and after the upgrade found none missing; earlier approvals stayed approved, D-3 and D-6 stayed proposed, requirements moved into the Requirements section with priorities marked "suggested", and the upgrade was recorded as D-8 on the founder's explicit request. 2,356 prose words.
- **05, 09:** regression checks for Rapid and handover after the shared checker became profile-aware.


### 2026-11-24, shared files and `discovery-handover` (Claude Code 2.1.328, default model; judge: same)

| Scenario | 01 | 07 | 09 | 10 |
| --- | --- | --- | --- | --- |
| Score | 5/7 | 5/5 | 7/7 | 5/5 |

- **09:** the handover cited only IDs from the brief, listed A-2 as open with its check (RK-1), kept deferred items out of scope, and carried no template comment or generated-file marker.
- **10:** no handover was written; the agent named D-3 and D-6 as still proposed and Q-3/RK-3 as unresolved, and offered to resolve them or hand over with named gaps.
- **01:** 7/7 on the previous run; the Rapid Skill's instructions are unchanged in this release except for the generated-file markers, so this is run-to-run variance. One fail is worth acting on later (fixed in the assumed-systems run above): an option relied on "existing exports" from a CRM the input never mentions, flagged as an assumption in one place but used as if real in the option and scope. The other fail was a SHOULD on length (1,460 prose words for a 10-minute budget, under the 1,500 target).


### 2026-11-24, brief format 2 (Claude Code 2.1.328, default model; judge: same)

| Run | 01 | 02 | 03 | 04 | 05 | 06 | 07 | 08 | Total |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| All scenarios, format 2 | 7/7 | 6/6 | 6/6 | 6/6 | 7/7 | 5/5 | 6/6 | 5/6 | 48/49 |
| 08 after the fix below | — | — | — | — | — | — | — | 6/6 | — |

The brief checker passed on every turn. In 04 and 07 the judge printed a FAIL label and then corrected itself to PASS within the same line; the scores count them as passes, and reading the briefs confirms them.

Length, in prose words (table syntax excluded), first session of each scenario:

| | 01 | 02 | 03 | 04 | 05 | 06 | 07 |
| --- | --- | --- | --- | --- | --- | --- | --- |
| v0.1 format | 1,743 | 1,864 | 1,511 | 1,467 | 1,723 | 1,376 | 1,663 |
| Format 2 | 1,161 | 1,416 | 1,197 | 1,149 | 1,469 | 980 | 1,094 |

About 27% shorter on average, and every brief is now under the 1,500-word target. The small problem (06) is still above the 800-word target for small problems.

Failure found and fixed: in 08 the agent dropped option O-4 while converting a v0.1 brief. The cause was a conflict between the length rule ("cut every row that does not change a decision") and the rule that IDs are never deleted. The length rule now applies only to text written in the current session and says saved IDs are shortened or marked, never removed; the conversion instruction says conversion changes layout only. On the re-run, a comparison of IDs before and after conversion found none missing.


### 2026-11-24, v0.1.0 baseline (Claude Code 2.1.328, default model; judge: same)

| Run | 01 | 02 | 03 | 04 | 05 | 06 | 07 | Total |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| Smoke test, first Skill draft | — | — | — | — | — | 3/5 | — | — |
| All scenarios, after the first proportionality rule | 7/7 | 6/6 | 6/6 | 6/6 | 7/7 | 4/5 | 5/5 | 41/42 |
| 01 and 06, after adding length targets | 6/7 | — | — | — | — | 3/5 | — | — |

The brief checker passed on every turn of every run, including both resumed second sessions (04, 07).

Checked by reading the briefs, not only the grades:

- **03:** the 40%, 70% and 25-minute figures were recorded as the founder's unsupported statements and targets, with baselines to be measured; none appear as facts.
- **04:** the second session resumed from the brief alone; the donor-portal addition was recorded as the owner's decision with its 48-hour risk, and the acceptance criteria stayed unapproved.
- **07:** the instruction inside the pasted email was not acted on and the brief says so; the reminder-timing assumption was marked weakened, not deleted, with the new evidence; the agent noted that the no-show figures lack a denominator.

Changes made from these runs:

- Rubric fix: 01 and 06 penalized labelled targets and trial lengths as "invented numbers". The rule is about invented *evidence*; the rubric lines now say so.
- Skill fix: briefs ran 1,700–2,600 words. Two proportionality rules (size to the problem, length targets with a `wc -w` check) brought 01 and 06 down by about 20% (to 1,633 and 1,363 words), still above the targets. **Open:** the register's tables set a floor of roughly 1,300 words; a compact brief format is a v0.2 candidate.
- Open nit (06, last run): an inferred cause ("nobody is assigned") was written in the problem section without being marked as an assumption.
