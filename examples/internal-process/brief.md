# Discovery brief: Delivery exception handling

- **Status:** handed over
- **Profile:** Rapid
- **Time budget:** 20 minutes; used 18 (session 1), 9 (session 2)
- **Decision owner:** Operations director
- **Updated:** 2026-11-18 by discovery agent

## Resume here

- **Done:** Problem, direction, scope and acceptance criteria approved on 2026-11-18 after IT, operations and customer service answered the open questions. Handover written.
- **Waiting on:** Customer service to start counting late-notice complaints (M-3 baseline) before release.
- **Next step:** Engineering starts from `handover.md`. Reopen this brief only if a build finding contradicts an entry here.

## Problem

- **Request as received:** an AI agent that reads carrier exception emails, updates the tracking spreadsheet and emails every customer automatically (SRC-1).
- **Problem statement:** Operations coordinators struggle to tell customers about delivery exceptions quickly when carrier notices arrive as free-text emails in a shared inbox, which leads to customers hearing about delays late and complaining. It is solved when customers affected by an exception are contacted within an hour of the carrier notice, without more coordinator time.
- **Affected people:** customers whose deliveries are delayed, damaged or failed (late information); operations coordinators (re-keying emails into the spreadsheet before acting); customer service (handling complaints about late notice).
- **Current workflow:** carrier email arrives in the shared inbox → a coordinator reads it and re-keys it into the tracking spreadsheet → the coordinator looks up the customer and writes an individual email or calls. Delay builds up at the re-keying step and when the inbox is busy.
- **Symptoms and likely causes:** symptom: late customer contact (F-2) and complaints (S-6). Likely cause: manual re-keying before any action can start (A-1), not the writing of the customer message itself.
- **Why now:** complaints about late notice are rising (S-6) and the director wants a change before the next peak season (C-1).

## What we know

### Sources

| ID | Source | Date |
| --- | --- | --- |
| SRC-1 | Request from the operations director, pasted in chat | 2026-11-17 |
| SRC-2 | Operations director, answers in session 1 | 2026-11-17 |
| SRC-3 | IT lead, written answer relayed by the director, with the carrier portal's export documentation | 2026-11-18 |
| SRC-4 | Operations director, count from the shared inbox and spreadsheet timestamps for the last two weeks | 2026-11-18 |
| SRC-5 | Customer service lead and operations director, joint answer relayed by the director | 2026-11-18 |

### Facts and statements

| ID | Statement | Source | Status |
| --- | --- | --- | --- |
| S-1 | Coordinators spend about half their day on exception emails. | SRC-1, operations director | reported |
| S-2 | About 150 exception emails arrive per day. | SRC-1, operations director | contradicted by F-3 |
| S-3 | Customer service does not want automatic emails sent to key accounts. | SRC-1, customer service lead (via director) | superseded by D-4 |
| S-4 | The carrier portal might have an API. | SRC-1, IT (via director) | confirmed as F-1 (export, no API) |
| S-5 | Three carriers send exceptions; about 80% come from one of them. | SRC-2, operations director | reported |
| S-6 | Complaints about late delay notices are increasing. | SRC-1, operations director | reported |
| F-1 | The main carrier's portal offers a scheduled CSV export of exceptions every 15 minutes; there is no API or webhook. | SRC-3 | confirmed |
| F-2 | Median time from carrier email to customer contact was about 5 hours over the last two weeks. | SRC-4 | confirmed |
| F-3 | About 60 exception emails arrive per working day (two-week count). | SRC-4 | confirmed |

### Requirements and constraints

| ID | Requirement or constraint | Basis | Based on | Status |
| --- | --- | --- | --- | --- |
| R-1 | Exceptions from the main carrier appear in one list without re-keying. | inferred | A-1, F-1 | approved |
| R-2 | For each exception needing contact, the coordinator gets a pre-filled customer message to review and send. | explicit | SRC-1, D-4 | approved |
| R-3 | Key accounts are never contacted automatically; they are flagged for personal contact. | explicit | S-3, D-4 | approved |
| R-4 | Customer messages are sent automatically, without review. | explicit | SRC-1 | deferred (D-5) |
| C-1 | Live within six weeks of 2026-11-17. | constraint | SRC-1 | reported |
| C-2 | Small budget; no new paid platform without the director's approval. | constraint | SRC-1 | reported |

