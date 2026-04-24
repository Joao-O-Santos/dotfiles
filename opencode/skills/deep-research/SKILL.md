---
name: deep-research
description: Exhaustive, multi-step evidence gathering for systematic reviews, conflicting literatures, and complex multi-hop research questions.
license: MIT
---
 
# Skill: deep-research
 
Conduct exhaustive, multi-angle research using the model's built-in iterative
search. This skill is for retrieval and evidence mapping, not manuscript drafting
or autonomous file editing.
 
## When to use
 
Use this skill when:
 - the user asks for deep research, exhaustive coverage, or systematic review
 - fast literature review was insufficient
 - the evidence base is fragmented, conflicting, or cross-disciplinary
 - the question requires multi-hop search and comparison across sources
 
Do not use this skill when:
 - the task is a quick citation lookup
 - a small number of sources is enough
 - the main task is drafting prose
 - the planner only needs a fast relevance check
 
## Operating principles
 
1. Search broadly first, then narrow.
2. Decompose the research question into subquestions.
3. Track agreement, disagreement, and gaps explicitly.
4. Prefer primary sources, reviews, and open-access sources when possible.
5. Separate source claims from evidence strength.
6. Stop when marginal search yield becomes low.
 
## Search strategy
 
For each request:
 1. Break the problem into 2–6 subquestions.
  2. **Use MCP tools as primary search** (configured globally in `opencode.json`):
#mcp-academic-search
  3. Search each subquestion using MCP tools first. If they fail after reporting the error, use webfetch or direct REST APIs for supplementary coverage.
 4. Use multiple angles: core terms, synonyms, competing terminology, adjacent fields, and method-specific queries.
 5. Retrieve abstract and DOI for each result via MCP tools.
 6. Deduplicate near-identical sources.
 7. Prioritize review papers, landmark studies, and directly relevant empirical work.
 8. Record uncertainty and unresolved conflicts explicitly.
 
## Stopping criteria
 
Stop and return results when any of the following is true:
 - top sources begin repeating across search angles
 - new searches yield mostly duplicates or low-relevance results
 - coverage is sufficient to answer all subquestions
 - the question cannot be resolved with available evidence
 
Do not continue searching just because search is available.
 
## Output format
 
Return a structured research memo.
 
### Header
 - Research question
 - Scope
 - Subquestions searched
 - Coverage level: preliminary / moderate / exhaustive
 - Known limitations
 
### Per-source note
For each source, provide:
 
 **Title**:
 **Authors**:
 **Year**:
 **Venue**:
 **DOI/URL**: real link or `<!-- TODO: verify -->`
 **Source type**: empirical / review / meta-analysis / theory / preprint
 **Question addressed**:
 **Claim**: 1-3 sentences describing what the source argues or finds
 **Methods or basis**: brief design, dataset, or argument basis
 **Evidence strength**: strong / moderate / weak / unclear
 **Relevance**: why it matters for the current project
 **Caveats**: limitations, ambiguity, or verification issues
 
### Synthesis section
After the per-source notes, include:
 - Themes
 - Points of agreement
 - Points of disagreement
 - Missing evidence
 - Recommended next search directions
 
## Guardrails

#research-guardrails
- Do not write final manuscript prose unless explicitly instructed.
- Do not edit project files unless explicitly instructed elsewhere.
- Mark uncertain metadata with `<!-- TODO: verify -->`.
- If coverage is weak, say so explicitly.
#mcp-procurement-rule
 
## Handoff rule
 
Return structured evidence for the planner, writer, or reviewer to use.
Do not treat deep research as the final writing stage.

## Quick Reference (compact reminders)

- **Scope**: systematic evidence, multi-hop, conflicting literatures.
  Not for quick lookups or prose drafting.
- **Workflow**: decompose → multi-angle search → deduplicate → track
  agreement/disagreement/gaps → stop when yield collapses.
- **Output minimum**: research question, subquestions, coverage level,
  per-source notes, limitations, synthesis.
- **Escalation**: if only 2–5 papers are needed, recommend
   `finding-refs` instead.
- **Anti-drift**: no fabrication, no manuscript prose unless instructed,
  stop when marginal yield is low, mark uncertainty with
  `<!-- TODO: verify -->`.