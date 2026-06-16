# Command: Literature Alert

Check for new papers by your authors on your topics since the last check.

## Quick Start

```
lit-alert
```

Runs a personalized new-paper notification across all topic directories
in `~/lit/`. Like Google Scholar alerts for your local library.

## How It Works

1. Reads `~/lit/_last_check` (or defaults to 6 months ago)
2. For each topic directory, queries your top authors and themes via OpenAlex
3. Judges each candidate's relevance by reading title/abstract
4. Outputs `~/lit/_alert.md` with relevant new papers
5. Updates `_last_check` for the next run

## What It Checks

- New papers by **your top 5 authors** in each directory
- Recent high-impact papers on **your topics**
- Filtered to papers published since the last check
- Deduplicated against your existing library

## After Downloading

```bash
cd ~/lit && litindex --update
```
