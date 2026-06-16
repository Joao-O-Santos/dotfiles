---
name: lit-alert
description: Personalized new-paper notification for the local literature library. Like Google Scholar alerts but for ~/lit — checks for recent papers by the user's authors on the user's topics. Use when the user asks to "check for new papers," "what's new in my fields," or runs the lit-alert command. Load this skill before doing topic/author-based incremental literature searches.
---

# Lit-Alert: Personalized New-Paper Notification

Like Google Scholar alerts for your local library. Check for papers by
*your* authors on *your* topics, published since the last check.

## State

Track the last-check timestamp in `~/lit/_last_check`:

```
2026-06-16T16:00:00Z
```

If the file doesn't exist, default to 6 months ago:
```python
from datetime import datetime, timezone, timedelta
default = (datetime.now(timezone.utc) - timedelta(days=180)).strftime("%Y-%m-%dT%H:%M:%SZ")
```

---

## Phase 1: Read State

1. Read `~/lit/_last_check` to get the cutoff date, or default to
   6 months ago.
2. For each top-level directory in `~/lit/` (skip `other`, `hist`,
   `bio` — too small/unfocused):
   - Query top 5 authors:
     ```
     SELECT first_author, COUNT(*) FROM papers WHERE directory='<dir>' GROUP BY 1 ORDER BY 2 DESC LIMIT 5
     ```
   - Note the directory's theme from `~/lit/_index.md` and any
     hand-written `.md` notes.

---

## Phase 2: Search (OpenAlex MCP)

For each directory, run these OpenAlex searches — all filtered to
`publication_year` >= the year from `_last_check`:

### By author
For each top author:
```
openalex_openalex_search_entities(
    entity_type="works",
    query="<author name>",
    filters={"publication_year": "<cutoff_year>-<current_year>"},
    sort="-cited_by_count",
    per_page=10
)
```

### By topic
```
openalex_openalex_search_entities(
    entity_type="works",
    query="<directory theme keyword>",
    filters={"publication_year": "<cutoff_year>-<current_year>"},
    sort="-cited_by_count",
    per_page=20
)
```

Use specific, narrow queries — NOT broad keyword dumps. For
`dehuman`, search `"dehumanization"`. For `discrim`, search
`"prejudice discrimination"`.

---

## Phase 3: Judge Relevance

For each candidate, **read the title and abstract**. Reject if:

- The paper is from a different domain (e.g., CS/ML papers for
  psychology-related directories)
- The paper is already in `_index.db` (check by DOI)
- The title or abstract shows no connection to the directory's theme
- The paper is a conference abstract, corrigendum, or editorial

It is better to report 2-3 high-quality matches than 20 noisy ones.

---

## Phase 4: Report

Write to `~/lit/_alert.md`:

```markdown
# Literature Alert

Since: <_last_check timestamp>
Checked: <now>

## <directory> (<N> existing papers)
**Searched authors**: <top 5>
**New since last check**: <M> candidates found, <K> relevant

### Open Access
1. **Title** (Year, cited N×)
   Authors: ...
   DOI: ...
   PDF: <oa_url>

### Paywalled (needs manual download)
1. **Title** (Year, cited N×)
   Authors: ...
   DOI: ...
   Landing: <doi_url>
```

Only include directories that have at least one relevant candidate.
If nothing new was found for a directory, skip it — don't generate
an empty section.

---

## Phase 5: Update State

Write the current timestamp to `~/lit/_last_check`:

```
2026-06-16T17:00:00Z
```

---

## After User Downloads New PDFs

```
cd ~/lit && litindex --update
```
