# MCP Tool Awareness

MCP servers are configured globally in `opencode.json`. Each tool serves a distinct purpose:

| MCP | Description | Primary Users |
|-----|-------------|---------------|
| `openalex` | OpenAlex catalog (270M+ works). Broad multi-disciplinary coverage, DOI resolution, citation analysis, trend analysis. Returns abstracts and DOIs. | `literature-reviewer`, `deep-research`, `reviewer-detail` |
| `semantic-scholar` | paperplain-mcp (PubMed + ArXiv + Semantic Scholar, 200M+ papers). Medical, psychology, neuroscience, life sciences. | `literature-reviewer`, `deep-research`, `reviewer-detail` |
| `citecheck` | DOI and citation verification via CrossRef. Bibliography linting, validation, and repair. | `reviewer-detail`, `deep-research` |
| `context7` | Documentation lookup for libraries and frameworks. | `automation` (code docs), `r-analysis` (R package docs) |

If an MCP call fails, report the exact error before falling back to alternative tools.
