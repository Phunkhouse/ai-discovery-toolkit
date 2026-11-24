# Discovery brief: Delivery exception handling

- **Status:** handed over
- **Format:** 2
- **Profile:** Rapid; budget 20 minutes, used 18 (session 1) and 9 (session 2)
- **Decision owner:** Operations director
- **Updated:** 2026-11-18 by discovery agent

## Resume here

- **Done:** Problem, direction, scope and acceptance criteria approved on 2026-11-18 after IT, operations and customer service answered. Handover written.
- **Waiting on:** Customer service to count late-notice complaints for the M-3 baseline before release.
- **Next step:** Engineering starts from `handover.md`. Reopen this brief only if a build finding contradicts an entry here.

## Problem

- **Request:** an AI agent that reads carrier exception emails, updates the tracking spreadsheet and emails every customer automatically (SRC-1).
- **Problem statement:** Operations coordinators struggle to tell customers about delivery exceptions quickly when carrier notices arrive as free-text emails in a shared inbox, which leads to customers hearing about delays late and complaining. It is solved when affected customers are contacted within an hour of the carrier notice, without more coordinator time.
- **Affected:** customers with delayed, damaged or failed deliveries (late information); coordinators (re-keying before acting); customer service (complaints).
- **Today:** email → coordinator re-keys it into the spreadsheet → looks up the customer → writes or calls. Delay builds up at re-keying (A-1), taking about 5 hours to contact (F-2).
- **Why now:** complaints about late notice are rising (S-6); the director wants a change before peak season (C-1).

## Register

- **SRC-1** Request from the operations director, pasted in chat, 2026-11-17
- **SRC-2** Operations director, answers in session 1, 2026-11-17
- **SRC-3** IT lead, written answer relayed by the director, with the carrier portal's export documentation, 2026-11-18
- **SRC-4** Operations director, two-week count from the shared inbox and spreadsheet timestamps, 2026-11-18
- **SRC-5** Customer service lead and operations director, joint answer relayed by the director, 2026-11-18

| ID | Entry | Source | Status | Notes |
| --- | --- | --- | --- | --- |
| F-1 | The main carrier's portal offers a CSV export of exceptions every 15 minutes; no API or webhook. | SRC-3 | confirmed | |
| F-2 | Median time from carrier email to customer contact: about 5 hours. | SRC-4 | confirmed | |
| F-3 | About 60 exception emails per working day. | SRC-4 | confirmed | |
| S-1 | Coordinators spend about half their day on exception emails. | SRC-1, operations director | reported | |
| S-2 | About 150 exception emails a day. | SRC-1, operations director | contradicted by F-3 | |
| S-3 | No automatic emails to key accounts. | SRC-1, customer service lead (via director) | superseded by D-4 | |
| S-4 | The carrier portal might have an API. | SRC-1, IT (via director) | confirmed as F-1 (export, no API) | |
| S-5 | Three carriers; about 80% of exceptions from one. | SRC-2, operations director | reported | |
| S-6 | Complaints about late delay notices are increasing. | SRC-1, operations director | reported | |
| R-1 | Main carrier exceptions appear in one list without re-keying. | A-1, F-1 | approved | inferred |
| R-2 | Each exception needing contact gets a pre-filled message the coordinator reviews and sends. | SRC-1, D-4 | approved | explicit |
| R-3 | Key accounts are never contacted automatically; they are flagged for personal contact. | S-3, D-4 | approved | explicit |
| R-4 | Customer messages are sent automatically, without review. | SRC-1 | deferred (D-5) | explicit |
| C-1 | Live within six weeks of 2026-11-17. | SRC-1 | reported | |
| C-2 | Small budget; no new paid platform without the director's approval. | SRC-1 | reported | |
| A-1 | Re-keying is the main source of delay. | Workflow described in SRC-2 | accepted (operations director, 2026-11-18) | If wrong: the list alone barely cuts contact time. Check: coordinators time the steps for 20 exceptions. Plan: proceed. |
| A-2 | The CSV export identifies shipment and customer. | F-1 | open | If wrong: lookups stay manual. Check: IT matches one day of export (RK-1). Plan: validate first. |
| A-3 | Coordinators will review drafts rather than rewrite them. | — | accepted (operations director, 2026-11-18) | If wrong: little time saved. Check: edits in the first two weeks. Plan: proceed. |
| X-1 | Director: automatic emails for everyone (SRC-1). Customer service: none for key accounts (S-3). | SRC-1, S-3 | resolved by D-4 | Affects D-2, R-3, R-4; resolved by the director with the customer service lead. |
| RK-1 | The export lacks fields to match customers (A-2). | A-2 | assumed | Data; IT checks one day of export before the build, one day. |
| RK-2 | The carrier changes the export format. | — | assumed | Technical; unmatched rows surface instead of disappearing (AC-2). |
| RK-3 | Customer contact details flow into a new tool. | C-2 | known | Privacy; keep the list in the existing internal environment, no new third party without approval. |

## Open questions

