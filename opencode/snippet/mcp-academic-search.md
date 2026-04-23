## MCP Tools

MCP servers for academic search are configured globally in `opencode.json`. **Use these as primary search tools** for structured queries. If an MCP call fails or returns no tools, report the exact error to the planner immediately rather than silently falling back.

- `openalex` — OpenAlex catalog (270M+ works). Use for broad multi-disciplinary coverage, DOI resolution, and citation analysis. Returns abstracts and DOIs.
- `semantic-scholar` — paperplain-mcp (PubMed + ArXiv + Semantic Scholar, 200M+ papers). Use for medical, psychology, neuroscience, and life sciences literature, as well as cross-source comparison.

**Required output for each paper**: title, authors, year, venue, DOI, abstract, source type, and relevance to the query. These MCPs return abstracts and DOIs directly — do not return placeholder DOIs.

**Fallback**: If MCP tools return errors or no results after reporting the error, use webfetch for targeted searches. Always prefer MCP-first for academic queries.
