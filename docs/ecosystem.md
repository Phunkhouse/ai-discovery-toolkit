# Ecosystem and handover contract

How the AI Discovery Toolkit relates to the other toolkits, based on their state on 2026-11-24 (AI Starter Pack `b143116`, AI Audit Toolkit `de000bd`, AI Social Toolkit `c0ef554`). Each toolkit stays independently usable: no runtime dependencies, no coordinated releases. They connect through shared concepts and portable Markdown files in the target project.

## Boundaries

| Toolkit | Answers | Owns in the target project | Stops at |
| --- | --- | --- | --- |
| **AI Discovery Toolkit** | Should we build this, for whom, and what is the smallest useful thing? | `docs/discovery/<slug>/brief.md`, `handover.md` | An approved direction, scope and acceptance criteria. No architecture, stack or task plan. |
| **AI Starter Pack** | How do we build it with the right amount of governance? | `AGENTS.md`, `docs/SPEC.md`, `docs/STATUS.md`, profile documents | Delivery process; it takes the problem and scope as given. |
| **AI Audit Toolkit** | Is what was built correct, secure, maintainable and ready? | `docs/audits/` | Findings; never changes the code. |
| **LLM Evaluation Toolkit** (planned) | Does the AI inside the application behave as intended? | not yet defined | — |

## Shared concepts

These already exist in the Starter Pack and are used here with the same meaning:

- **One source of truth per concern.** During discovery, the brief; once building starts, the project's specification.
- **Fact status:** confirmed, assumption, proposal, decided. Discovery adds finer kinds (stakeholder statement, inferred requirement, conflict, open question) that map onto these at handover.
- **Approval does not confirm an assumption.** Both toolkits state this rule in the same words.
- **Handover by a rewritten status section:** the Starter Pack's `docs/STATUS.md` and the brief's *Resume here* follow the same pattern: rewritten, not appended, with the next step specific enough to start without asking.
- **Acceptance criteria as `AC-n`** with how each is checked. Discovery's IDs carry over unchanged into a Sprint `docs/SPEC.md`.
- **Commit style, PR cadence and public-repository rules** follow the Starter Pack's conventions.

## The handover contract

The interface between discovery and everything after it is one Markdown file, `docs/discovery/<slug>/handover.md`, with fixed sections: problem and outcome, scope (must have, non-goals, deferred), acceptance criteria, requirements and constraints, open assumptions, non-blocking open questions, success metrics, material risks, decisions and rationale, and instructions for the engineering agent. Each line keeps its discovery ID, and the header names the brief's `Updated` date so staleness is detectable.

Any engineering agent can read it as is. With the Starter Pack:

| Handover | Sprint | MVP or Production |
| --- | --- | --- |
| Problem and outcome | `docs/SPEC.md` Goal | `docs/SPEC.md` Purpose and users |
| Must have, acceptance criteria | Acceptance criteria (same `AC-` IDs) | Scope; milestone acceptance checks |
| Non-goals, deferred | Non-goals, Deferred | Scope (out of scope); backlog |
| Confirmed facts, approved requirements, constraints | Facts and assumptions: `confirmed` | `docs/assumptions.md` Confirmed |
| Open assumptions | Facts and assumptions: `assumption` | `docs/assumptions.md` Open, with how each gets confirmed |
| Decisions | Decision log: `decided` | `docs/decisions/` for hard-to-reverse choices |
| Metrics, risks | README or SPEC notes | SPEC: Purpose; Known limitations and risks |

The Sprint profile's set-up prompt takes "the brief"; `handover.md` can be pasted there directly.

Downstream, the AI Audit Toolkit learns intended behavior from product documentation and an optional `docs/audits/context.md`. The handover's acceptance criteria, constraints and accepted assumptions are exactly that kind of input, so `audit-correctness` can check an implementation against them without any change to either toolkit. `audit-legal-readiness` and `audit-scalability-cost` both have a Planning mode that works from a specification; a discovery's risks and constraints are a reasonable input to them.

## Overlap, and how it is avoided

- **Starter Pack Sprint set-up also fills a SPEC from a brief and marks assumptions.** Discovery comes first and decides *what* and *whether*; the Starter Pack records the approved result and governs building it. When a discovery has been handed over, the SPEC is filled from the handover rather than from the raw brief, so the work is not repeated.
- **Starter Pack MVP keeps an assumptions register.** Open assumptions from discovery move into it at handover with their discovery IDs in the source column; the brief stays as the record of why, and is not kept in step afterwards.
- **Audit Toolkit's legal and scalability Planning modes** assess specifications. Discovery only names those risks and recommends a check; it does not perform legal or capacity analysis.

## Integrations in place

Each lives in the other repository and needs nothing from this one at runtime:

- **Starter Pack `discovery` recipe** ([Phunkhouse/ai-starter-pack#21](https://github.com/Phunkhouse/ai-starter-pack/pull/21)): `recipes/discovery/` says when to offer discovery at setup, how a handover fills `docs/SPEC.md` and `docs/assumptions.md` with discovery IDs kept, and adds an `AGENTS-section.md` that sends contradicted assumptions and scope changes back through discovery. The bootstrap prompt lists `discovery` among the optional recipes, and the Sprint set-up prompt accepts a handover as "the brief".
- **Audit context** ([Phunkhouse/ai-audit-toolkit#23](https://github.com/Phunkhouse/ai-audit-toolkit/pull/23)): `templates/project-context.md` has a line for the handover's path and source date, so audits treat its acceptance criteria, constraints and open assumptions as intended behavior without trusting a stale handover.

The mapping table above is the single statement of the contract; the Starter Pack recipe links to it rather than repeating it. Change it here first, then check the recipe still agrees.

## Integration opportunities for later

None of these are implemented, and none require coordinated releases:

1. **LLM Evaluation Toolkit:** when a discovery's solution includes model behavior, its hypotheses and failure modes become the seed for behavioral evaluation criteria. Define this when that toolkit exists.
2. **A shared installer.** The three toolkits ship near-identical `install.sh` scripts; a single script that links every toolkit's Skills would remove the copies. Worth doing once a fourth toolkit appears.
