# Command: Re-index Literature Library

Update the `~/lit` literature library index.

## Commands

**Full re-index (all 1,500+ papers):**
```bash
python3 ~/lit/_index.py
```

**Incremental update (only new or modified files):**
```bash
python3 ~/lit/_index.py --update
```

**Re-index one directory:**
```bash
python3 ~/lit/_index.py --dir <topic>
```

**Show stats:**
```bash
python3 ~/lit/_index.py --stats
```

## When to Re-index

- After adding new PDFs to `~/lit/<topic>/`
- After moving PDFs between directories
- When the database seems stale
- When metadata extraction improves (new script version)

## What Gets Indexed

- **Title** — extracted from first-page text (~95% accurate)
- **Year** — from filename + first-page text (~75% accurate)
- **First author** — parsed from filename convention (`AuthorYear.pdf`)
- **DOI** — `10.xxxx/...` pattern from first-page text
- **Abstract** — first 500 chars from "Abstract" section (~30% accurate)
- **File size** — from filesystem

## Index Files

- `~/lit/_index.db` — SQLite database with FTS5 full-text search
- `~/lit/_index.md` — top-level overview
- `~/lit/<topic>/_index.md` — per-directory paper tables
- `~/lit/_index_errors.log` — extraction failures (transient, gitignored)

## Limitations

- Title/abstract extraction depends on `pdftotext` quality
- Some journals bury abstracts mid-page (low extraction rate)
- Corrupt/encrypted PDFs are skipped with error logging
- Existing hand-written `.md` notes are NEVER modified
