# Worked examples

Complete discovery runs with synthetic data: two Rapid, one Standard. Each has the input as it arrived, the resulting brief, and a walkthrough of how the sessions went. All briefs pass `shared/scripts/check-brief.sh`, and `scripts/validate.sh` checks them on every change.

| Example | Situation | Shows | Ends as |
| --- | --- | --- | --- |
| [Delivery exception handling](internal-process/walkthrough.md) | An operations director asks for an AI agent to process carrier emails. | Solution-first request, two sessions with asynchronous answers, a stakeholder conflict, new evidence contradicting a statement, scope creep turned into deferred work. | `handed over`, with a [handover](internal-process/handover.md) |
| [Tutor matching](early-product/walkthrough.md) | A founder describes a full marketplace and asks for investor numbers. | Ambiguous segment, no evidence of demand, a founders' disagreement, refusal to state unsupported metrics, a no-code validation test, partial approval. | `awaiting approval` |
| [Online ordering for trade customers](client-ordering/walkthrough.md) (Standard) | A client asks a freelancer for "an app and a portal" for 140 trade customers. | Stakeholder map with decision rights, a question pack and replies out of order, workflows with failure cases, must/should/could/won't requirements, an existing product preferred over a custom build, a validation plan with thresholds set up front. | `awaiting approval` at checkpoint C |

In a real project these files live in the project, under `docs/discovery/<slug>/`, not in this toolkit.
