# Walkthrough: online ordering for trade customers

A freelance client discovery with several stakeholders, asynchronous answers and a request for an app. All data is synthetic. Files: [input](input.md), [brief](brief.md).

## Session 1: checkpoint A (about 1 hour)

**Framing.** The request was "an app and a portal". The agent recorded a custom portal and app as option O-1 and framed the problem as time and accuracy lost to re-keyed phone and email orders. The order export gave the opportunity real numbers: 2,100 orders a quarter, 93% by phone or email, about 1.5 wrong-item credit notes per 100 orders. "Two people's mornings" stayed a statement because nobody had measured it.

**Stakeholders.** Six roles, with interest, influence and decision rights. The sales lead was marked as opposing *unless commission is protected*, from what the MD reported, not from the job title. Missing voices were named: the office staff who take the orders, and customers other than friendly accounts.

**Question pack.** Seven questions, each with a recipient. The agent drafted short messages for the warehouse lead, the bookkeeper and the sales lead, and a call guide the MD could use with six customers. The guide's questions were non-leading: "How do you decide when to order, and what goes wrong?" rather than "Would you use an app?".

The MD approved the framing and the map (D-1).

## Session 2: checkpoint B (about 1 hour, two days later)

**Replies out of order.** The warehouse and bookkeeper answered by email; the sales lead talked to the freelancer; the MD summarized six customer calls. Each became a source and statements. "4 of 6 would order online" was recorded with its caveat (small, friendly sample). The sales lead's commission concern became conflict X-1 instead of being argued away.

**Options.** Five, including a process-only order form, the ERP vendor's own ordering module (found in the vendor's documentation, F-4), an off-the-shelf service and doing nothing. The agent recommended *validate first, then pilot the ERP module*: the module already knows customers and prices, so the open risks are adoption and two unverified capabilities, both cheap to test. The MD approved (D-2).

## Session 3: checkpoint C (about 1 hour)

**Workflows and requirements.** Two current workflows and one future one, with failure cases (after cutoff, out of stock, customers who keep phoning). Requirements grouped under the future workflow with must, should, could and won't. The customers' wish to see the delivery day became a must; "a native app" became a *won't for the pilot*, with the MD's wish recorded and the reason, as a proposed decision for the MD rather than a silent cut (D-5).

**Validation plan.** Three hypotheses ranked by risk: most orders are reorders (a half-day data pull), customers switch (a six-week pilot), the module meets the musts (a one-week vendor demo). The pass and fail thresholds are the MD's, set before any test, and labelled as such. Every hypothesis is `untested`; none has an invented result.

**Where it stands.** Checkpoint C, the commission rule and the no-app decision are with the MD; the IT contractor has not been reached yet, and the brief says so.

## What this example shows

- **Stakeholder analysis that changes decisions:** the commission conflict shapes a must requirement (R-4) and a decision (D-4).
- **Asynchronous discovery:** a question pack by recipient, and replies recorded as they came.
- **Existing products before custom builds:** the ERP module was found and preferred over the requested app.
- **A validation plan with thresholds set up front,** and no results claimed before tests run.
- **The owner's wishes respected and challenged:** the app is deferred only if the MD agrees.
