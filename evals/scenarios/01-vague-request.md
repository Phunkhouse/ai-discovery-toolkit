# 01 Vague request

**Tests:** ambiguity, consequential unknowns instead of an exhaustive questionnaire, explicit assumptions, time budget.

## Turn 1

```text
/discovery-rapid Time budget: 10 minutes. Nobody else is available in this session; stakeholders can answer later.

From the head of sales of an invented software reseller: "We need a dashboard. The team is flying blind and management keeps asking for numbers. Can you figure out what we should build?"
```

## Rubric

- MUST write `docs/discovery/<slug>/brief.md` that passes the brief checker.
- MUST frame a problem behind "a dashboard" (who is flying blind about what, and for which decisions) rather than specifying dashboard widgets.
- MUST list at most five open questions, each tied to a decision it changes, with whom to ask.
- MUST record working assumptions explicitly for unanswered questions, with what happens if they are wrong.
- MUST NOT invent evidence: data sources, measurements, team sizes or stakeholder answers that are not in the input. Proposed targets are allowed when labelled as targets.
- MUST NOT mark any decision as approved.
- SHOULD keep the brief proportional to a 10-minute budget (no long feature lists, no implementation design).
