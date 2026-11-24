# 0004. Standard Discovery extends the same brief

Date: 2026-11-24  
Status: accepted

## Context

Standard Discovery covers new products, meaningful features and client engagements: several stakeholders, several workflows, prioritized requirements, an MVP and a validation plan, built up over several sessions with asynchronous answers. It needs more structure than a Rapid brief, but the toolkit's rules (one source of truth, IDs instead of repetition, explicit approvals) still apply, and a Rapid discovery should be able to grow into a Standard one without starting again.

## Decision

- **One brief per discovery, for both profiles.** A Standard brief is a format 2 brief with `Profile: Standard` and four more sections: Stakeholders (`P-`), User workflows (`W-`), Requirements (moved out of the register, grouped by workflow with must/should/could/won't priority) and Validation plan (hypotheses with tests and thresholds set before running). The shared checker selects the required sections from the profile line.
- **Three checkpoints** for approval: A problem and stakeholders, B direction, C MVP scope, requirements, criteria and validation plan. The owner approves the framing before the discovery goes deep.
- **Upgrade in place:** a Rapid brief becomes Standard by changing the profile line and adding sections, keeping every ID and approval.
- **Limits by profile** in the shared rules (questions, options, metrics, criteria, length), with the checker warning on length and open questions.
- **Standard-only references** (stakeholders and question packs, workflows and requirements, validation) live in the Standard Skill; they move to `shared/` only if another Skill needs them.
- Handover stays one template; Standard fills its User workflows section, and the readiness gate adds a Standard item.

## Alternatives considered

- **Several files per Standard discovery** (stakeholders, requirements, validation as separate documents): easier to scan for a large discovery, but splits one source of truth, multiplies cross-file references and makes the upgrade from Rapid a migration.
- **A separate Standard brief format:** cleaner per profile, but two formats to check and convert between, and no in-place upgrade.
- **No checkpoints, one approval at the end:** fewer interruptions, but risks hours of work on a framing the owner would reject.

## Consequences

- A Standard brief is long (target under about 3,500 prose words); the sections keep it navigable.
- Requirements live in the register for Rapid and in their own section for Standard; the upgrade moves them.
- If real Standard discoveries routinely exceed the length target, revisit splitting stakeholders or requirements into their own files.
