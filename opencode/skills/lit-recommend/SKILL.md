---
name: lit-recommend
description: Recommend new papers for the local literature library. Use when the user asks to find papers to add to ~/lit, update their reading list, or expand a topic directory. This skill tells the agent HOW to judge relevance — it is NOT a Python script that blindly keyword-matches. The agent reads each candidate's title and abstract and decides whether it belongs.
---

# Literature Recommendation Workflow

Recommend new papers for a specific directory in the local literature
library (`~/lit`). Use OpenAlex MCP tools for discovery and your own
**semantic judgment** for relevance filtering.

## Core Rule

**You are the relevance filter.** A Python script can query APIs and
deduplicate DOIs, but only an LLM can read a title and abstract and
decide: *Does this paper belong in `discrim`, or is it a CS paper that
happened to match the keyword "bias"?*  Exercise that judgment
aggressively.  It is better to recommend 3 focused papers than 30
noisy ones.

---

## Phase 1: Understand the Directory

Before searching, learn what the directory is about:

1. **Read the generated index**: `~/lit/<dir>/_index.md` — lists every
   paper in the directory with title, year, author. Gives you the
   scope and year range.

2. **Check for hand-written notes**: Many directories have a `.md`
   file (e.g. `~/lit/dehuman/dehumanization.md`) with detailed
   annotations. These contain the user's own framing of the topic.

3. **Query the database** for top authors and year gaps:
   ```bash
   sqlite3 ~/lit/_index.db "SELECT first_author, COUNT(*) FROM papers WHERE directory='<dir>' GROUP BY first_author ORDER BY 2 DESC LIMIT 10"
   sqlite3 ~/lit/_index.db "SELECT MIN(year), MAX(year) FROM papers WHERE directory='<dir>'"
   ```

4. **Check the user's existing themes**: If the notes mention
   sub-topics (e.g. "mechanistic vs animalistic dehumanization"),
   those are your search anchors.

---

## Phase 2: Find Candidates

Use the OpenAlex MCP tools (`openalex_openalex_*`):

### By author
For each top author, find their recent works (last 3–5 years) that
match the directory's topic. Use `openalex_openalex_search_entities`
with author filter.

### By topic
Search for recent, highly-cited papers on the directory's topic. Use
natural language queries — NOT a single-broad-keyword dump.
```python
# Good (focused):
openalex_openalex_search_entities(
    entity_type="works",
    query="mechanistic dehumanization",
    filters={"publication_year": "2022-2026"},
    sort="-cited_by_count",
    per_page=20
)

# Bad (too broad):
openalex_openalex_search_entities(
    entity_type="works",
    query="computational social science artificial intelligence psychology",
    ...
)
```

### By citation graph
For the directory's most-cited papers, use
`openalex_openalex_get_citation_graph` to find works that cite them.
This catches papers the user might have missed.

### By reference extraction (optional, Python helper)
To find papers cited by the existing collection:
```bash
# Extract page 1 text and grep for citations
pdftotext -l 1 ~/lit/dehuman/Bastian_etal2013.pdf - | grep -oP 'et al\., \d{4}' | sort | uniq -c | sort -rn | head -20
```

---

## Phase 3: Judge Relevance (THE CRITICAL STEP)

For each candidate paper, **read the title and abstract** (OpenAlex
returns both). Evaluate:

| Criterion | Question |
|-----------|----------|
| **Topical fit** | Does this paper belong in THIS specific directory? |
| **Field alignment** | Is this social/personality/cognitive psychology (the user's field)? |
| **Value add** | Would this paper fill a gap in the existing collection? |
| **Not already present** | Check DOI against `_index.db`: `sqlite3 ~/lit/_index.db "SELECT COUNT(*) FROM papers WHERE doi='<doi>'"` |

### Mandatory rejections

**Reject immediately** if:
- The paper is from a completely different domain (CS/ML, medicine,
  neuroscience, economics — unless clearly relevant to the
  psychological topic)
- The title or abstract mentions no concepts from this directory
- The paper is already in the library (deduplicate by DOI)
- The paper is a conference abstract, corrigendum, or editorial

### For directories with subdirectories

If a directory has subdirectories (e.g. `discrim/illcor`,
`discrim/ageism`), recommend which subdirectory each paper should go
into.

---

## Phase 4: Report

Write recommendations to `~/lit/_recommendations.md`. Structure:

```markdown
# Literature Recommendations

Generated: <ISO timestamp>
Method: OpenAlex search + LLM relevance judgment
Source: ~/lit/_index.db (<N> papers indexed)

## <directory> (<N> existing)

**Top authors**: ...
**Themes from notes**: ...

### Open Access

1. **Title** (Year, cited N×)  
   Authors: ...
   DOI: ...
   Why: <1-sentence relevance justification>
   PDF: <oa_url>

### Paywalled (needs manual download)

1. **Title** (Year, cited N×)  
   Authors: ...
   DOI: ...
   Why: <1-sentence relevance justification>
   Landing: <doi_url>
```

---

## Phase 5: After User Downloads

When the user says they've added new PDFs:
```bash
litindex --update
```

This re-indexes only new/modified files and preserves manually-corrected
records (locked=1).
