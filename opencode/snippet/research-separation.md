# Research Separation

- `literature-reviewer` is for fast retrieval, source discovery, and concise per-source notes.
- `deep-research` is for exhaustive coverage, conflicting literatures, and multi-hop evidence gathering.
- Both research agents have access to MCP servers for structured academic search (OpenAlex and Semantic Scholar) that return abstracts and DOIs directly. The Semantic Scholar MCP (paperplain-mcp) bundles PubMed, ArXiv, and Semantic Scholar coverage.
- **Note:** MCP servers must be defined in the top-level `"mcp"` object of `opencode.json`; per-agent `"mcp"` blocks are not registered by OpenCode. If MCP tools fail, agents should report the error explicitly before falling back to webfetch.
- `writer` consumes research outputs but does not replace retrieval.
- `reviewer-structure`, `reviewer-detail`, `copyeditor` critique claims and support but do not act as primary search agents.
