# Discovery brief: <short title>

- **Status:** in progress
- **Profile:** Rapid
- **Time budget:** <20> minutes; used <0>
- **Decision owner:** <role of the person who decides>
- **Updated:** <YYYY-MM-DD> by <agent or person>

<!-- Status is one of: in progress, awaiting answers, awaiting approval, approved, handed over, closed. Replace every <placeholder>; remove these comments as you fill each section. Write "None" where a list is empty. IDs are never renumbered or reused. -->

## Resume here

<!-- Rewritten, not appended, at the end of every session. -->

- **Done:** <what this discovery has established so far>
- **Waiting on:** <answers, approvals or checks, and from whom; or None>
- **Next step:** <the single next thing to do, specific enough to start without asking>

## Problem

- **Request as received:** <what was asked for, in one line; often a solution> (SRC-1)
- **Problem statement:** <who> struggles to <what> when <situation>, which leads to <consequence>. It is solved when <observable change>.
- **Affected people:** <roles and how each is affected>
- **Current workflow:** <the steps today and where they hurt>
- **Symptoms and likely causes:** <what is observed, and what probably causes it; mark causes as assumptions unless confirmed>
- **Why now:** <why it matters, and why at this moment>

## What we know

### Sources

| ID | Source | Date |
| --- | --- | --- |
| SRC-1 | <e.g. brief from the operations lead, pasted in chat> | <YYYY-MM-DD> |

### Facts and statements

| ID | Statement | Source | Status |
| --- | --- | --- | --- |
| F-1 | <a fact checked against a source that can establish it> | SRC-1 | confirmed |
| S-1 | <what a stakeholder said, wants or believes> | SRC-1, <role> | reported |

### Requirements and constraints

| ID | Requirement or constraint | Basis | Based on | Status |
| --- | --- | --- | --- | --- |
| R-1 | <what the solution must do> | <explicit / inferred> | S-1 | proposed |
| C-1 | <a limit on any solution> | constraint | SRC-1 | reported |

### Assumptions

| ID | Assumption | If wrong | How to check | Plan | Status |
| --- | --- | --- | --- | --- | --- |
| A-1 | <believed but unverified> | <what breaks> | <who or what evidence> | <proceed / validate first / defer> | open |

### Conflicts

| ID | Between | Decision it affects | Who resolves | Status |
| --- | --- | --- | --- | --- |
| X-1 | <S-1 and S-2: what cannot both hold> | <D-… or scope item> | <role> | open |

## Open questions

<!-- At most five, ranked by how much the answer changes a decision. -->

| ID | Question | Decision it changes | Ask | Priority | If unanswered | Status |
| --- | --- | --- | --- | --- | --- | --- |
| Q-1 | <non-leading question> | <D-… / scope / AC / baseline> | <role> | <high / medium / low> | <A-…> | open |

## Options and recommendation

| ID | Option | Value | Effort | Risk | Confidence | Notes |
| --- | --- | --- | --- | --- | --- | --- |
| O-1 | <the requested solution, if any> | <L/M/H> | <L/M/H> | <L/M/H> | <L/M/H> | <one-line reason> |
| O-2 | <a non-software option> | <L/M/H> | <L/M/H> | <L/M/H> | <L/M/H> | <one-line reason> |

**Recommendation (D-2, proposed):** <Build the smallest slice of O-… / Adopt / Change process / Validate first / Discover further / Defer / Don't build>. <Two or three sentences: why, which assumptions it depends on most, and what evidence would change it.>

## Scope

### Must have

- <smallest end-to-end item> (R-1)

### Optional

- <useful addition, in priority order, and what it adds>

### Non-goals

- <deliberately not done>

### Deferred

- <set aside, with reason> (D-…)

## Acceptance criteria

- [ ] **AC-1** <observable result>; checked by <walkthrough / test / measurement> (R-1)
- [ ] **AC-2** <the important failure case>; checked by <…> (R-1)

## Success

- **Desired outcome:** <the change in the world, not the launch>
- **H-1:** We believe that <change> for <people> will result in <outcome>. We will know when <metric> reaches <threshold> within <time>. It is wrong if <result>.

| ID | Metric | Type | Baseline | Target |
| --- | --- | --- | --- | --- |
| M-1 | <what is measured> | <leading / lagging> | <measured: … (SRC-…) / reported: … (S-…) / unknown: how and when to measure> | <target, labelled as such> |

- **Impact estimate:** <optional; a range with its assumptions, labelled as an estimate; or None>
- **How it could fail or backfire:** <one line each, with what would detect it>

## Risks and feasibility

| ID | Risk or dependency | Kind | Status | Mitigation or check |
| --- | --- | --- | --- | --- |
| RK-1 | <what could block, fail or harm> | <technical / data / operational / security / privacy / regulatory / business> | <known / assumed / checked> | <mitigation, or a bounded check with owner and time limit> |

## Decisions

<!-- Rows are never deleted. Only the user's explicit words approve or reject. "By and date" names who decided and when. -->

| ID | Decision | Rationale | Status | By and date |
| --- | --- | --- | --- | --- |
| D-1 | Problem statement and affected people as above | <why this framing> | proposed | — |
| D-2 | <the recommended direction> | <see recommendation> | proposed | — |
