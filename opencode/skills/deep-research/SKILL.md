---
name: deep-research
description: Exhaustive, multi-step literature search with Tongyi
  DeepResearch. Use for systematic reviews and complex evidence
  gathering — not quick citation lookups.
license: MIT
---

# Skill: deep-research

Conduct exhaustive, multi-angle research on a topic using the model's
built-in iterative search. Return structured output only — no
fabrication, no invented citations.

## When to use

- User asks for "deep research", "systematic review", or "exhaustive
  coverage"
- Topic requires cross-disciplinary synthesis
- Quick Gemini Flash search (literature-review) was insufficient

## Output format

### Per-paper summary (repeat for each source)

**Title**: Full title  
**Authors**: Last, F., Last, F.  
**Year**: YYYY  
**Venue**: Journal / conference / preprint server  
**DOI/URL**: link or `<!-- TODO: verify -->`  
**Abstract**: Verbatim if available; paraphrase only if unavailable  
**Overview**: 1–3 sentences  
**Methods**: Brief snapshot of study design or approach  
**Findings**: Main results or conclusions  
**Relevance**: Why this matters for the project  

### Synthesis paragraph

After all per-paper summaries, write one synthesis paragraph grouping
sources by theme, method family, or role in the argument.

## Guardrails

- Never fabricate citations, DOIs, statistics, or findings
- Mark uncertain details with `<!-- TODO: verify -->`
- Do not merge distinct papers into one summary
- Do not bypass paywalls
- Distinguish what authors claim from how strong the evidence is
- If the internal search returns no results, say so explicitly
- Adopt a cautious academic tone: separate claims from evidence quality
