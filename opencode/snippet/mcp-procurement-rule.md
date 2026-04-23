# MCP Procurement Rule

When MCP tools are available, retrieve abstract and DOI for every paper. Do not mark DOIs as `<!-- TODO: verify -->` when the MCP has returned a real DOI.

If MCP tools are not responding or return tool-not-found errors, report the failure to the planner immediately so the top-level `opencode.json` configuration can be verified. Do not assume MCPs are absent and silently fall back to web search without documenting the failure.
