# Validation plan

A Standard discovery usually rests on a few beliefs that nobody has tested: people have this problem, they would change how they work, they would pay, the data exists. The validation plan names those beliefs and the cheapest way to test each before or during the build.

## Choose the hypotheses

1. List the assumptions (`A-`) and beliefs behind the recommendation and the must requirements.
2. Rank them by **risk** (how much is lost if wrong) and **uncertainty** (how little evidence there is). The top two to four become hypotheses (`H-`). Do not write hypotheses for things that are already known or would not change a decision.
3. Write each as: "We believe <change> for <people> will result in <outcome>." Link the assumptions it tests in the register's *Notes* (`Check: H-…`).

## Choose the test

Prefer the cheapest test that could change the decision, in roughly this order:

| Test | Good for | Watch out for |
| --- | --- | --- |
| Data pull or document check | Volumes, baselines, whether a system offers an export or API | The data may not measure what you think |
| Structured interviews (5–10 per group) | Whether the problem exists and how it is handled today | Tests what people say, not what they do; avoid pitching |
| Concierge or manual service | Whether people use and come back to the service | Does not test scale or automation |
| Clickable prototype or landing page | Whether people understand and want the offer | Interest is not commitment; measure an action |
| Technical spike, time-boxed | Whether an integration or approach is feasible | Stop at the time box; report what was learned |
| Pilot with real users | Whether the outcome moves | The most expensive; use only once cheaper tests passed |

## Set the thresholds before running

For each hypothesis, write what result means **pass** and what means **fail** before the test starts, with the owner's agreement. A threshold chosen after seeing the result is not a test. If a sensible threshold is unknown, say so and set a provisional one, labelled as the owner's target, not as a benchmark.

Also write the **time and cost** of the test and the **decision it informs**: which `D-` or must requirement changes if it fails.

## Record results

When a test runs, add its result as a source and facts (`SRC-…`, `F-…`), set the hypothesis to `supported` or `refuted` (or keep it `testing`, with what is still missing), and follow the IDs that depend on it. A refuted hypothesis is a result, not a failure of the discovery: it usually changes the direction or the MVP, and the brief should say how.

Never invent or estimate a test result. Until a test has run, its hypothesis stays `untested`.
