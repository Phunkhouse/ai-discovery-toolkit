# 0002. A compact brief format

Date: 2026-11-24  
Status: accepted

## Context

The v0.1 eval runs produced briefs of about 1,350–2,600 words against targets of 800–1,500 (see the [eval log](../../evals/README.md#log)). Two rounds of proportionality rules cut about 20% but no further: the template itself set the floor. A brief had about eleven tables (sources, facts and statements, requirements and constraints, assumptions, conflicts, questions, options, metrics, risks, decisions) and nine required subsections, each with its own header row and repeated columns, so even a trivial problem filled several pages.

## Decision

Brief format 2:

- **One register table** (`| ID | Entry | Source | Status | Notes |`) for facts, statements, requirements, constraints, assumptions, conflicts and risks. The ID prefix carries the kind; *Notes* carries what each kind needs (explicit or inferred for a requirement; if wrong, how to check and the plan for an assumption; the decision affected and who resolves for a conflict; the kind and mitigation for a risk). Sources are a short list of `SRC-` items above it.
- **Scope as labelled lines** (`**Must have:**`, `**Optional:**`, `**Non-goals:**`, `**Deferred:**`) instead of subsections; *Optional* may be left out.
- **Required sections:** Resume here, Problem, Register, Open questions, Options and recommendation, Scope, Acceptance criteria, Success, Decisions. The separate Risks section is gone (risks are `RK-` rows).
- **A `Format: 2` header line**, so the checker and the Skill can tell formats apart.
- IDs, status values, approval rules and the handover template are unchanged.
- **Format 1 briefs** (v0.1) are converted by the Skill when it resumes one, keeping every ID; the checker reports a format 1 brief as needing conversion rather than as a list of missing sections.
- The checker warns when a brief exceeds 1,500 words.

## Alternatives considered

- **Keep format 1 and tighten the rules further:** tried twice in v0.1; the agent follows the template's structure more than length guidance.
- **Make empty subsections optional in format 1:** removes a little text but keeps the tables that carry most of the overhead.
- **Support both formats in the checker indefinitely:** avoids a conversion step, but doubles the checker and the templates for a format that only existed for one day before this change, with no known briefs in real projects.

## Consequences

- Fewer tables to scan; one place to look up any ID.
- The register mixes kinds, so reading "all assumptions" means scanning by prefix. Rows are ordered by kind to keep this easy.
- Briefs written with v0.1 must be converted once; the Skill does this on resume.
