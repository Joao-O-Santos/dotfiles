---
name: finding-refs
description: Fast citation retrieval and source notes for a specific claim
     or topic. Use when the task is lookup, not writing a section.
     Escalate to deep-research for exhaustive coverage.
license: MIT
---

# Skill: finding-refs

Conduct targeted academic searches and return concise, structured source notes.
This skill is for fast retrieval and triage, not long-horizon evidence mapping
or manuscript-ready synthesis.

#style-core

## When to use

Use this skill when:
- the user needs quick citation support
- the planner needs a small set of relevant papers
- you need to check whether a claim has obvious literature support
- the task is source discovery rather than exhaustive review

Do not use this skill when:
- the user requests systematic or exhaustive coverage
- the topic requires multi-hop or cross-disciplinary evidence gathering
- the main goal is final prose drafting
- the task is primarily critique rather than retrieval

## Operating principles

1. Search narrowly and efficiently.
2. Prefer primary sources, recent reviews, and open-access sources when possible.
3. Separate what a source claims from how strong the evidence appears.
4. Stop once the request is adequately covered.
5. Escalate to `deep-research` if the search space becomes broad, fragmented, or conflicting.

## Search workflow

For each request:
1. Identify the exact question or claim to support.
2. **Use MCP tools first** (configured globally in `opencode.json`):
#mcp-academic-search
3. Retrieve abstract and DOI for each result via MCP tools.
4. Gather a small set of the most relevant sources.
5. Deduplicate overlapping hits.
6. Prioritize surveys or meta-analyses plus directly relevant primary studies.
7. Return concise source notes only.

**MCP fallback**: If MCP tools return errors or no results after an error has been reported, use webfetch or direct REST API calls for targeted searches. Document what was searched and what was found.

## Output format

### Header
- Question or claim being checked
- Search scope
- Coverage level: quick / moderate
- Limitations

### Per-source note
For each source, provide:

**Title**:
**Authors**:
**Year**:
**Venue**:
**DOI/URL**: real link or `<!-- TODO: verify -->`
**Source type**: empirical / review / meta-analysis / theory / preprint
**Claim or topic covered**:
**Overview**: 1-3 sentences
**Methods or basis**: brief description when available
**Evidence strength**: strong / moderate / weak / unclear
**Relevance**: why it matters for the current task
**Caveats**: uncertainty, missing metadata, or access limits

### Manuscript-ready notes

For multiple papers, after per-source notes include:
- Per reference: provisional citation key, 1–2 sentence summary, methods tag, relevance tag.
- Group by concept, method family, or role in argument.
- Suggest mapping onto planned sections where helpful.

## Style conventions

- Cautious academic tone; distinguish what authors claim from how strong the evidence is.
- Never fabricate design details or statistics; say when information is unclear.
- Clearly separate what papers claim from how strong their evidence is.
- Mark uncertain or missing details explicitly.

## PDF handling

If a paper or local PDF is provided:
- extract only the information you can verify from the file or landing page
- summarize the paper in the same per-source note format
- do not assume missing metadata from partial text

### PDF tools

- `pdftotext <file.pdf> -` — extract text to stdout for reading
- `pdfgrep -i -n "pattern" <file.pdf>` — search inside a PDF without
  converting; useful for locating specific claims, tables, or sections
  in long papers

## Guardrails

#research-guardrails
- Do not drift into long synthesis or manuscript-ready prose unless explicitly instructed.
- Quote source text minimally; prefer faithful summaries.
- Mark unclear details with `<!-- TODO: verify -->`.
#mcp-procurement-rule

## Handoff rule

If the request needs exhaustive coverage, disagreement mapping, or repeated search expansion, return the best notes gathered so far and recommend escalation to `deep-research`.
