<!-- Generated from shared/references/options.md by scripts/sync-shared.sh. Edit that file, then run the script. -->
# Options and recommendation

## Generate options

Compare two to four options that genuinely differ. Include:

- **The requested solution**, if there was one, assessed fairly.
- **At least one option that is not new software:** a process or policy change, better use of a tool the organization already has, an off-the-shelf product, a manual or concierge version, training or documentation.
- **The smallest meaningful intervention:** the least that would produce an observable improvement for the people affected.
- **Do nothing or defer,** when the problem is small, rare, or likely to change. Saying so explicitly makes its cost visible.
- **Validate first,** when the biggest risk is that the problem or demand is not real.

Do not invent options to fill the table, and do not include an option you would never recommend just to make another look good. An option that relies on a system, dataset or capability the inputs do not mention says so in its notes ("assumes the sales data can be exported, A-3") and gets low confidence.

## Assess without false precision

Rate each option on a coarse scale with a one-line reason:

| Dimension | Low / Medium / High means |
| --- | --- |
| **Value** | How much of the problem it removes, for how many of the affected people. |
| **Effort** | Time and people to deliver and run it, including change management, not only build. |
| **Risk** | Chance it fails, harms users, creates compliance or security exposure, or locks in a costly choice. |
| **Confidence** | How much of the assessment rests on confirmed facts rather than assumptions. |

Do not convert these into scores, weighted totals or exact estimates. Where a number helps (hours saved, cost), give a range, state the assumptions it rests on, and label it as an estimate.

## Recommend

Choose one direction and record it as a `proposed` decision. Name it as one of:

- **Build** the smallest slice of option `O-…`.
- **Adopt** an existing product or capability.
- **Change** a process or policy, without building.
- **Validate first** with a named experiment, before committing to a build.
- **Discover further,** naming the questions and the depth (for example a Standard Discovery).
- **Defer** until a named trigger.
- **Don't build,** with the reason.

Give the rationale in two or three sentences: why this direction beats the alternatives on the evidence available, which assumptions it depends on most, and what new evidence would change the recommendation. When the owner asked for something specific and you recommend otherwise, say so plainly and keep their option in the comparison; it is their decision.

## When to discover more instead

Recommend more discovery before a decision when:

- The problem statement still rests mostly on one person's statements and the build is not cheap.
- A key conflict between stakeholders has no one with authority to resolve it.
- The value depends on a number nobody has, and a cheap way to get it exists.
- The cost of being wrong is high (money, safety, legal exposure, users' trust).

Name the smallest step that would resolve it: a question to a specific person, a data pull, a concierge test, a spike.
