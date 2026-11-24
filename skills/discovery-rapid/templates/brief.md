# Discovery brief: <short title>

- **Status:** in progress
- **Format:** 2
- **Profile:** Rapid; budget <20> minutes, used <0>
- **Decision owner:** <role of the person who decides>
- **Updated:** <YYYY-MM-DD> by <agent or person>

<!-- Status: in progress, awaiting answers, awaiting approval, approved, handed over, closed. Replace every <placeholder>, delete rows you do not need, write "None" for an empty list, and remove this comment. IDs are never renumbered or reused. -->

## Resume here

- **Done:** <what this discovery has established so far>
- **Waiting on:** <answers, approvals or checks, and from whom; or None>
- **Next step:** <the single next thing to do, specific enough to start without asking>

## Problem

- **Request:** <what was asked for, in one line; often a solution> (SRC-1)
- **Problem statement:** <who> struggles to <what> when <situation>, which leads to <consequence>. It is solved when <observable change>.
- **Affected:** <roles and how each is affected>
- **Today:** <the current workflow, where it hurts, and the likely causes, each cause an A- entry unless confirmed>
- **Why now:** <why it matters at this moment>

## Register

- **SRC-1** <e.g. brief from the operations lead, pasted in chat>, <YYYY-MM-DD>

| ID | Entry | Source | Status | Notes |
| --- | --- | --- | --- | --- |
| F-1 | <a fact checked against a source that can establish it> | SRC-1 | confirmed | |
| S-1 | <what a stakeholder said, wants or believes> | SRC-1, <role> | reported | |
| R-1 | <what the solution must do> | S-1 | proposed | <explicit / inferred> |
| C-1 | <a limit on any solution> | SRC-1 | reported | |
| A-1 | <believed but unverified> | <basis> | open | If wrong: <what breaks>. Check: <who or what evidence>. Plan: <proceed / validate first / defer>. |
| X-1 | <S-1 and S-2: what cannot both hold> | S-1, S-2 | open | Affects <D-…>; resolved by <role>. |
| RK-1 | <what could block, fail or harm> | <basis> | <known / assumed / checked> | <kind>; <mitigation, or a bounded check with owner and time limit>. |

## Open questions

| ID | Question | Decision it changes | Ask | If unanswered | Status |
| --- | --- | --- | --- | --- | --- |
| Q-1 | <non-leading question> | <D-… / scope / AC / baseline> | <role> | <A-…> | open |

## Options and recommendation

| ID | Option | Value | Effort | Risk | Confidence | Notes |
| --- | --- | --- | --- | --- | --- | --- |
| O-1 | <the requested solution, if any> | <L/M/H> | <L/M/H> | <L/M/H> | <L/M/H> | <one-line reason> |
| O-2 | <a non-software option> | <L/M/H> | <L/M/H> | <L/M/H> | <L/M/H> | <one-line reason> |

**Recommendation (D-2, proposed):** <Build the smallest slice of O-… / Adopt / Change process / Validate first / Discover further / Defer / Don't build>. <Why, the assumptions it depends on most, and what evidence would change it.>

## Scope

- **Must have:** <smallest end-to-end item> (R-1); <item> (R-…)
- **Optional:** <useful addition and what it adds; or delete this line>
- **Non-goals:** <deliberately not done>
- **Deferred:** <set aside, with reason> (D-…); or None

## Acceptance criteria

- [ ] **AC-1** <observable result>; checked by <walkthrough / test / measurement> (R-1)

## Success

- **Outcome:** <the change in the world, not the launch>
- **H-1:** We believe that <change> for <people> will result in <outcome>. We will know when <metric> reaches <threshold> within <time>. It is wrong if <result>.
- **Could fail or backfire:** <one line each, with what would detect it>

| ID | Metric | Type | Baseline | Target |
| --- | --- | --- | --- | --- |
| M-1 | <what is measured> | <leading / lagging> | <measured: … (SRC-…) / reported: … (S-…) / unknown: how and when to measure> | <target, labelled as such> |

## Decisions

| ID | Decision | Rationale | Status | By and date |
| --- | --- | --- | --- | --- |
| D-1 | Problem statement as above | <why this framing> | proposed | — |
| D-2 | <the recommended direction> | See recommendation | proposed | — |
