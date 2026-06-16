# Command: Recommend Papers for Literature Library

Recommend new papers to add to a specific directory in `~/lit/`.

## Quick Start

```
@literature-reviewer recommend papers for dehuman
```

Or more explicitly:
```
@literature-reviewer find recent papers (2022–2026) on dehumanization that are not already in ~/lit/dehuman/
```

## How It Works

The agent will:
1. Read `~/lit/<dir>/_index.md` and any hand-written `.md` notes to understand what the directory covers
2. Query `~/lit/_index.db` for top authors and year range
3. Use OpenAlex MCP tools to search by author, topic, and citation graph
4. **Judge each candidate's relevance** by reading title and abstract
5. Output a curated recommendation list to `~/lit/_recommendations.md`

## Example Invocations

```
@literature-reviewer find 10 recent papers on dehumanization I should add to ~/lit
@deep-research do a comprehensive sweep of the discrim directory for missing papers
find new papers on construal level theory, focus on 2023–2026, prefer open access
```

## After Downloading

```bash
cd ~/lit && litindex --update
```