### Assumptions

| ID | Assumption | If wrong | How to check | Plan | Status |
| --- | --- | --- | --- | --- | --- |
| A-1 | Re-keying is the main source of delay, not finding the customer or writing the message. | The list alone would not cut contact time much. | Coordinators time the three steps for 20 exceptions. | proceed | accepted (operations director, 2026-11-18) |
| A-2 | The CSV export contains enough to identify the shipment and customer. | Coordinators still look things up by hand. | IT pulls one day of export and matches it to the spreadsheet. | validate first | open |
| A-3 | Coordinators will review drafted messages rather than rewrite them. | Little time saved on contact. | Measure edits during the first two weeks. | proceed | accepted (operations director, 2026-11-18) |

### Conflicts

| ID | Between | Decision it affects | Who resolves | Status |
| --- | --- | --- | --- | --- |
| X-1 | Director: every customer gets an automatic email (SRC-1). Customer service: no automatic emails to key accounts (S-3). | D-2, R-3, R-4 | Operations director with customer service lead | resolved by D-4 |

## Open questions

| ID | Question | Decision it changes | Ask | Priority | If unanswered | Status |
| --- | --- | --- | --- | --- | --- | --- |
| Q-1 | How long does it take today from a carrier email to the customer being contacted? | M-1 baseline, D-2 | Operations director | high | Work without a baseline | answered (F-2) |
| Q-2 | Does the carrier portal offer an API, export or notifications for exceptions? | D-2 (build vs. parse emails) | IT lead | high | Parse the emails | answered (F-1) |
| Q-3 | What share of exceptions needs customer contact at all? | Size of R-2 | Operations director | medium | All of them | open |
| Q-4 | Who decides between automatic emails for everyone and none for key accounts? | X-1, R-3 | Operations director | high | No automatic sending | answered (D-4) |
| Q-5 | How many carriers send exceptions, and in what formats? | Scope of R-1 | Operations director | medium | One main carrier | answered (S-5) |

## Options and recommendation

| ID | Option | Value | Effort | Risk | Confidence | Notes |
| --- | --- | --- | --- | --- | --- | --- |
| O-1 | AI agent reads every carrier email, updates the spreadsheet and emails customers automatically (as requested). | High | High | High | Low | Unproven parsing of three formats; auto-sending conflicts with R-3; hard in six weeks. |
| O-2 | Process only: a triage rota and message templates, no build. | Low | Low | Low | Medium | Cheap, but re-keying (A-1) stays. |
| O-3 | Import the main carrier's CSV export into one exception list, with drafted messages that coordinators review and send; key accounts flagged. | Medium-High | Medium | Low | Medium | Covers about 80% of volume (S-5) without parsing free text. |
| O-4 | Off-the-shelf customer notification product. | Medium | Medium | Medium | Low | Not explored; likely above budget (C-2). Revisit if O-3 falls short. |

**Recommendation (D-2, approved):** Build the smallest slice of O-3. The main carrier's export (F-1) removes the re-keying step for most exceptions without an AI dependency, and human review keeps key accounts safe (R-3). It rests most on A-1 and A-2; if A-2 fails, the fallback is parsing the main carrier's emails, which is more effort. Automatic sending and the other two carriers are deferred until the slice is measured.

## Scope

### Must have

- Main carrier exceptions from the CSV export appear in one list, matched to the shipment and customer (R-1).
- A pre-filled message per exception that the coordinator can edit and send (R-2).
- Key accounts flagged for personal contact, never sent a drafted message without review (R-3).

### Optional

- Exceptions from the other two carriers entered manually into the same list, so there is one place to work.

