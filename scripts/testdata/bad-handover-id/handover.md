# Handover: Delivery exception handling

- **Source:** `brief.md`, Updated 2026-11-18. This file is a snapshot of the approved parts of that brief. If the brief's `Updated` is later, this handover is stale: ask for it to be regenerated before relying on it.
- **Approved by:** Operations director, 2026-11-18 (D-2, D-3, D-7)
- **Direction:** Build the smallest slice of O-3: the main carrier's CSV export feeds one exception list with drafted, coordinator-reviewed customer messages.

## Problem and outcome

Operations coordinators re-key free-text carrier exception emails into a spreadsheet before they can contact customers, so customers hear about delays about five hours after the carrier notice (F-2) and complain. The outcome is customer contact within an hour of the carrier notice, without more coordinator time. Key accounts are always contacted personally (D-4).

## Scope

**Must have**

- Main carrier exceptions from the CSV export appear in one list, matched to the shipment and customer (R-1).
- A pre-filled message per exception that the coordinator can edit and send (R-2).
- Key accounts flagged for personal contact, never sent a drafted message without review (R-3).

**Non-goals**

- Automatic sending of customer messages.
- Parsing free-text emails with AI.
- Replacing the tracking spreadsheet.

**Deferred**

- Automatic sending to non-key accounts, and the two smaller carriers' formats (D-5).
- A customer-facing status page (D-6).

## Acceptance criteria

- [ ] **AC-1** A main carrier exception appears in the list within 20 minutes of its export, with shipment and customer filled in; checked by a walkthrough with one day's export (R-1).
- [ ] **AC-2** An exception whose shipment cannot be matched appears in the list marked "unmatched" instead of being dropped; checked by a test with an unknown shipment number (R-1).
- [ ] **AC-3** The coordinator can open a drafted message, edit it and send it from the list; checked by a walkthrough (R-2).
- [ ] **AC-4** A key-account exception shows "personal contact" and offers no send action; checked by a test (R-3).

## Requirements and constraints

- **R-1** Exceptions from the main carrier appear in one list without re-keying.
- **R-2** Each exception needing contact gets a pre-filled message for the coordinator to review and send.
- **R-3** Key accounts are never contacted automatically.
- **C-1** Live within six weeks of 2026-11-17.
- **C-7** Small budget; no new paid platform without the director's approval.
- **F-1** The main carrier's portal offers a scheduled CSV export of exceptions every 15 minutes; there is no API or webhook.
- **F-3** About 60 exception emails arrive per working day.

## Open assumptions

| ID | Assumption | If wrong | How it gets confirmed |
| --- | --- | --- | --- |
| A-1 | Re-keying is the main source of delay (accepted by the owner). | The list alone would not cut contact time much. | Coordinators time the steps for 20 exceptions in the first week. |
| A-2 | The CSV export contains enough to identify the shipment and customer. | Coordinators still look things up by hand. | IT matches one day of export against the spreadsheet before the build starts (RK-1). |
| A-3 | Coordinators will review drafted messages rather than rewrite them (accepted by the owner). | Little time saved on contact. | Measure edits during the first two weeks. |

## Open questions that do not block the start

- **Q-3** What share of exceptions needs customer contact at all? Waiting on the operations director; until answered, assume all of them.

## Success metrics

| ID | Metric | Type | Baseline | Target |
| --- | --- | --- | --- | --- |
| M-1 | Median time from carrier exception to customer contact | lagging | measured: about 5 hours (F-2) | target: under 1 hour |
| M-2 | Share of main carrier exceptions that reach the list without re-keying | leading | measured: 0% today | target: at least 90% |
| M-3 | Complaints about late delay notice per month | lagging | unknown: customer service counts for four weeks before release | target: set once the baseline exists |

## Material risks

- **RK-1** The export may lack fields needed to match customers: IT checks one day of export before the build starts.
- **RK-2** The carrier may change the export format: unmatched rows must surface (AC-2).
- **RK-3** Customer contact details: keep the list inside the existing internal environment; no new third party without approval.

## Decisions and rationale

- **D-2** Build the smallest slice of O-3: the export removes re-keying for about 80% of volume without an AI dependency; human review protects key accounts.
- **D-4** Key accounts get personal contact; others get coordinator-reviewed drafted messages: resolves the conflict between operations and customer service (X-1).
- **D-5** Automatic sending and the smaller carriers wait for a month of evidence (A-3, M-1).
- **D-6** No customer status page in this slice.

## For the engineering agent

- Implement only the must-have scope. Propose anything else to the owner; do not add it.
- Implementation choices (stack, architecture, data model) are not decided here unless listed as a constraint.
- If an assumption proves wrong or an acceptance criterion cannot be met, stop and report it. The change goes back through the discovery brief, not this file.
