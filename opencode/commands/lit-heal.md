# Command: Heal Literature Database

Audit and fix metadata errors in `~/lit/_index.db`.

## Quick Start

```
lit-heal
```

Runs the mechanical indexer, then an LLM agent audits the database for
garbage titles, missing DOIs, and wrong years, fixing them via OpenAlex.

## How It Works

1. Runs `litindex --update` to pick up any new PDFs
2. Queries `_index.db` for suspicious records:
   - Titles that are journal names ("Journal of Personality and Social Psychology")
   - Titles that are watermarks ("Available online at sciencedirect.com")
   - Titles in ALL CAPS (page headers)
   - Missing or NULL DOIs
   - Missing titles
3. For each bad record, fixes it by:
   - DOI lookup via OpenAlex (fastest)
   - Re-extracting title from PDF text (fallback)
   - OpenAlex search by author+year (if no DOI)
4. Applies fixes via `litfix` and locks corrected records
5. Re-indexes to refresh `_index.md` files

## When to Run

- After adding a batch of new PDFs
- When you notice garbled titles in `_index.md`
- Periodically to clean up the database

## Scope

- `@literature-reviewer` handles fast healing (single directory, few records)
- `@deep-research` handles exhaustive healing (full library sweep)