| ID | Question | Decision it changes | Ask | If unanswered | Status |
| --- | --- | --- | --- | --- | --- |
| Q-4 | Who decides between automatic emails for everyone and none for key accounts? | X-1, R-3 | Operations director | No automatic sending | answered (D-4) |
| Q-2 | Does the carrier portal offer an API, export or notifications for exceptions? | D-2 | IT lead | Parse the emails | answered (F-1) |
| Q-1 | How long does it take today from a carrier email to customer contact? | M-1 baseline | Operations director | No baseline | answered (F-2) |
| Q-5 | How many carriers send exceptions, in what formats? | Scope of R-1 | Operations director | One main carrier | answered (S-5) |
| Q-3 | What share of exceptions needs customer contact at all? | Size of R-2 | Operations director | All of them | open |

## Options and recommendation

| ID | Option | Value | Effort | Risk | Confidence | Notes |
| --- | --- | --- | --- | --- | --- | --- |
| O-1 | AI agent parses every carrier email, updates the spreadsheet, emails customers automatically (as requested). | H | H | H | L | Three free-text formats; auto-sending conflicts with R-3; hard in six weeks. |
| O-2 | Process only: triage rota and message templates. | L | L | L | M | Cheap, but re-keying (A-1) stays. |
| O-3 | Import the main carrier's export into one list with drafted, reviewed messages; key accounts flagged. | M-H | M | L | M | About 80% of volume (S-5) without parsing free text. |
| O-4 | Off-the-shelf customer notification product. | M | M | M | L | Not explored; likely above budget (C-2). |

**Recommendation (D-2, approved):** Build the smallest slice of O-3. The export (F-1) removes re-keying for most exceptions without an AI dependency, and human review protects key accounts (R-3). It rests most on A-1 and A-2; if A-2 fails, the fallback is parsing the main carrier's emails. Automatic sending and the other carriers wait until the slice is measured.

## Scope

- **Must have:** main carrier exceptions from the export in one list, matched to shipment and customer (R-1); a pre-filled message per exception that the coordinator can edit and send (R-2); key accounts flagged for personal contact (R-3).
- **Optional:** exceptions from the two smaller carriers entered by hand into the same list.
- **Non-goals:** automatic sending; parsing free-text emails with AI; replacing the tracking spreadsheet.
- **Deferred:** automatic sending to non-key accounts and the smaller carriers' formats, after a month of evidence (D-5); a customer status page, raised in session 2 (D-6).

## Acceptance criteria

- [ ] **AC-1** A main carrier exception appears in the list within 20 minutes of its export, with shipment and customer filled in; checked by a walkthrough with one day's export (R-1).
- [ ] **AC-2** An exception whose shipment cannot be matched appears marked "unmatched" instead of being dropped; checked by a test with an unknown shipment number (R-1).
- [ ] **AC-3** The coordinator can open, edit and send a drafted message from the list; checked by a walkthrough (R-2).
- [ ] **AC-4** A key-account exception shows "personal contact" and offers no send action; checked by a test (R-3).

## Success

- **Outcome:** customers hear about delivery exceptions within an hour, and coordinators spend less time on exceptions, not more.
- **H-1:** We believe that removing re-keying for the main carrier will let coordinators contact affected customers within an hour. We will know when M-1 is under one hour within four weeks of release. It is wrong if the median stays above three hours.
- **Impact estimate:** None. S-1 is unverified and the volume was lower than first stated (F-3).
- **Could fail or backfire:** coordinators keep working from the inbox (M-2 stays low); drafts read as generic and annoy customers (customer service reviews a weekly sample); unmatched rows pile up unseen (AC-2, daily check).

| ID | Metric | Type | Baseline | Target |
| --- | --- | --- | --- | --- |
| M-1 | Median time from carrier exception to customer contact | lagging | measured: about 5 hours (F-2) | target: under 1 hour |
| M-2 | Share of main carrier exceptions reaching the list without re-keying | leading | measured: 0% today | target: at least 90% |
| M-3 | Complaints about late delay notice per month | lagging | unknown: customer service counts for four weeks before release | target: set once the baseline exists |

## Decisions

| ID | Decision | Rationale | Status | By and date |
| --- | --- | --- | --- | --- |
| D-1 | Problem statement as above | The request named a solution; the director's outcome is time to customer contact. | approved | Operations director |
| D-2 | Build the smallest slice of O-3 | See recommendation. | approved | Operations director, 2026-11-18 |
| D-3 | Must-have scope and AC-1 to AC-4 | Fits six weeks (C-1); covers about 80% of volume. | approved | Operations director, 2026-11-18 |
| D-4 | Key accounts get personal contact; others get reviewed drafts | Resolves X-1; both leads agreed (SRC-5). | approved | Operations director and customer service lead, 2026-11-18 |
| D-5 | Defer automatic sending and the smaller carriers | Needs a month of evidence (A-3, M-1). | approved | Operations director, 2026-11-18 |
| D-6 | Defer the customer status page | Not needed for the outcome; would not fit C-1. | approved | Operations director, 2026-11-18 |
| D-7 | Hand over, with A-2 checked before the build starts | Readiness gate met; A-2 has a one-day check (RK-1). | approved | Operations director, 2026-11-18 |
