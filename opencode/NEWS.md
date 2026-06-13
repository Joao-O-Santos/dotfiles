# NEWS — OpenCode Manuscript Workflow

Notable changes to the OpenCode configuration, agents, plugins, and related tooling. This file provides a narrative history of the project's evolution, from initial setup through the current multi-agent architecture.

---

## 2026-06-13 — Documentation sync and environment refinements

The README was comprehensively synced with the current configuration state. The Plannotator plugin, which had been added in April but never documented, now appears in the Key Features section with a description of its role in plan-based decision-making. The magic-context.jsonc example was updated to reflect the current deepseek-v4-pro models and the expanded configuration (memory block with git commit indexing, sidekick block). Model assignments now explicitly reference `set_models.sh` as the source of truth, with actual model names listed per agent. The `account.json` file was added to the denied files list in the permissions documentation.

Separately, the Plannotator data directory environment variable was added to shellrc, and the r-analysis agent received updates in the opencode+planner temp configuration, including refinements to its Makefile and skill documentation.

---

## 2026-06-11 — Model upgrades and writer autonomy

A round of model upgrades brought the Magic Context historian and dreamer to `deepseek-v4-pro`, replacing the previous qwen3.6-plus. Across the agent roster, models were upgraded and temperatures adjusted. The writer agent was empowered with more creative autonomy: the planner's Writer Instruction Packets (WIP) now specify paragraph purposes rather than pre-written topic sentences, and the writer is reframed as a "prose architect" with creative judgment in phrasing, paragraph construction, and transitions.

The `account.json` file was added to the read and external_directory deny lists, joining `auth.json` and `mcp_keys.sh` as protected credentials.

---

## 2026-04-27 — PDF tooling and model bumps

PDF tool guidance was added to the research and automation skills: agents can now use `pdftotext` and `pdfgrep` for PDF processing, and these tools were added to the global bash permissions allowlist. The historian and dreamer models were bumped to `qwen3.6-plus`.

---

## 2026-04-24–26 — Major refactor: Plannotator, snippets DRY, and config consolidation

This was a transformative period for the project. The **Plannotator plugin** (`@plannotator/opencode@latest`) was properly added to the plugin list with a `plan-agent` workflow, enabling agents to use `submit_plan` for structured planning decisions instead of the generic `question` tool. The planner agent was restructured with an explicit routing table, stop-loss limits, and Plannotator awareness.

**AGENTS.md** was dramatically slimmed from ~183 to ~45 lines. Agent-specific content was extracted into a system of shared snippets, reducing duplication and making updates easier to propagate. Ten new snippets were created for this purpose: `agents-ref`, `stop-loss-limits`, `routing-table`, `research-separation`, `checkpoint-schedule`, `git-workflow`, `read-style`, `mcp-tool-awareness`, `snippet-catalog`, and `plannotator-awareness`. All agent files were updated to reference these snippets instead of repeating inline boilerplate.

**Temperatures** were migrated from agent frontmatter to `opencode.json` per-agent configuration, and **per-agent `steps` limits** were added as structural backstops for loop prevention (e.g., planner=20, automation=30, writer=10). A commands directory was also added.

The opencode config itself was refactored, with `set_models.sh` introduced as the canonical source for model assignments, replacing inline model names in `opencode.json` with environment variable references.

---

## 2026-04-22–23 — MCP integration, Magic Context, and Git workflow hardening

This period saw the integration of **Model Context Protocol (MCP) servers** for academic research. Four MCP servers were configured: Context7 (docs/API reference lookup), Citecheck (bibliographic verification via Crossref), OpenAlex (structured scholarly metadata), and Semantic Scholar (paper retrieval and summaries). The literature-reviewer and deep-research agents adopted an MCP-first search strategy, with fallback to webfetch only when MCP tools fail.

The **Magic Context** plugin (`@cortexkit/opencode-magic-context`) was installed, replacing the built-in compaction system with cache-aware summarization and long-term memory. The `magic-context.jsonc` configuration file was created to specify historian and dreamer models.

