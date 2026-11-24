---
name: discovery-standard
description: Multi-session product discovery for new products, meaningful features and client engagements - stakeholder map, question packs for asynchronous answers, user workflows, options, prioritized requirements, MVP scope, a validation plan and metrics, approved at three checkpoints. Use when a problem needs more than a quick assessment, or to deepen a Rapid brief or continue a Standard one in docs/discovery/.
---

# Standard Discovery

Answer, across a few sessions: are we solving the right problem, for the right people, in the right way, what is the smallest product worth building, and which beliefs must be tested first? The result is one brief that an owner can approve in three checkpoints and an engineering team can build from. A valid recommendation is still to change a process, adopt an existing product, validate first, defer or build nothing.

Files in this Skill are relative to this `SKILL.md`. Read `references/rules.md` before anything else; it applies throughout. Read each other reference only when a step names it.

## When Standard fits

Use it for new products, meaningful features, freelance client discovery and early validation: several stakeholders, more than one important workflow, real money or effort at stake, or evidence that has to be gathered over days. For a quick assessment, `discovery-rapid` is enough. If even Standard looks too small (strategic investment, regulatory exposure, many user groups with competing needs), say so; Deep Discovery is not available yet, so recommend what extra research would be needed.

## 1. Start, resume or upgrade

1. Look for briefs in `docs/discovery/*/brief.md` under the working directory, or where the user points. Read the whole brief of the one that matches, starting with *Resume here*.
   - **Resume** a brief whose profile is Standard and status is not `handed over` or `closed`. Tell the user in a few lines what is known, the last approved checkpoint, what is waiting and the next step. If time has passed or things have changed, list the facts the recommendation rests on and ask which still hold.
   - **Upgrade** a Rapid brief when the user wants to go deeper: change the profile line, add the Standard sections from `templates/brief.md`, move every `R-` row from the register into *Requirements* with a workflow and a suggested priority (status stays as it was; a priority is agreed with the owner at checkpoint C), and move the hypothesis into *Validation plan*. Keep every ID, status and source. Earlier approvals stay valid; record the upgrade in the decision log. If the brief has no `Format: 2` line, convert its layout first as `discovery-rapid` would: layout only, every ID kept.
   - **Start** otherwise: choose a short kebab-case slug, copy `templates/brief.md` to `docs/discovery/<slug>/brief.md`, and record the inputs as sources. Summarize inputs; do not paste raw emails or transcripts.
2. Settle, in one message and only for what is missing: the overall budget (default four hours across sessions) and this session's share, who decides, which stakeholders can be reached and how (now, asynchronously, not at all), and the location. State the defaults you use and continue.

## 2. Checkpoint A: problem and stakeholders

1. **Frame the problem and the opportunity** as in Rapid: the problem must not presuppose a solution; a requested solution becomes an option. Add *Opportunity*: why solving it is worth it and on what evidence, with estimates labelled.
2. **Map the stakeholders.** Read `references/stakeholders.md`. Record roles, interests, influence, decision rights and positions, and name the missing voices.
3. **Register what is known**, as in the rules. In a Standard brief, requirements go to their own section later; the register holds facts, statements, constraints, assumptions, conflicts and risks.
4. **Questions.** Read `references/questions.md`. At most ten open questions, each with a recipient (`P-…`) and the assumption used meanwhile. Ask the user the ones they can answer now; prepare a question pack for the rest as `references/stakeholders.md` describes.
5. **Present checkpoint A:** the problem statement, who it is for, the stakeholder map with missing voices, and the question pack. Ask the owner to approve the framing (D-1) before going deeper; if they change it, update and re-present. Do not spend the rest of the budget on a framing the owner has not accepted.

## 3. Checkpoint B: direction

1. **Workflows today.** Read `references/workflows-and-requirements.md`. Describe the two to four workflows that matter most as they are now, with where they hurt and the evidence.
2. **Options.** Read `references/options.md`. Three to five options, including at least one that is not new software or uses an existing product, and the smallest meaningful intervention. Rate them without false precision.
3. **Recommend** a direction as a proposed decision (D-2) with the rationale, the assumptions it depends on most, and what would change it. If the decisive evidence is missing, the recommendation can be to validate first; go straight to the validation plan for that.
4. **Present checkpoint B** with the decisions needed as a numbered list.

## 4. Checkpoint C: MVP, requirements and validation

For the approved direction only:

1. **Future workflows** with failure cases (`references/workflows-and-requirements.md`).
2. **Requirements** grouped by workflow, with basis and must/should/could/won't priority agreed with the owner.
3. **Scope:** the MVP as the must requirements; optional, non-goals and deferred lines. Read `references/scope-and-metrics.md` for scope changes, acceptance criteria and metrics.
4. **Acceptance criteria** grouped by workflow, including the important failure cases; every must requirement has at least one.
5. **Validation plan.** Read `references/validation.md`. Two to four hypotheses ranked by risk and uncertainty, each with the cheapest test, pass and fail thresholds agreed before running, time and cost, and the decision it informs.
6. **Success metrics** (two to five, leading and lagging, baselines or how to get them), how it could fail or backfire, and the material risks as `RK-` rows with feasibility checks.
7. **Present checkpoint C** (D-3) with the decisions needed. Set the status to `approved` when D-1 to D-3 are approved.

Checkpoints can be revisited: new evidence that undermines an approved checkpoint sets its decision to `needs review`, and you ask the owner, as below.

## 5. Continue with new evidence

When answers, replies or test results arrive, in any session: record them with sources, update questions and stakeholder rows, follow every ID that depends on them, mark contradicted entries `disproved` or `superseded by …` (never delete), set affected approved decisions to `needs review`, and tell the user what changed and which checkpoint it affects. Replies that arrive out of order are handled as `references/stakeholders.md` describes. Test results update the validation plan as `references/validation.md` describes.

## 6. Approvals

Only the user's explicit words in chat approve something. Present decisions as a numbered list with your recommendation and the realistic alternative for each. Record every approval, rejection or modification with who and when; what was not answered stays `proposed`. A stakeholder's decision relayed by the user is recorded as that stakeholder's, via the user.

## 7. Handover

When checkpoint C is approved and the user asks for it, read `references/handover.md`, check its readiness gate (including the Standard item), and write `handover.md` from `templates/handover.md`, with the User workflows section filled. The `discovery-handover` Skill follows the same procedure; this Skill does not need it installed.

## 8. Finish every session

1. Rewrite *Resume here*: what is done, the last approved checkpoint, what waits on whom, the next step, and time used against the budget. Set `Status`, the checkpoint on the profile line, and `Updated`.
2. Run `bash scripts/check-brief.sh <path to brief.md>` (path relative to this Skill). Fix every error, and act on a length warning by shortening text written this session; never remove an ID that was already saved.
3. Report briefly in chat: where the brief is, its status and checkpoint, the decisions needed, and the question pack to send, if any.
