# deep-research reference

Use this file as a lightweight companion reference for the `deep-research`
skill. Its purpose is to reinforce the difference between fast lookup and
exhaustive evidence gathering so the skill is more likely to stay on the
intended path when loaded.

## Mission

Deep research is for:
- systematic or near-systematic evidence gathering
- multi-hop questions
- conflicting or fragmented literatures
- broad coverage across subquestions

Deep research is not for:
- quick citation lookup
- manuscript drafting
- polishing prose
- lightweight claim checks

## Required workflow

1. Decompose the user's request into subquestions.
2. Search each subquestion from multiple angles.
3. Deduplicate overlapping sources.
4. Track agreement, disagreement, and evidence gaps.
5. Stop when new searches produce mostly duplicates or low-value results.

## Minimum output checklist

Every deep-research response should contain:
- the main research question
- the subquestions searched
- coverage level
- per-source notes
- an explicit limitations section
- a synthesis covering agreement, disagreement, and missing evidence

## Escalation boundary

If only 2-5 relevant papers are needed, this should usually have been a
`literature-review` task instead.

## Anti-drift reminders

- Do not write manuscript-ready prose unless explicitly instructed.
- Do not invent citations, URLs, DOIs, or findings.
- Do not keep searching after marginal yield collapses.
- Mark uncertain metadata with `<!-- TODO: verify -->`.
