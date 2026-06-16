# Local Literature Index

The `~/lit` directory has a structured index for agent-navigable search:

## Files

- **`~/lit/_index.md`** — top-level overview of all topic directories
- **`~/lit/<topic>/_index.md`** — per-directory table of papers (title, year, author, size)
- **`~/lit/_index.db`** — SQLite database for structured queries (1.5K papers, 22 topics)
- **Existing `~/lit/<topic>/*.md`** — hand-written detailed notes (preserved)

## SQLite Queries

List all papers in a topic:
```bash
sqlite3 ~/lit/_index.db "SELECT filepath, year, first_author FROM papers WHERE directory='dehuman' ORDER BY year DESC LIMIT 20"
```

Search by year range:
```bash
sqlite3 ~/lit/_index.db "SELECT filepath, title FROM papers WHERE directory='discrim' AND year BETWEEN 2015 AND 2020"
```

Full-text search (FTS5):
```bash
sqlite3 ~/lit/_index.db "SELECT filepath, title FROM papers_fts WHERE papers_fts MATCH 'dehumanization AND prejudice' ORDER BY rank LIMIT 10"
```

Count papers per directory:
```bash
sqlite3 ~/lit/_index.db "SELECT directory, COUNT(*) FROM papers GROUP BY directory ORDER BY 2 DESC"
```

## Re-indexing

The index is regenerable. Run from `~/lit`:
```bash
python3 ~/lit/_index.py            # full re-index
python3 ~/lit/_index.py --update   # incremental (only changed files)
python3 ~/lit/_index.py --dir X    # re-index one directory
python3 ~/lit/_index.py --stats    # show stats
```

## Limitations

- Title extraction: ~95% accurate
- Year extraction: ~75% accurate (filename is more reliable when present)
- Abstract extraction: ~30% accurate (some journals bury abstracts mid-page)

For PDFs where extraction failed, use:
- `pdftotext -l 1 <file>` — first page text
- `pdfgrep -r "term" <dir>/` — full-text search inside PDFs
