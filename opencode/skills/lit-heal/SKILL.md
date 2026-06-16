---
name: lit-heal
description: Audit and fix metadata errors in the local literature database.
  Use when the indexer produces garbled titles (journal names, watermarks,
  boilerplate), missing DOIs, or wrong years. Load this skill before scanning
  and correcting lit/_index.db entries. The mechanical indexer (litindex) does
  its best, but only an LLM can look up real metadata via OpenAlex and judge
  whether a title is correct.
---

# Lit-Heal: Audit and Fix the Literature Database

**⚠️ DO NOT use `_heal.py`, `_fix_all.py`, or any mechanical fixer
script.** These scripts cannot distinguish between a paper's own DOI and
DOIs cited in its reference list. They produce wrong titles (journal
names, watermarks) and wrong DOIs. Only an LLM reading the paper's
actual text can do this correctly.


## Cardinal Rule: Filename Authority

Filenames are authoritative for `first_author` AND `publication_year`.
Do NOT change `year` or `first_author`. The user named these files by
hand. You correct `title` and `doi` only.


## Phase 1: Extract First Pages

```bash
pdftotext -l 5 ~/lit/<dir>/<file> -
```

Five pages captures the full abstract and enough introduction to confirm
the paper's identity, while staying clear of the reference list.


## Phase 2: Read and Identify Real Metadata

Read the text. Identify two things:

**The real title** — the first sentence-case line >30 chars that is NOT
a journal name, watermark, ALL-CAPS running head, or boilerplate. It
appears near the top of page 1, after any journal header but before the
abstract, in normal sentence or title case.

**The paper's own DOI** — in the header or footer of page 1, as
`doi:10.xxxx/yyyy`, `https://doi.org/10.xxxx/yyyy`, or bare
`10.xxxx/yyyy`. Do NOT use DOIs from the reference list.

### Common Garbage Patterns

When you see any of these, the record needs fixing.

**Journal names mistaken for titles:**
- "Journal of Personality and Social Psychology"
- "European Journal of Social Psychology"
- "Organizational Behavior and Human Decision Processes 151 (2019) 90–103"
- "Telematics and Informatics 77 (2023) 101925"

**Watermarks / boilerplate:**
- "Available online at www.sciencedirect.com"
- "Downloaded from http://direct.mit.edu/..."
- "See discussions, stats, and author profiles for this publication at:
  https://www.researchgate.net/..."
- "Contents lists available at ScienceDirect"

**Publisher artifacts:** "research-article2018", "research-article2021"

**ALL-CAPS running heads** from journals (page headers, not titles).

**Copyright lines** containing "Copyright", "©", or "All rights reserved".

**Institutional strings:** "University of Minnesota", "HHS Public
Access", "Author manuscript; available in PMC"


## Phase 3: Verify via OpenAlex (If DOI Found)

If you found a DOI candidate, verify immediately:

```
openalex_openalex_search_entities(
    entity_type="works",
    id="https://doi.org/10.xxxx/yyyy"
)
```

Compare the returned `display_name` against the real title. If they
don't match, the DOI belongs to a cited paper — discard it. If no DOI
was found on the paper, skip this phase.


## Phase 4: Apply Fix via Direct SQL

Use raw `sqlite3` — do NOT use `litfix` or any wrapper tool.

```bash
sqlite3 ~/lit/_index.db "UPDATE papers SET title='<real title>', doi='<real doi>', locked=1, indexed_at=datetime('now') WHERE filepath='<full path>';"
```

Without a DOI, omit the `doi` assignment:

```bash
sqlite3 ~/lit/_index.db "UPDATE papers SET title='<real title>', locked=1, indexed_at=datetime('now') WHERE filepath='<full path>';"
```

**Escape single quotes** by doubling them (`''`): `SET title='Don''t Show'`.

`locked=1` in the UPDATE locks the record atomically. To unlock a
mistake:

```bash
sqlite3 ~/lit/_index.db "UPDATE papers SET locked=0 WHERE filepath='<full path>';"
```


## Phase 5: Re-index

```bash
python3 ~/lit/_index.py
```


## Audit Queries — Find Bad Entries

Run before and after healing to measure progress.

### Suspicious titles
```sql
SELECT filepath, title, doi, year
FROM papers
WHERE title IS NOT NULL
  AND (
    title GLOB '*Journal of*'
    OR title GLOB '*Psychological Review*'
    OR title GLOB '*Annual Review*'
    OR title GLOB '*Available online*'
    OR title GLOB '*Downloaded from*'
    OR title GLOB '*See discussions*'
    OR title GLOB '*research-article*'
    OR title GLOB '*Copyright*'
    OR title GLOB '*Published by*'
    OR title GLOB '*University of*'
    OR title = upper(title)
    OR length(title) < 15
  )
  AND locked = 0
LIMIT 50;
```

### Missing DOIs
```sql
SELECT filepath, title, year, first_author
FROM papers
WHERE (doi IS NULL OR doi = '')
  AND locked = 0
LIMIT 50;
```

### Missing titles entirely
```sql
SELECT filepath, doi, year, first_author
FROM papers
WHERE (title IS NULL OR title = '')
  AND locked = 0
LIMIT 50;
```


## Report Phase

After the healing run, output a summary:

```
Lit-Heal Summary
================
Audited: <N> records
Garbage titles found: <N>
Missing DOIs: <N>
Fixed via DOI lookup + OpenAlex verification: <N>
Fixed via direct title extraction from PDF: <N>
Could not fix: <N>
```

List unfixable records with filepaths so the user can inspect manually.
