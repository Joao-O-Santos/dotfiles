# Changelog — OpenCode Manuscript Workflow

All notable changes to the OpenCode configuration will be documented in this file.

## [2026-06-16] — Agent-editable DB, recommendation script, changelog fixes

### Added
- `_index.py --update` now skips locked (manually-edited) records via `locked` column
- `litfix.sh` + `litfix` alias: agent command to fix individual metadata fields in the DB
- `_recommend.py`: queries OpenAlex for candidate papers, outputs `_recommendations.md`
- `_recommendations.md`: generated report with OA/paywalled papers split by directory

### Changed
- `~/lit/.gitignore`: added `__pycache__/`, `*.db-shm`, `*.db-wal`
- All missing CHANGELOG entries added (v6.12.1, v6.10.1, v6.10.0, v6.9.1 in .config; v0.2.0 in lit)

## [2026-06-16] — Agent capabilities, Plannotator handling, and DOI extraction

### Added
- `AGENTS.md` now includes Agent Capabilities section (edit/bash/commit/push permissions summary) and Delegation Guide (which agent for which task type)
- New `commands/lit-search.md` — agent guide for searching the local literature library
- New `commands/lit-index.md` — agent guide for re-indexing the literature library
- `lit-index` snippet expanded: DOI search query and full metadata retrieval

### Changed
- `plannotator-awareness` snippet: added explicit Plannotator feedback processing rules (approved with annotations → revise first; clean approval → delegate, not self-implement)
- `planner.md`: reinforced delegation rule for plan approval — "Proceed with implementation" means launch agents, not execute yourself
- `_index.py` now extracts DOIs from PDFs (`10.xxxx/...` pattern); `doi` column added to DB schema

### Fixed
- Planner no longer confused by Plannotator's default "Proceed with implementation" prompt — now correctly delegates instead of attempting self-execution

## [2026-06-16] — Literature library indexer

New indexing system for `~/lit` (~1,529 PDFs across 22 topics):

- **`~/lit/_index.py`** — Python script (stdlib only) that scans all PDFs, extracts title/year/author/abstract via `pdftotext -l 1`
- **`~/lit/_index.db`** — SQLite database with FTS5 full-text search
- **`~/lit/_index.md`** — top-level index with quick-reference table
- **`~/lit/<topic>/_index.md`** — per-directory paper tables
- Existing hand-written `.md` notes preserved unchanged

### Added
- New snippet `lit-index` documents the local index, SQLite queries, and limitations
- `literature-reviewer` and `deep-research` agents now know about the local index

### Limitations
- Year extraction ~75% accurate (filename year is more reliable)
- Abstract extraction ~30% accurate (some journals bury abstracts mid-page)

## [2026-06-13] — Config audit fixes, shell script refactoring, and DRY improvements

Comprehensive audit identified broken references, orphaned files, permission contradictions, and hardcoded paths. Fixed all issues and refactored shell functions into standalone scripts with comprehensive test coverage.