A **build agent** was added for build/test tasks, and kimi-k2.5 was switched to k2.6 across agents. **GPG signing workflow** was formalized as a snippet and referenced in planner, automation, guard, and r-analysis agents.

**Git workflow** was hardened: commits now require explicit approval (deny by default, explicit ask for planner/automation/r-analysis), and the Git Workflow section was expanded with a solo-owner branch model and commit delegation rules. STYLE.md was updated to reduce custom styles to 3 `:::` markers.

A critical fix moved MCP servers from per-agent blocks to the top-level `mcp` object in `opencode.json`, which is where OpenCode actually registers them. Standalone pubmed MCP references were removed; medical/psychology coverage was reassigned to semantic-scholar (paperplain-mcp bundles PubMed + ArXiv + Semantic Scholar). Three new DRY snippets were added: `reviewer-collaboration`, `mcp-academic-search`, and `context-management-reduce`.

---

## 2026-04-21 — Editor agent and the Review → Edit → Write pipeline

The **editor agent** was added as a dedicated collation agent: it receives outputs from the three reviewers and sorts them into a chronological edit list. This formalized the Review → Edit → Write pipeline, with explicit input handling steps.

The **reviewers** (`reviewer-structure`, `reviewer-detail`, `copyeditor`) were changed from primary to subagent mode, reporting to the planner rather than operating independently. The **writer** was reframed as an instruction-following prose engine that receives Writer Instruction Packets (WIP) from the planner. The **planner** was given a non-negotiable prohibition: no prose writing, no file editing, no mutating shell commands — its role is purely orchestration.

The **apa7-refs** skill was added for APA 7th edition reference formatting. Snippets for anti-fabrication notices and reviewer collaboration rules were introduced, though some snippet usage was later reverted in favor of verbatim text.

---

## 2026-04-18–19 — Section skills, specialized reviewers, and snippets integration

This was a major architectural shift. The project moved from **paper-type skills** (empirical-paper, theoretical-paper) to **section-based skills** organized around manuscript components: `intro`, `lit-review-section`, `methods`, `results`, `discussion`, and `manuscript-workflow`. This made the system more modular and reusable across different paper types.

**Specialized reviewer agents** were created: `reviewer-structure` (big-picture critique), `reviewer-detail` (citations, conceptual clarity, argument issues), and `copyeditor` (prose, titles, paragraphs, sentences, words, markdown compliance). This replaced the single generic reviewer with a triangulated feedback system.

The **opencode-snippets** plugin was integrated, enabling synthetic examples to be injected into skills and agents via `#snippet-name` tags. A `tui.json` file was added for snippets plugin UI configuration. **Title and abstract** skills were added to round out the manuscript section coverage.

Agent and skill renames were performed for consistency: `lit-review` became `lit-review-section`, `literature-review` became `finding-refs`, and `literature-review` agent became `literature-reviewer`. README.md and CHANGELOG.md documentation were created.

---

## 2026-04-14–17 — Provider refactor and early iterations

The **model providers** were refactored: HuggingFace was replaced with OpenCode Go, Zen, and OpenRouter, reflecting a shift toward more reliable and performant providers. Multiple config iterations refined agent definitions, model assignments, and workflow logic. File references were updated to use explicit paths.

---

## 2026-04-06–10 — Initial setup and foundational architecture

The **OpenCode workflow files** were first added, establishing the multi-agent system for academic manuscript writing. The initial architecture included: planner (orchestrator), automation (shell/git execution), writer (manuscript drafting), guard (safety checkpoints), literature-review (academic search), deep-research (exhaustive evidence gathering), r-analysis (R/Quarto pipelines), and a generic reviewer.

The config was **consolidated** to establish automation as a primary agent and deep-research as a subagent, with model conflicts and fallbacks fixed. An OpenCode-first quota strategy was adopted. Critical bugs and structural issues from the initial workflow critique were addressed, including enabling edit permissions for automation and deep-research, granting guard read-only bash access, and adding workflow-state.json and checkpoints/ directory for state tracking.

The initial skill set included empirical-paper, theoretical-paper, literature-review, r-analysis-quarto, and automation-cli, each with their own STYLE.md and supporting files.
