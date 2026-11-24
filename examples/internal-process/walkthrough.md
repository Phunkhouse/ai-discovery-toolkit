# Walkthrough: delivery exception handling

An internal process that looked like it needed an AI agent. All data is synthetic. Files: [input](input.md), [brief](brief.md), [handover](handover.md).

## Session 1 (18 of 20 minutes)

**Start.** No brief existed, so the agent created `docs/discovery/delivery-exceptions/brief.md` and stated its defaults: 20 minutes, the director as decision owner, IT and customer service reachable later.

**Framing.** The request named a solution. The agent recorded it as option O-1 and asked what it should change. The director's answer ("customers hear about delays hours later") became the problem statement, with time to customer contact as the observable outcome rather than "an agent exists".

**Register.** Every claim in the request went in as a stakeholder statement (`S-`), not a fact: "half their day", "150 a day", "might have an API". The disagreement about automatic emails to key accounts became conflict X-1, linked to the decisions it blocks, instead of being settled by the agent.

**Questions.** Five open questions, ranked by the decision they change. The agent asked the top three in one message:

> 1. Roughly how long does it take today from a carrier email to the customer being contacted? It sets the baseline for success.
> 2. How many carriers send these, and in what format? It decides whether one integration covers most of the volume.
> 3. Who decides between automatic emails for everyone and none for key accounts? I've recorded both views and won't pick one.

The director answered the second (three carriers, about 80% from one), said "don't know" to the first and "me and the CS lead, tomorrow" to the third. The agent kept the remaining questions as a list to send to IT and operations, each with the assumption it would work on meanwhile.

**Options.** Four options, including a process-only change and an off-the-shelf product. The agent recommended *validate first, then build the smallest slice* and explained that auto-sending conflicts with X-1 and that parsing three email formats with AI was the riskiest part of the request. The director approved the problem statement (D-1) and asked to wait for the answers before deciding the direction. Status: `awaiting answers`.

## Session 2, next day (9 minutes, new session)

**Resume.** The agent read only the brief. *Resume here* said what was waiting and on whom, so the director could paste the answers without re-explaining anything.

**New evidence changed earlier conclusions:**

- IT confirmed a CSV export but no API (F-1). Statement S-4 became `confirmed as F-1`, and option O-3 now avoided free-text parsing entirely.
- The two-week count showed about 60 emails a day, not 150 (F-3). S-2 was marked `contradicted by F-3`, not deleted, and the agent removed the impact estimate it would otherwise have been tempted to write.
- The median time to contact was about 5 hours (F-2), giving M-1 a measured baseline.
- The director and the customer service lead agreed on personal contact for key accounts (D-4), resolving X-1.

**Scope creep.** The director added "and a status page customers can check". The agent proposed it as deferred: it is not needed for the outcome and would not fit the six weeks. The director agreed (D-6).

**Approval and handover.** The agent listed the decisions needed as a numbered list; the director answered "all yes". The agent recorded each with who and when, checked the readiness gate (A-2 still open but with a one-day check before the build, which the director accepted as D-7), wrote `handover.md` and set the status to `handed over`.

## What this example shows

- **Incomplete information:** the work continued on explicit assumptions while answers were pending, and the questions were limited to five, each tied to a decision.
- **Conflicting requirements:** X-1 stayed open until the people with authority resolved it.
- **Scope reduction:** from an AI agent for three carriers with automatic sending to an import of one carrier's export with reviewed messages, with every removed item recorded as a non-goal or deferred with its reason.
- **No fabricated numbers:** the unverified "half their day" never became an impact estimate.
