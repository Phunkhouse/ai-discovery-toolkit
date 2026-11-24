<!-- Generated from shared/references/scope-and-metrics.md by scripts/sync-shared.sh. Edit that file, then run the script. -->
# Scope, acceptance criteria and success

Work only on the recommended direction. If no direction is recommended yet, scope the next discovery step or experiment instead.

## Scope

- **Must have:** the smallest set that works end to end for the people affected and produces the outcome. Each item is traced to an approved or proposed requirement (`R-`). Ask of every item: if we removed it, would the result still solve the problem for the first users? If yes, it is not a must-have.
- **Optional:** useful additions, in priority order, each with what it would add.
- **Non-goals:** what will deliberately not be done, so nobody builds it by accident. Include the tempting adjacent features that came up.
- **Deferred:** work set aside with its reason and the decision that deferred it, so it is not lost.

Prioritize by user value, business value, uncertainty, dependencies, risk and effort. Uncertainty counts: an item whose value is unproven is a candidate for later or for a test, not for the first slice.

**Scope changes:** anything added after the owner approved the must-have scope is proposed, not added. Show what it costs (time, risk, what it would displace) and let the owner decide. When the time budget or the deadline is tight, propose what to cut.

## Acceptance criteria

Write them so someone else can check them without asking:

- **Observable:** "An operations coordinator sees every new delivery exception in one list within 15 minutes of the email arriving", not "Exceptions are handled efficiently".
- **Include the important failure case:** what happens with bad input, a missing record, an unavailable system.
- **Say how it is checked:** a walkthrough, a test, a measurement.
- **Trace** each criterion to the requirement it checks.

Keep about seven or fewer. Acceptance criteria describe the behavior; they do not choose the technology.

## Success

- **Desired outcome:** the change in the world the owner wants, in one or two sentences. Not "launch the tool".
- **Metrics (one to three):**
  - At least one **leading** indicator that moves soon after release (adoption, time to first use, share of cases handled the new way).
  - At least one **lagging** indicator tied to the outcome (time saved per week, error rate, retention, revenue).
  - For each: the **baseline**, marked as measured (with source), reported (who said it) or unknown (with how and when to measure it before release), and a **target** labelled as a target.
- **Hypothesis:** "We believe that <change> for <people> will result in <outcome>. We will know when <metric> reaches <threshold> within <time>." State what result would mean the hypothesis was wrong.
- **Impact estimate (optional):** only with transparent assumptions, as a range, labelled as an estimate. Never present a forecast next to a measured value without labelling both.
- **How it could fail or backfire:** low adoption, more work moved elsewhere, worse outcomes for a group, incentives that reward the wrong behavior, data quality, over-trust in automation. One line each, with what would detect it.

## Risks and feasibility

Record the material ones only, as `RK-` rows in the register: technical dependencies, data and API availability, operational load, security, privacy, regulation, vendor or business risk. For each, mark it as **known** (with source) or **assumed**, and give a mitigation or a small check. A feasibility check is a bounded spike or question with a yes/no outcome and a time limit, for example "Confirm the carrier portal offers an export of exceptions (operations lead, 1 day)". Do not design the solution.
