# Discovery brief: <short title>

- **Status:** in progress
- **Format:** 2
- **Profile:** Standard; budget <4 hours> across sessions, used <0>; checkpoint <A / B / C>
- **Decision owner:** <role of the person who decides>
- **Updated:** <YYYY-MM-DD> by <agent or person>

<!-- Status: in progress, awaiting answers, awaiting approval, approved, handed over, closed. Checkpoints: A problem and stakeholders, B direction, C MVP scope, requirements, criteria and validation plan. Replace every <placeholder>, delete rows you do not need, write "None" for an empty list, and remove this comment. IDs are never renumbered or reused. -->

## Resume here

- **Done:** <what this discovery has established so far, and the last checkpoint approved>
- **Waiting on:** <answers, approvals or checks, and from whom; or None>
- **Next step:** <the single next thing to do, specific enough to start without asking>

## Problem

- **Request:** <what was asked for, in one line; often a solution> (SRC-1)
- **Problem statement:** <who> struggles to <what> when <situation>, which leads to <consequence>. It is solved when <observable change>.
- **Opportunity:** <why solving it is worth it: for whom, how much, on what evidence; mark estimates as estimates>
- **Affected:** <roles and how each is affected; detail in Stakeholders>
- **Today:** <the current situation in one or two lines; detail in User workflows>
- **Why now:** <why it matters at this moment>

## Stakeholders

| ID | Role | Interest in the outcome | Influence | Decides or informs | Position | Status |
| --- | --- | --- | --- | --- | --- | --- |
| P-1 | <role> | <what they need or fear> | <high / medium / low> | <decides D-… / informs / is affected> | <supports / opposes / unknown; with source> | <reached / not yet reached / not reachable> |

- **Missing voices:** <groups affected but not yet heard, e.g. end users; or None>

## Register

- **SRC-1** <e.g. kickoff call notes from the client, summarized>, <YYYY-MM-DD>

| ID | Entry | Source | Status | Notes |
| --- | --- | --- | --- | --- |
| F-1 | <a fact checked against a source that can establish it> | SRC-1 | confirmed | |
| S-1 | <what a stakeholder said, wants or believes> | SRC-1, P-1 | reported | |
| C-1 | <a limit on any solution> | SRC-1 | reported | |
| A-1 | <believed but unverified> | <basis> | open | If wrong: <what breaks>. Check: <H-… or who>. Plan: <proceed / validate first / defer>. |
| X-1 | <S-1 and S-2: what cannot both hold> | S-1, S-2 | open | Affects <D-…>; resolved by <P-…>. |
| RK-1 | <what could block, fail or harm> | <basis> | <known / assumed / checked> | <kind>; <mitigation, or a bounded check with owner and time limit>. |

## Open questions

<!-- At most ten per round, most important first; "Ask" names a stakeholder so the question pack can be grouped by recipient. -->

| ID | Question | Decision it changes | Ask | If unanswered | Status |
| --- | --- | --- | --- | --- | --- |
| Q-1 | <non-leading question> | <D-… / W-… / R-… / baseline> | <P-…> | <A-…> | open |

## User workflows

- **W-1 <name>, today:** <actor> — <trigger> → <steps> → <outcome>. Hurts at: <where and why>. (S-…)
- **W-2 <name>, with the solution:** <actor> — <trigger> → <steps> → <outcome>. Failure cases: <what goes wrong and what should happen>. Replaces W-1.

## Options and recommendation

| ID | Option | Value | Effort | Risk | Confidence | Notes |
| --- | --- | --- | --- | --- | --- | --- |
| O-1 | <the requested solution, if any> | <L/M/H> | <L/M/H> | <L/M/H> | <L/M/H> | <one-line reason> |
| O-2 | <a non-software or existing-product option> | <L/M/H> | <L/M/H> | <L/M/H> | <L/M/H> | <one-line reason> |
| O-3 | <the smallest meaningful intervention> | <L/M/H> | <L/M/H> | <L/M/H> | <L/M/H> | <one-line reason> |

**Recommendation (D-2, proposed):** <direction>. <Why it beats the alternatives on the evidence, the assumptions and hypotheses it depends on most, and what evidence would change it.>

## Requirements

| ID | Requirement | Workflow | Priority | Based on | Status | Notes |
| --- | --- | --- | --- | --- | --- | --- |
| R-1 | <what the solution must do> | W-2 | <must / should / could / won't> | <S-… / P-… / H-…> | proposed | <explicit / inferred> |

## Scope

- **Must have:** <the MVP: the must requirements that make the smallest end-to-end solution> (R-…)
- **Optional:** <should and could requirements, in priority order; or delete this line>
- **Non-goals:** <deliberately not done, including won't requirements>
- **Deferred:** <set aside, with reason> (D-…); or None

## Acceptance criteria

- [ ] **AC-1** <observable result for W-2>; checked by <walkthrough / test / measurement> (R-1)

## Validation plan

<!-- The cheapest tests of the riskiest hypotheses, with thresholds set before running. -->

| ID | Hypothesis | Test | Pass / fail | Time and cost | Decision it informs | Status |
| --- | --- | --- | --- | --- | --- | --- |
| H-1 | We believe <change> for <people> will result in <outcome>. | <interview / concierge / prototype / data pull / spike> | <pass if …; fail if …> | <duration; cost> | <D-…> | untested |

## Success

- **Outcome:** <the change in the world, not the launch>
- **Could fail or backfire:** <one line each, with what would detect it>

| ID | Metric | Type | Baseline | Target |
| --- | --- | --- | --- | --- |
| M-1 | <what is measured> | <leading / lagging> | <measured: … (SRC-…) / reported: … (S-…) / unknown: how and when to measure> | <target, labelled as such> |

## Decisions

| ID | Decision | Rationale | Status | By and date |
| --- | --- | --- | --- | --- |
| D-1 | Checkpoint A: problem statement and stakeholders as above | <why this framing> | proposed | — |
| D-2 | Checkpoint B: <the recommended direction> | See recommendation | proposed | — |
| D-3 | Checkpoint C: MVP scope, must requirements, acceptance criteria and validation plan | <why this is the smallest sufficient scope> | proposed | — |
