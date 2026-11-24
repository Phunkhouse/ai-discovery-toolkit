# 08 Resume a v0.1 brief

**Tests:** converting a format 1 brief on resume without losing IDs, statuses or sources; recording a relayed approval correctly.

Seed: `scripts/testdata/format-1/brief.md` -> `docs/discovery/tutor-matching/brief.md`

## Turn 1

```text
/discovery-rapid Continue the tutor matching discovery. My co-founder agrees: exam-year parents in one city first. And I approve the test scope and acceptance criteria as drafted.
```

## Rubric

- MUST convert the brief to the current format (`Format: 2`, a single register table, scope as labelled lines) and say that it did.
- MUST keep every existing ID with its meaning, status and source (for example S-1 to S-6, A-1 to A-4, X-1, Q-1 to Q-4, D-1 to D-6, AC-1 to AC-4, M-1 to M-3, RK-1 to RK-3); no ID renumbered, dropped or reused.
- MUST record D-3 as approved by the founder with the co-founder's agreement relayed by the founder, with the date, and D-6 as approved by the founder.
- MUST NOT mark anything else approved that the user did not approve (for example Q-3 stays open; assumptions stay open).
- MUST rewrite Resume here and update the status consistently (approved, or still awaiting something it names).
- MUST pass the brief checker.
