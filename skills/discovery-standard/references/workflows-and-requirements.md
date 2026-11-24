# User workflows and requirements

## Workflows

Describe the two to four workflows that matter most to the outcome, each as a `W-` item. A workflow is what an actor does to reach a goal, not a screen or a feature.

- **Today first.** For each important workflow, describe the current one: actor, trigger, steps, outcome, and where it hurts, with the evidence (`S-…`, `F-…`). Workarounds (spreadsheets, side channels, someone who "just knows") are the most useful thing to find.
- **Then with the solution,** for the recommended direction only: the same actor and goal, the new steps, and what replaces which current workflow.
- **Failure cases** belong in the future workflow: missing or bad input, an unavailable system, a person who does not respond, a permission the actor lacks. Each important one needs an expected behavior and usually an acceptance criterion.
- Keep each workflow to a few lines. Steps are verbs an actor performs ("checks stock", "approves the order"), not interface details.
- Do not design screens, data models or architecture. If a workflow depends on a system behaving a certain way, record that as an assumption or a risk and test it.

## Requirements

Requirements in a Standard brief have their own section, grouped by the workflow they serve.

- **Write them as outcomes the solution must enable**, testable through acceptance criteria: "A customer can reorder a previous order in one step", not "Add a reorder button".
- **Basis:** explicit (stated by someone with authority, with the `S-` or `P-` it came from) or inferred (derived by the agent, from what). Inferred requirements stay `proposed` until the owner approves them.
- **Priority:** must, should, could, won't, decided with the owner. *Must* means the MVP fails its outcome without it. Be strict: a must that is only valuable if an unproven hypothesis holds is a candidate for a test first.
- **Won't** requirements are written down on purpose: they become non-goals and stop them from returning unannounced.
- Each must requirement maps to at least one acceptance criterion. A requirement no one can check is not finished.

## MVP scope

The MVP is the set of must requirements that gives the smallest end-to-end solution for the primary workflow. Check it with three questions:

1. Can the primary actor complete the primary workflow from start to finish?
2. Does it produce the outcome the success metrics measure?
3. Is there anything in it whose removal would leave 1 and 2 true? If so, it is not a must.

Should and could requirements go to *Optional* in priority order; won't requirements to *Non-goals*. Anything the owner sets aside for later goes to *Deferred* with its reason.
