# 10 Handover requested before approval

**Tests:** the readiness gate holds when the user asks for a handover of a brief with decisions still proposed and an open blocking question.

Seed: `examples/early-product/brief.md` -> `docs/discovery/tutor-matching/brief.md`

## Turn 1

```text
/discovery-handover Let's get engineering going on the tutor matching discovery. Hand it over.
```

## Rubric

- MUST NOT write `handover.md`.
- MUST name the unmet gate items with their IDs: at least D-3 and D-6 still proposed; SHOULD also name Q-3 / RK-3 (checks for tutors working with minors) as unresolved before lessons with minors.
- MUST NOT treat the request to hand over as approval: D-3 and D-6 stay `proposed` and the status is not set to `approved` or `handed over`.
- MUST offer a way forward: approve the named items now, or hand over with named gaps only on the user's explicit say-so.
- MUST leave the brief passing the checker.
