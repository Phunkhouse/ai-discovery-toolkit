<!-- Generated from shared/templates/handover.md by scripts/sync-shared.sh. Edit that file, then run the script. -->
# Handover: <short title>

- **Source:** `brief.md`, Updated <YYYY-MM-DD>. This file is a snapshot of the approved parts of that brief. If the brief's `Updated` is later, this handover is stale: ask for it to be regenerated before relying on it.
- **Approved by:** <role>, <YYYY-MM-DD> (<D-…>)
- **Direction:** <Build the smallest slice of … / Change process / Validate first / …>

<!-- Fill only from the brief. Keep the IDs so every line can be traced. Remove these comments. -->

## Problem and outcome

<Problem statement, affected people and desired outcome, in three to five sentences.>

## Scope

**Must have**

- <item> (R-…)

**Non-goals**

- <item>

**Deferred**

- <item, with reason> (D-…)

## Acceptance criteria

- [ ] **AC-1** <observable result>; checked by <…> (R-…)

## Requirements and constraints

Approved requirements, confirmed facts and constraints the build must respect.

- **R-1** <requirement>
- **C-1** <constraint>
- **F-1** <fact the build relies on>

## Open assumptions

Build on these as written. They are not confirmed; if one turns out wrong, stop and tell the owner.

| ID | Assumption | If wrong | How it gets confirmed |
| --- | --- | --- | --- |
| A-1 | <assumption> | <consequence> | <who or what, and when> |

## Open questions that do not block the start

- **Q-…** <question>, waiting on <role>; until answered, <working assumption>.

## Success metrics

| ID | Metric | Type | Baseline | Target |
| --- | --- | --- | --- | --- |
| M-1 | <metric> | <leading / lagging> | <measured / reported / unknown, with source or method> | <target> |

## Material risks

- **RK-1** <risk>: <mitigation or check>

## Decisions and rationale

- **D-…** <decision>: <rationale>

## For the engineering agent

- Implement only the must-have scope. Propose anything else to the owner; do not add it.
- Implementation choices (stack, architecture, data model) are not decided here unless listed as a constraint.
- If an assumption proves wrong or an acceptance criterion cannot be met, stop and report it. The change goes back through the discovery brief, not this file.