### Fixed
- Broken snippet reference in `apa7-refs/SKILL.md` (note-on-examples → examples-disclaimer)
- Missing YAML frontmatter in `abstract/SKILL.md` and `title/SKILL.md` (skills now discoverable)
- Planner permission contradiction: removed direct commit permission, now delegates to automation
- Removed unnecessary planner checkpoint rule (reviewers read files, don't need git state)
- Deleted redundant `opencode/.gitignore` (top-level `.gitignore` already handles everything)

### Changed
- Planner now delegates git commits to automation agent (cleaner separation of concerns)
- `gpg-signing-workflow.md` updated: planner barred from committing, automation handles all commits
- Orphaned skills (`manuscript-workflow`, `lit-review-section`) added to planner WIP skill selection guidance
- R coding conventions consolidated: `coding_style.md` is single source of truth, removed duplicates from `SKILL.md`
- Reviewer agents now use shared `reviewer-output-format` snippet (DRY)
- Hardcoded paths parameterized with `$HOME` in `read-style.md` and `agents-ref.md`
- Magic-context models moved to `set_models.sh` as env vars (`HISTORIAN_MODEL`, `DREAMER_MODEL`, `SIDEKICK_MODEL`)
- `magic-context.jsonc` now uses `{env:VAR}` syntax for model names

### Added
- New shared snippet: `reviewer-output-format.md` (standardizes reviewer output structure)
- 10 standalone shell scripts in `~/.config/scripts/` with proper error handling and input validation
- Comprehensive test suite (`test_scripts.sh`) with 27 tests covering existence, usage, validation, and functionality
- `shellrc` refactored: functions extracted to scripts, scripts added to PATH, alias wrappers created

### Removed
- 4 orphaned snippets: `read-for-context.md`, `our-approach.md`, `hamburger-paragraph.md`, `topic-sentence-outline.md`
- Duplicate R formatting rules from `r-analysis-quarto/SKILL.md`
- Inline shell functions from `shellrc` (moved to standalone scripts)

## [2026-06-13] — Documentation sync and environment refinements

README was comprehensively synced with current config state. Plannotator plugin documented in Key Features. Magic-context example updated to reflect current models and expanded config. Model assignments now reference `set_models.sh` with actual model names per agent.

### Added
- Plannotator plugin documented in README Key Features and plugin example
- `account.json` added to denied files list in README permissions section

### Changed
- README magic-context.jsonc example updated (deepseek-v4-pro, memory block with git_commit_indexing, sidekick block)
- README model assignments section now references `set_models.sh` as source of truth with actual model names
- Plannotator data directory environment variable added to shellrc
- r-analysis agent updated in opencode+planner temp config (Makefile and skill docs)

## [2026-06-11] — Model upgrades, writer autonomy, account.json lockdown

Writer empowered with more creative autonomy: WIP specifies paragraph purposes instead of pre-written topic sentences; writer reframed as "prose architect" with creative judgment in phrasing, paragraph construction, and transitions.

### Changed
- Magic Context historian and dreamer models upgraded to `deepseek-v4-pro`
- Model assignments upgraded across agents; temperatures adjusted
- `account.json` added to read/external_directory deny list alongside `auth.json` and `mcp_keys.sh`

## [2026-04-27] — PDF tooling and model bumps

### Added
- PDF tool guidance (`pdftotext`, `pdfgrep`) in research and automation skills
- `pdfgrep` added to global bash permissions alongside `pdftotext`

### Changed
- Historian/dreamer models bumped to `qwen3.6-plus`

## [2026-04-24–26] — Major refactor: Plannotator, snippets DRY, config consolidation

Transformative period: Plannotator plugin added for plan-based decisions, AGENTS.md slimmed from ~183 to ~45 lines via snippet extraction, temperatures and steps limits moved to opencode.json, and `set_models.sh` introduced as canonical model source.

### Added
- Plannotator plugin (`@plannotator/opencode@latest`) with `plan-agent` workflow — agents use `submit_plan` for structured planning instead of `question` tool
- New snippets: `agents-ref`, `stop-loss-limits`, `routing-table`, `research-separation`, `checkpoint-schedule`, `git-workflow`, `read-style`, `mcp-tool-awareness`, `snippet-catalog`, `plannotator-awareness`
- Per-agent `steps` limits as hard structural backstops for loop prevention (planner=20, automation=30, writer=10, reviewer-structure=10, reviewer-detail=10, copyeditor=10, editor=8, guard=10, literature-reviewer=12, deep-research=20, r-analysis=30)
- Plannotator awareness in planner config
- citecheck and context7 MCP awareness in relevant agents
- Commands directory

### Changed
- AGENTS.md slimmed from ~183 to ~45 lines; all agent-specific content extracted into snippets
- planner.md restructured with explicit routing table, edge-case decision tree, snippet catalog, Plannotator awareness, "When NOT to delegate" section, and research separation
- All agent files updated with snippet references replacing inline boilerplate
- Skills updated to use `mcp-academic-search` snippet for MCP tool descriptions
- Routing constraints relaxed: built-in agents (`@explore`, `@general`, `@build`) allowed for tasks outside manuscript workflow scope (but still prohibited for workflow tasks)
- Edge-case routing refined: "fix a citation" → literature-reviewer then reviewer-detail; "improve this section" → all three reviewers then editor; "check the stats" → r-analysis + reviewer-detail; no-match → ask user or use built-ins (never `@plan`)
- Git workflow snippet includes rebase rule: when `refactor` is behind `main`, rebase onto `main` before merging
- Temperatures migrated from agent frontmatter to `opencode.json` per-agent config
- `set_models.sh` introduced as canonical source for model assignments, replacing inline model names with environment variable references

### Deleted
- `note-on-examples.md` snippet (merged into `examples-disclaimer`)

## [2026-04-22–23] — MCP integration, Magic Context, Git workflow hardening

Four MCP servers configured for academic research (Context7, Citecheck, OpenAlex, Semantic Scholar). Magic Context plugin installed replacing built-in compaction. Git workflow hardened with explicit commit approval. Critical fix: MCP servers moved from per-agent blocks to top-level `mcp` object where OpenCode actually registers them.

### Fixed
- MCP servers moved from per-agent blocks to top-level `"mcp"` object in `opencode.json` so OpenCode actually registers them
- README.md corrected MCP server attachment description from "per-agent" to "top-level object"

### Added
- MCP servers: Context7 (docs/API reference), Citecheck (bibliographic verification via Crossref), OpenAlex (structured scholarly metadata), Semantic Scholar (paper retrieval and summaries)
- Magic Context plugin (`@cortexkit/opencode-magic-context`) with `magic-context.jsonc` — replaces built-in compaction with cache-aware summarization and long-term memory
- Node.js and npm installed to support npx-based MCP servers
- New snippets: `reviewer-collaboration`, `mcp-academic-search`, `context-management-reduce` to DRY repeated text across agent files
- `mcp-procurement-rule` snippet to DRY procurement guidelines
- GPG signing workflow snippet referenced in planner, automation, guard, and r-analysis agents
- `build` agent (primary) for build/test tasks
- `gpgwarm` shell alias for GPG agent warm-up

### Changed
- MCP-first search strategy adopted for literature-reviewer and deep-research agents (fallback to webfetch only when MCP tools fail)
- Research agent instructions updated to report MCP errors explicitly before falling back to webfetch
- Removed standalone `pubmed` MCP references; medical/psychology coverage reassigned to `semantic-scholar` (paperplain-mcp bundles PubMed + ArXiv + Semantic Scholar)
- Replaced inline collaboration rules in reviewer/editor agents with `reviewer-collaboration` snippet
- Replaced inline MCP tool sections in research agents with `mcp-academic-search` snippet
- Replaced inline context-management sections in research agents with `context-management-reduce` snippet
- Replaced inline placeholder discipline in AGENTS.md with `placeholder-discipline` snippet
- `editor` mode changed from `primary` to `subagent` (reports to planner)
- Updated default model for planner/automation/r-analysis from `kimi-k2.5` to `kimi-k2.6`
- Git commit rules: commits require explicit approval; only planner/automation/r-analysis may commit
- Expanded Git Workflow section with solo-owner branch model
- STYLE.md updated: custom styles reduced to 3 `:::` markers

## [2026-04-21] — Editor Agent & Workflow Refactor

Formalized the Review → Edit → Write pipeline. Editor agent added as dedicated collation agent. Reviewers changed to subagent mode. Writer reframed as instruction-following prose engine. Planner given strict non-negotiable prohibition (no prose, no file editing, no mutating shell).

### Added
- New `editor` agent: collates and sorts reviewer outputs into chronological edit list
- `read-for-context` snippet for pre-session file loading
- Writer Instruction Packet (WIP) specification in planner.md
- Input handling steps to Review → Edit → Write Pipeline
- Strict non-negotiable prohibition in planner.md (no prose writing, no file editing, no mutating shell commands)
- `apa7-refs` skill for APA 7th edition reference formatting
- Snippets for anti-fabrication notices and reviewer collaboration rules

### Changed
- `reviewer-structure`, `reviewer-detail`, `copyeditor` mode changed from `primary` to `subagent`
- `editor` added to agent roster and routing table
- `planner` bash permissions limited to read-only commands (git status, cat, grep, etc.)
- `planner` WIP field simplified: SKILL (single skill name), SNIPPETS (list of snippet-name references)
- Writer reframed as instruction-following prose engine (receives WIP, loads specified skill, executes exactly)
- Editor description changed from "orchestrator" to "collation agent" throughout
- Editor task permission removed (Planner launches reviewers, not Editor)

### Fixed
- Editor collaboration rules (removed circular "Report to editor" language)
- Editor role description (receives outputs from Planner, does not launch reviewers)
- AGENTS.md editor responsibility wording ("sorts" not "launches and sorts")

## [2026-04-19] — Manuscript Workflow Refactor (Completed)

Shared snippets system established to DRY repeated text across skills. Agent and skill renames for consistency.

### Added
- Four shared snippets: style-core, placeholder-discipline, anti-fabrication-short, note-on-examples

### Changed
- Replaced STYLE.md file-load instructions with `style-core` snippet inclusions in intro, lit-review, abstract, discussion, methods, results, title, r-analysis-quarto skills
- Added `style-core` snippet inclusion to discussion skills Rules section
- Added anti-fabrication and placeholder discipline snippets to results skill
- Added placeholder discipline and note on examples to manuscript-workflow skill
- Renamed lit-review skill directory to lit-review-section
- Renamed literature-review skill directory to finding-refs
- Renamed literature-review agent to literature-reviewer
- Updated all references in AGENTS.md, opencode.json, planner, writer, deep-research agents
- Updated skill descriptions and frontmatter to match new directory names

## [2026-04-18] — Major Manuscript Workflow Refactor

Major architectural shift: paper-type skills replaced with section-based skills. Specialized reviewer agents created for triangulated feedback. opencode-snippets plugin integrated.

### Added
- New section-based skills: intro, lit-review, methods, results, discussion, manuscript-workflow
- Specialized reviewer agents: reviewer-structure, reviewer-detail, copyeditor
- opencode-snippets plugin integration with synthetic examples
- Streamlined AGENTS.md (~100 lines) and STYLE.md (~80 lines)
- tui.json for snippets plugin UI configuration
- Title and abstract skills

### Changed
- Replaced empirical-paper and theoretical-paper skills with section-specific skills
- Updated writer agent with primary model: ollama-cloud/gemma-2-9b
- Optimized reviewer model assignments for family diversity:
  * Reviewer-structure: qwen/qwen2.5-7b-instruct (Qwen family)
  * Reviewer-detail: microsoft/phi-3-mini-128k-instruct (Phi family)
  * Copyeditor: mistral/mistral-7b-instruct (Mistral family)
- Updated agent permissions and configurations
- Enhanced workflow documentation and routing logic

### Removed
- Old empirical-paper/ and theoretical-paper/ skill directories
- Legacy reviewer.md agent file
- Separate example files for skills (replaced with synthetic snippets)

## [2026-04-14–17] — Provider refactor and early iterations

Model providers refactored: HuggingFace replaced with OpenCode Go, Zen, and OpenRouter for more reliable and performant providers. Multiple config iterations refined agent definitions, model assignments, and workflow logic.

### Changed
- Model providers refactored: HuggingFace → OpenCode Go + Zen + OpenRouter
- File references updated to use explicit paths

## [2026-04-06–10] — Initial setup and foundational architecture

Multi-agent system for academic manuscript writing first established. Initial architecture: planner (orchestrator), automation (shell/git), writer (drafting), guard (safety), literature-review (search), deep-research (evidence gathering), r-analysis (R/Quarto), generic reviewer. Config consolidated to fix model conflicts and establish primary/subagent hierarchy.

### Added
- Core agent definitions: planner, automation, writer, guard, literature-reviewer, deep-research, r-analysis
- Generic reviewer agent
- Empirical-paper and theoretical-paper skills
- STYLE.md and AGENTS.md documentation
- Basic opencode.json configuration
- workflow-state.json and checkpoints/ directory for state tracking

### Changed
- Config consolidated: automation as primary agent, deep-research as subagent
- Model conflicts and fallbacks fixed
- OpenCode-first quota strategy adopted

### Fixed
- Critical bugs and structural issues from initial workflow critique
- Edit permissions enabled for automation and deep-research agents
- Guard granted read-only bash access and independent model
