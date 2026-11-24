<!-- Generated from shared/references/questions.md by scripts/sync-shared.sh. Edit that file, then run the script. -->
# Questions that change decisions

Collect the unknowns that would change what gets built, or whether. Not everything that would be interesting to know.

## Find the consequential unknowns

For each candidate unknown, ask yourself:

1. **Which decision does the answer change?** Name it: the recommended option, a must-have item, an acceptance criterion, a metric's baseline, a go/no-go. If none, drop the question.
2. **How likely is the current assumption to be wrong?**
3. **How costly is being wrong?** Rework, a wasted build, harm to users, a compliance problem.
4. **Can it be answered in time, by someone reachable?**

Rank by the first three; use the fourth to choose between asking now, sending later, or working on an assumption. Keep at most five open questions in a Rapid round. Merge questions that serve the same decision.

Typical high-value unknowns:

- Who actually has the problem, and how often or how badly.
- What happens today: the workaround, and what it costs.
- What a successful outcome looks like to the decision owner, and how it would be noticed.
- Hard constraints: deadline, budget, systems that must or must not be touched, policy.
- Whether the data, API or access a solution relies on exists.
- Who decides, when stakeholders disagree.

## Write good questions

- **Non-leading.** Ask about the situation, not for agreement with a solution. Not "Would an AI assistant help?" but "When a request like this arrives, what happens next, and where does it get stuck?"
- **Concrete and recent.** "Walk me through the last time this happened" yields better evidence than "How often does this usually happen?"
- **One thing per question**, answerable in a few sentences.
- **Ask for evidence when it exists:** "Is there a report or export that shows this?"
- **Directed:** to the person who can actually know. Volumes to whoever owns the data; goals to the decision owner; workflow to the people who do the work.

## Record each question

In the brief's open-questions table, most important first: the question, the decision it changes, whom to ask, the working assumption if it stays unanswered (an `A-` entry), and the status.

## Asking

- **Interactive:** ask the top one to three in one message. Explain in a short clause why each matters, so the person can answer usefully or say "unknown".
- **Asynchronous:** the open-questions table is the list to send. When the user wants a message for stakeholders, draft it as plain text grouped by recipient, with the context each needs; the user sends it.
- **Answers:** record what was said as `S-` (or `F-` if it can be verified), with source and date, and set the question to `answered (S-…)`. A partial or vague answer is recorded as such; do not upgrade it.
- **No answer:** the working assumption stands, visibly. Say what proceeding on it risks and recommend one of: proceed, validate first, or defer.
