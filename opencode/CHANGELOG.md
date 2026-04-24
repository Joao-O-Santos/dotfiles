# Changelog
All notable changes to the OpenCode Manuscript Workflow will be documented in this file.

## [Unreleased]
### Added
- New snippets: `agents-ref`, `stop-loss-limits`, `routing-table`, `research-separation`, `checkpoint-schedule`, `git-workflow`, `read-style`, `mcp-tool-awareness`, `snippet-catalog`, `plannotator-awareness`
- Per-agent `steps` limits in `opencode.json` as hard structural backstops for loop prevention (planner=20, automation=30, writer=10, reviewer-structure=10, reviewer-detail=10, copyeditor=10, editor=8, guard=10, literature-reviewer=12, deep-research=20, r-analysis=30)
- Plannotator awareness in planner config — agents should use `submit_plan` for plan-style decisions instead of the `question` tool
- citecheck and context7 MCP awareness in relevant agents

### Changed
- AGENTS.md slimmed from ~183 to ~45 lines; all agent-specific content extracted into snippets
- planner.md restructured with explicit routing table, edge-case decision tree, snippet catalog, Plannotator awareness, "When NOT to delegate" section, and research separation
- All agent files updated with snippet references replacing inline boilerplate (`#agents-ref`, `#read-style`, `#mcp-tool-awareness`, `#checkpoint-schedule`, `#stop-loss-limits`, `#research-separation`, `#git-workflow`)
- Skills updated to use `#mcp-academic-search` snippet for MCP tool descriptions
- Routing constraints relaxed: built-in agents (`@explore`, `@general`, `@build`) allowed for tasks outside manuscript workflow scope (but still prohibited for workflow tasks)
- Edge-case routing refined: "fix a citation" → literature-reviewer then reviewer-detail; "improve this section" → all three reviewers then editor; "check the stats" → r-analysis + reviewer-detail; no-match → ask user or use built-ins (never `@plan`)
- Git workflow snippet includes rebase rule: when `refactor` is behind `main`, rebase onto `main` before merging
- Temperatures migrated from agent frontmatter to `opencode.json` per-agent config

### Deleted
- `note-on-examples.md` snippet (merged into `examples-disclaimer`)

## [Unreleased]
### Fixed
- MCP servers moved from per-agent blocks to top-level `"mcp"` object in `opencode.json` so OpenCode actually registers them
- README.md corrected MCP server attachment description from "per-agent" to "top-level object"

### Added
- Node.js and npm installed to support npx-based MCP servers
- New snippets: `reviewer-collaboration`, `mcp-academic-search`, `context-management-reduce` to DRY repeated text across agent files

### Changed
- Research agent instructions updated to report MCP errors explicitly before falling back to webfetch
- Removed standalone `pubmed` MCP references; medical/psychology coverage reassigned to `semantic-scholar` (paperplain-mcp bundles PubMed + ArXiv + Semantic Scholar)
- Replaced inline collaboration rules in reviewer/editor agents with `#reviewer-collaboration` snippet
- Replaced inline MCP tool sections in research agents with `#mcp-academic-search` snippet
- Replaced inline context-management sections in research agents with `#context-management-reduce` snippet
- Replaced inline placeholder discipline in AGENTS.md with `#placeholder-discipline` snippet

## [Unreleased]
### Changed
- `editor` mode changed from `primary` to `subagent` (reports to planner)

### Added
- Placeholder for upcoming changes

## [2026-04-21] - Editor Agent & Workflow Refactor
### Added
- New `editor` agent (primary): sorts reviewer outputs into chronological edit list
- `read-for-context` snippet for pre-session file loading
- Writer Instruction Packet (WIP) specification in planner.md
- Input handling steps to Review → Edit → Write Pipeline
- Strict non-negotiable prohibition in planner.md (no prose writing, no file editing, no mutating shell commands)

### Changed
- `reviewer-structure`, `reviewer-detail`, `copyeditor` mode changed from `primary` to `subagent`
- `editor` added to agent roster and routing table
- `planner` bash permissions limited to read-only commands (git status, cat, grep, etc.)
- `planner` WIP field simplified: SKILL (single skill name), SNIPPETS (list of #snippet-name references)
- Writer reframed as instruction-following prose engine (receives WIP, loads specified skill, executes exactly)
- Editor description changed from "orchestrator" to "collation agent" throughout
- Editor task permission removed (Planner launches reviewers, not Editor)

### Fixed
- Editor collaboration rules (removed circular "Report to editor" language)
- Editor role description (receives outputs from Planner, does not launch reviewers)
- AGENTS.md editor responsibility wording ("sorts" not "launches and sorts")

## [2026-04-19] - Manuscript Workflow Refactor (Completed)
### Added
- Four shared snippets: style-core, placeholder-discipline, anti-fabrication-short, note-on-examples
### Changed
- Replaced STYLE.md file-load instructions with #style-core snippet inclusions in intro, lit-review, abstract, discussion, methods, results, title, r-analysis-quarto skills
- Added #style-core snippet inclusion to discussion skills Rules section
- Added anti-fabrication and placeholder discipline snippets to results skill
- Added placeholder discipline and note on examples to manuscript-workflow skill
- Renamed lit-review skill directory to lit-review-section
- Renamed literature-review skill directory to finding-refs
- Renamed literature-review agent to literature-reviewer
- Updated all references in AGENTS.md, opencode.json, planner, writer, deep-research agents
- Updated skill descriptions and frontmatter to match new directory names

## [2026-04-18] - Major Manuscript Workflow Refactor
### Added
- New section-based skills: intro, lit-review, methods, results, discussion, manuscript-workflow
- Specialized reviewer agents: reviewer-structure, reviewer-detail, copyeditor  
- opencode-snippets plugin integration with synthetic examples
- Streamlined AGENTS.md (~100 lines) and STYLE.md (~80 lines)
- tui.json for snippets plugin UI configuration

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

## [2026-04-16] - Initial Setup
### Added
- Core agent definitions: planner, automation, writer, guard, literature-reviewer, deep-research, r-analysis
- Generic reviewer agent
- Empirical-paper and theoretical-paper skills
- STYLE.md and AGENTS.md documentation
- Basic opencode.json configuration
