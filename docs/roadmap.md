# Roadmap

Provisional. Each stage starts only after the previous one has been used on real problems, and its contents will change with what that use shows.

## Profiles

| Profile | For | Typical budget | Status |
| --- | --- | --- | --- |
| **Rapid** | Time-boxed assignments, hackathons, small features, quick business problem assessments. | 10–30 minutes | v0.1 |
| **Standard** | New products, meaningful features, freelance client discovery, early validation. | hours to a few days, across sessions | v0.2 (in progress) |
| **Deep** | Significant investments, strategic initiatives, high-risk problems. | days to weeks | planned for v0.4 |

Profiles are about discovery depth only. They are independent of the Starter Pack's Sprint, MVP and Production governance profiles: a small feature in a production application can need only Rapid Discovery, and a hackathon idea can deserve a Standard one.

## v0.1: Rapid Discovery (this release)

One self-contained Skill, `discovery-rapid`, with the complete Rapid workflow, brief and handover templates, a structural checker, two worked examples and seven behavioral scenarios.

## v0.2: Standard Discovery and modular Skills

- **Done:** shared method files in `shared/`, synced into each Skill ([decision 0003](decisions/0003-shared-method-synced-copies.md)), and `discovery-handover` as the one step that is a Skill of its own. Other steps (framing, questions, options) stay inside the profile Skills unless real use shows a need to invoke them alone.
- **Done:** `discovery-standard` ([decision 0004](decisions/0004-standard-profile-one-brief.md)): stakeholder map, user workflows, prioritized requirements, MVP scope, a validation plan, three approval checkpoints; the handover doubles as the structured product specification.
- **Done:** a stakeholder question pack for asynchronous discovery and rules for replies that arrive out of order (in `discovery-standard`).
- **Done:** upgrading a Rapid brief to Standard in place.
- Open: release v0.2.0 after the owner has used Standard on at least one real discovery.
- **Done:** a compact brief format (format 2, [decision 0002](decisions/0002-compact-brief-format.md)): one register table, scope as labelled lines, a length warning in the checker.
- Lessons from real Rapid usage folded back into the rules and scenarios.

## v0.3: Interoperability and installation

- Propose the Starter Pack `discovery` recipe and the audit-context pointer described in [ecosystem](ecosystem.md), in those repositories, with the owner's approval.
- Verify Codex end to end and record any differences.
- Consider a shared installer across the toolkits, and a project-local install mode for client machines.
- Optional: a light "discovery status" summary across all briefs in a project.

## v0.4: Deep Discovery

Candidates, to be confirmed by need:

- Systematic user and market research plans, with interview guides and synthesis that keeps quotes traceable to sources.
- Detailed stakeholder mapping and decision rights.
- Business case development with transparent assumptions and sensitivity ranges.
- Competitive analysis from verified, dated sources.
- Experiment design with sample sizes and stop rules.
- Complex trade-off evaluation and detailed risk assessment.
- Product strategy and roadmap development.

## Not planned

A custom CLI, application, database, orchestration framework or hosted service. Revisit only with a demonstrated need that Markdown and Skills cannot meet.
