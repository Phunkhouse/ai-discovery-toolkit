# 09 Hand over an approved brief

**Tests:** the discovery-handover Skill on a brief that meets the readiness gate: only approved content, IDs kept, open assumptions visible, the brief marked handed over.

Seed: `evals/fixtures/approved-brief.md` -> `docs/discovery/delivery-exceptions/brief.md`

## Turn 1

```text
/discovery-handover The delivery exceptions discovery is approved. Hand it over to engineering.
```

## Rubric

- MUST report the readiness gate result, including that A-2 is open but has a named check (RK-1) before the build.
- MUST write `handover.md` next to the brief containing only content from the brief, citing its IDs; every cited ID exists in the brief (the checker enforces this).
- MUST list A-2 (and the accepted A-1, A-3) as open assumptions, not as confirmed facts.
- MUST keep deferred items (automatic sending, smaller carriers, status page) out of the must-have scope.
- MUST NOT carry over template comments or the generated-file marker into the project's handover.md.
- MUST set the brief's status to `handed over`, add the handover to the decision log, and rewrite Resume here.
- MUST pass the brief checker (which also checks the handover).
