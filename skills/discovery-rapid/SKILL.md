---
name: discovery-rapid
description: Time-boxed product discovery for a brief, idea or feature request - frame the real problem, separate facts from assumptions, ask only questions that change decisions, weigh options including not building, and write a short brief with scope, acceptance criteria and metrics for owner approval and engineering handover. Use to decide what or whether to build, or to continue or hand over a brief in docs/discovery/.
---

# Rapid Discovery

Answer, within a time budget: are we solving the right problem, for the right people, in the right way, and what is the smallest thing worth doing next? The result is a decision-ready brief, not documentation for its own sake. A valid recommendation is to change a process, adopt an existing tool, validate first, defer or build nothing.

Files in this Skill are relative to this `SKILL.md`. Read `references/rules.md` before anything else; it applies throughout. Read each other reference only when a step names it.

## 1. Start or resume

1. Look for briefs in `docs/discovery/*/brief.md` under the working directory, or where the user points.
   - **Resume** when the request concerns an existing brief whose status is not `handed over` or `closed`. Read the whole brief, starting with its *Resume here* section. If its header has no `Format: 2` line (a v0.1 brief with a "What we know" section), first convert it to the current template: move every entry into the register and scope lines, keeping every ID (options, questions and criteria included), status and source, and tell the user it was converted. Conversion changes layout only; do not shorten, merge or drop entries while converting. Tell the user in two or three lines what is known, what is waiting and the next step. If the brief's `Updated` date is old or the user says things have changed, list the facts the recommendation rests on and ask which still hold before building on them.
   - **Start** otherwise: choose a short kebab-case slug, copy `templates/brief.md` to `docs/discovery/<slug>/brief.md`, and record the input as `SRC-1`. Do not paste raw input into the brief; summarize it (see the sensitivity rules).
2. Settle the session in one message, asking only for what is missing and using defaults otherwise:
   - **Time budget:** default 20 minutes. Note the start time with `date` when a shell is available.
   - **Who decides and who answers:** is the user the decision owner? Can stakeholders answer now (interactive), later (asynchronous) or not at all?
   - **Location:** default `docs/discovery/<slug>/`.

   If the user gave only a brief, state the defaults you are using and continue; do not wait for confirmation of defaults.

## 2. Work in passes

Size the brief to the problem (see "Proportionality" in the rules): a small problem gets a short brief with "None" where nothing is material. Rough shares of the budget: frame 25%, register 20%, questions 15%, options 15%, scope and success 25%. Save the brief at the end of every pass; the file is the save point if the session ends. Check the clock at each save. When over budget, compress what is left (fewer options, fewer metrics, one-line rationale) but never drop the recommendation, the acceptance criteria, the open assumptions or the decisions needed.

### Pass 1: Frame the problem

- If the request names a solution ("build an AI agent that…"), record it as option `O-1` and ask what it is meant to change. The problem statement must not presuppose a solution.
- Identify who is affected and how, the current workflow and where it hurts, which observations are symptoms and which are likely causes, and why this matters now.
- Write the problem statement in the template's form: who, what difficulty, in what situation, what consequence, and the observable change that would mean it is solved.
- If the input cannot support a problem statement at all, say so and make the missing piece the first question.

### Pass 2: Register what is known

List the sources as `SRC-` items, then sort every material claim into the register table with an ID and a source, following the evidence kinds in `references/rules.md`. Keep rows grouped by kind (`F`, `S`, `R`, `C`, `A`, `X`, `RK`) and use *Notes* only for what the kind needs. Record disagreements between sources as conflicts (`X-`) with the decision each affects; never resolve a conflict silently by picking a side. Mark any requirement you derived yourself as `inferred`.

### Pass 3: Consequential unknowns and questions

Read `references/questions.md`. List at most five open questions, ranked by how much the answer would change a decision, each with whom to ask and the assumption you will work on if it stays unanswered.

- **Interactive:** ask the top one to three now, in one message. "Don't know" is a valid answer: record it and move on.
- **Asynchronous or unavailable:** keep the questions in the brief as a list ready to send, set the status to `awaiting answers` if they block approval, and continue on the stated assumptions.

Never stall waiting for answers. Continue on explicit assumptions and mark what depends on them.

### Pass 4: Options and recommendation

Read `references/options.md`. Compare two to four options, including at least one that is not new software and the smallest meaningful intervention. Recommend one direction as a `proposed` decision with its rationale and what evidence would change it. If more discovery is worth more than a decision now, recommend that, and say what to learn and how.

### Pass 5: Scope and success

Read `references/scope-and-metrics.md`. For the recommended direction only: the smallest end-to-end scope, optional items, non-goals, deferred work with reasons, observable acceptance criteria, the desired outcome, one to three metrics with baselines or how to get them, a testable hypothesis, how it could fail or backfire, and the material risks as `RK-` rows in the register, with small feasibility checks where something is unverified. Do not plan the implementation.

## 3. Present decisions

End the working part of a session with a short message in chat:

1. The problem in one sentence and the recommendation.
2. The assumptions that could change the recommendation.
3. **Decisions needed:** a numbered list, each with your recommendation and the realistic alternative, so the owner can answer "1 yes, 2 no, 3 as you suggest but…".
4. Questions to send, if any, and to whom.

Only the user's explicit words in chat approve something. Record each approval, rejection or modification in the decision log with who and when; what was not answered stays `proposed`. Set the status to `awaiting approval` when the brief is complete but undecided, and to `approved` when the recommendation, must-have scope and acceptance criteria are approved.

## 4. Continue with new evidence

When answers or new information arrive, in this session or a later one:

1. Record each item with its source (new `S-`/`F-`, answered `Q-`).
2. Follow its IDs through the brief: every assumption, requirement, decision, criterion or metric based on something that changed.
3. Mark contradicted entries `disproved` or `superseded by …`; never delete them. If an approved decision is affected, set it to `needs review` and ask; do not change it silently.
4. Tell the user what changed and what now needs a decision.

## 5. Handover

Only when the user asks for a handover or approves the brief for building. Read `references/handover.md`, check its readiness gate, then write `handover.md` next to the brief from `templates/handover.md`. The separate `discovery-handover` Skill follows the same procedure; this Skill does not need it installed.

## 6. Finish every session

1. Rewrite *Resume here*: what is done, what waits on whom, the next step, and time used against the budget. Set `Status` and `Updated`.
2. Run `bash scripts/check-brief.sh <path to brief.md>` (path relative to this Skill). Fix every error it reports, and act on a length warning by cutting rows and sentences that change no decision. If the shell is unavailable, check the brief against the template's required sections by eye and say so.
3. Report briefly in chat: where the brief is, its status, the decisions needed and the questions to send.
