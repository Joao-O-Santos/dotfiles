---
name: literature-review
description: Use when searching for, fetching, or summarising research articles and related work to support manuscript writing.
---

# Skill: literature-review

Conduct targeted literature searches and synthesise reference-backed summaries
for empirical and theoretical papers.

## Tools

- Web/online search capabilities of the current model.
- When running on `openrouter/perplexity/sonar`, prefer it for deep academic queries
  because it has built-in web search.
- CLI fallbacks: `curl`/`wget` to download open-access PDFs; `pdftotext` to extract text.

## Sub-workflows

### 1. Topic search
- Search academic sources (preprint servers, repositories, journals).
- Record: title, authors, year, venue, DOI/URL, abstract.
- De-duplicate; prefer recent surveys and meta-analyses plus key primary sources.
- Return: (a) short narrative overview, (b) structured reference list.

### 2. Specific paper
- Resolve open-access PDF; fall back to abstract + landing page.
- Summarise: 1–3 sentence overview, methods snapshot, main findings, relevance to project.
- For multiple papers: per-paper summaries + synthesis paragraph.
- **Abstract verbatim rule**: When full abstract is available, append it verbatim under the summary rather than paraphrasing. Only paraphrase when abstract is unavailable, behind paywall, or excessively long.

### 3. Manuscript-ready notes
- Per reference: provisional citation key, 1–2 sentence summary, methods tag, relevance tag.
- Group by concept, method family, or role in argument.
- Suggest mapping onto planned sections where helpful.

### 4. PDF ingestion
- Accept a directory or list of PDF files as input.
- For each PDF:
  - Run `pdftotext <file> -` to extract full text.
  - Parse: title (from first page header or metadata), authors, year (from header/metadata), abstract block (typically after "Abstract" heading).
  - Output same format as sub-workflow 2: title, authors, year, abstract (verbatim), 1–3 sentence overview, methods snapshot, main findings, relevance.
- Return: per-paper summaries in sub-workflow 2 format (can be piped to sub-workflow 3 for grouping).
- **Abstract verbatim rule applies**: Always preserve original abstract when available.

## Style

- Cautious academic tone; distinguish what authors claim from how strong the evidence is.
- Never fabricate design details or statistics; say when information is unclear.

## Guardrails

- Do not bypass paywalls.
- Do not merge distinct papers into one summary.
- Be explicit about uncertainty or missing information.
