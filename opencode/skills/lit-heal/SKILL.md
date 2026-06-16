---
name: lit-heal
description: Audit and fix metadata errors in the local literature database. Use when the indexer produces garbled titles (journal names, watermarks, boilerplate), missing DOIs, or wrong years. Load this skill before scanning and correcting lit/_index.db entries. The mechanical indexer (litindex) does its best, but only an LLM can look up real metadata via OpenAlex and judge whether a title is correct.
---

# Lit-Heal: Audit and Fix the Literature Database

The mechanical indexer (`_index.py`) extracts titles from PDF first pages
and often produces garbage: journal names ("Journal of Personality and
Social Psychology"), watermarks ("Available online at sciencedirect.com"),
boilerplate ("research-article2018"), or ALL-CAPS page headers. This
skill instructs you to **audit** the database for these errors and **fix**
them using OpenAlex and direct title extraction.

---

## Phase 1: Run the Indexer

```bash
litindex --update
```

This picks up any new PDFs and refreshes file metadata. Locked records
(`locked=1`) are preserved.

---

## Phase 2: Audit — Find Bad Entries

Query the database for records with suspect metadata.

### Suspicious titles
```sql
-- Journal names, watermarks, boilerplate in title field
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
    OR title = upper(title)     -- ALL CAPS, likely journal header
    OR length(title) < 15        -- too short to be real
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

---

## Phase 3: Fix Each Bad Entry

For each bad record, try these strategies in order:

### Strategy A: Look up by DOI (fastest, most reliable)
```
openalex_openalex_search_entities(
    entity_type="works",
    id="https://doi.org/10.xxxx/yyyy"
)
```

Extract: title, publication_year, first author. Apply via:
```bash
litfix --file "<filename>" --title "<real title>" --year <year> --doi "<doi>"
```

### Strategy B: Re-extract from PDF (if DOI missing)
```bash
# Extract more of the first page to find the title
pdftotext -l 2 ~/lit/<dir>/<file> - | head -80
```

Read the output and identify the real title. Often it's on line 2-4
of the first page, after a journal-name header. Apply via litfix.

### Strategy C: Search OpenAlex by filename
```bash
# Parse author + year from filename and search
openalex_openalex_search_entities(
    entity_type="works",
    query="<first_author> <year> <topic keywords>",
    per_page=5
)
```

Read candidate titles/abstracts and pick the best match.

---

## Phase 4: Apply and Lock

After each fix, the record is automatically locked (`litfix` sets
`locked=1`). This prevents future `litindex --update` runs from
overwriting your manually-corrected metadata.

To unlock a record (if you made a mistake):
```bash
litfix --file "<filename>" --unlock
```

---

## Report Phase

After the healing run, output a summary:

```
Lit-Heal Summary
================
Audited: <N> records
Garbage titles found: <N>
Missing DOIs: <N>
Fixed via DOI lookup: <N>
Fixed via re-extraction: <N>
Fixed via OpenAlex search: <N>
Could not fix: <N>
```

For records you could not fix, list them with filepaths so the user
can manually inspect.

---

## Re-index After Healing

```bash
litindex --update
```

This refreshes the markdown indexes with corrected metadata.