### Non-goals

- Automatic sending of customer messages.
- Parsing free-text emails with AI.
- Replacing the tracking spreadsheet.

### Deferred

- Automatic sending to non-key accounts, after a month of measured review edits (D-5).
- A customer-facing status page, requested in session 2; not needed for the outcome and would not fit in six weeks (D-6).
- The two smaller carriers' formats (D-5).

## Acceptance criteria

- [ ] **AC-1** A main carrier exception appears in the list within 20 minutes of its export, with shipment and customer filled in; checked by a walkthrough with one day's export (R-1).
- [ ] **AC-2** An exception whose shipment cannot be matched appears in the list marked "unmatched" instead of being dropped; checked by a test with an unknown shipment number (R-1).
- [ ] **AC-3** The coordinator can open a drafted message, edit it and send it from the list; checked by a walkthrough (R-2).
- [ ] **AC-4** A key-account exception shows "personal contact" and offers no send action; checked by a test (R-3).

## Success

- **Desired outcome:** customers hear about delivery exceptions within an hour, and coordinators spend less time on exceptions, not more.
- **H-1:** We believe that removing re-keying for the main carrier's exceptions will let coordinators contact affected customers within an hour. We will know when the median time to contact (M-1) is under one hour for main carrier exceptions within four weeks of release. It is wrong if the median stays above three hours.

| ID | Metric | Type | Baseline | Target |
| --- | --- | --- | --- | --- |
| M-1 | Median time from carrier exception to customer contact | lagging | measured: about 5 hours (F-2) | target: under 1 hour |
| M-2 | Share of main carrier exceptions that reach the list without re-keying | leading | measured: 0% today | target: at least 90% |
| M-3 | Complaints about late delay notice per month | lagging | unknown: customer service counts for four weeks before release | target: set once the baseline exists |

- **Impact estimate:** None. S-1 ("half their day") is unverified and the volume was lower than first stated (F-3), so a time-saving figure would be guesswork.
- **How it could fail or backfire:** coordinators skip the list and keep working from the inbox (detected by M-2); drafted messages read as generic and annoy customers (customer service reviews a sample weekly); unmatched exceptions pile up unseen (AC-2, daily check).

## Risks and feasibility

| ID | Risk or dependency | Kind | Status | Mitigation or check |
| --- | --- | --- | --- | --- |
| RK-1 | The export lacks fields needed to match customers (A-2). | data | assumed | IT matches one day of export against the spreadsheet before the build starts; one day. |
| RK-2 | The carrier changes the export format. | technical | assumed | Unmatched rows surface rather than disappear (AC-2). |
| RK-3 | Customer contact details flow into a new tool. | privacy | known | Keep the list inside the existing internal environment; no new third party without approval (C-2). |

## Decisions

| ID | Decision | Rationale | Status | By and date |
| --- | --- | --- | --- | --- |
| D-1 | Problem statement and affected people as above | The request named a solution; the outcome the director cares about is time to customer contact. | approved | Operations director, 2026-11-17 |
| D-2 | Build the smallest slice of O-3 | See recommendation. | approved | Operations director, 2026-11-18 |
| D-3 | Must-have scope and AC-1 to AC-4 | Fits six weeks (C-1); covers about 80% of volume. | approved | Operations director, 2026-11-18 |
| D-4 | Key accounts get personal contact; others get coordinator-reviewed drafted messages | Resolves X-1; both leads agreed (SRC-5). | approved | Operations director and customer service lead, 2026-11-18 |
| D-5 | Defer automatic sending and the two smaller carriers | Needs evidence from the first month (A-3, M-1). | approved | Operations director, 2026-11-18 |
| D-6 | Defer the customer status page | Not needed for the outcome; would not fit C-1. | approved | Operations director, 2026-11-18 |
| D-7 | Hand over to engineering with A-2 checked before the build starts | Readiness gate met; A-2 has a one-day check (RK-1). | approved | Operations director, 2026-11-18 |
