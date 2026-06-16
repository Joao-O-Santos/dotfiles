# Command: Search Local Literature Library

Search the `~/lit` literature library using the SQLite index database.

## Quick Reference

**List papers in a topic:**
```bash
sqlite3 ~/lit/_index.db "SELECT filepath, year, first_author FROM papers WHERE directory='<topic>' ORDER BY year DESC LIMIT 20"
```

**Full-text search (FTS5):**
```bash
sqlite3 ~/lit/_index.db "SELECT filepath, title FROM papers_fts WHERE papers_fts MATCH '<query>' ORDER BY rank LIMIT 10"
```

**Search by year range:**
```bash
sqlite3 ~/lit/_index.db "SELECT filepath, title FROM papers WHERE directory='<topic>' AND year BETWEEN <start> AND <end>"
```

**Find by DOI:**
```bash
sqlite3 ~/lit/_index.db "SELECT filepath, title, year FROM papers WHERE doi LIKE '%<part-of-doi>%'"
```

**Browse index:**
```bash
cat ~/lit/_index.md
cat ~/lit/<topic>/_index.md
```

## Workflow

1. **Start broad** — check `~/lit/_index.md` for topic directories
2. **Filter by topic** — query the DB for papers in relevant directories
3. **FTS5 for keywords** — use full-text search for specific concepts
4. **Read the PDF** — use `pdftotext -l 3 <file> -` for quick preview
5. **Full-text grep** — use `pdfgrep -r "phrase" ~/lit/<dir>/` for precise matches

## When to Use Local vs. MCP

| Feature | Local (`_index.db`) | MCP (OpenAlex/S2) |
|---------|---------------------|-------------------|
| Speed | Instant | 1-3s per query |
| Coverage | Your curated collection (~1.5K) | 270M+ works |
| Depth | PDF available on disk | Abstract + metadata only |
| Accuracy | Metadata from PDF extraction | Publisher-verified metadata |

**Use local first**, then expand with MCP tools when the local collection doesn't cover the topic.
