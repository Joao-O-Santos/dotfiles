# Changelog — OpenCode Manuscript Workflow

All notable changes to the OpenCode configuration will be documented in this file.

## v8.2.0 — 2026-07-16

### Permissions
- Simplified global permissions: removed `"*": "deny"` that broke AFT and MCP tools
- Global bash deny with per-agent overrides (automation: full, r-analysis: full, lit-reviewer/deep-research: pdfgrep/pdfgrep/sqlite3)
- Planner has no bash — uses task delegation, AFT tools, and MCP tools
- Writer has read + edit only (no bash)
- Reviewers/editor/strategist inherit global read-only defaults
- AFT and MCP tools always available when plugin is loaded (not permission-controlled)

### Documentation
- Fixed planner.md: removed references to planner bash commands
- Fixed git-workflow.md: planner delegates git status to automation
- Strategist now prioritizes correctness over diplomatic compromise
- Reviewers identify problems only; planner prescribes fixes
- Dual writer invocation modes documented (draft vs fix)
- Remove lit-heal from deep-research

## v8.1.2 — 2026-07-15

### Permissions
- Deny bash for all 5 reviewer/editor agents (were inheriting global allows)
- Remove sed from writer bash allowlist
- Trim global grep/rg/find (only needed by lit agents with their own allows)

### Review Workflow
- Reviewers identify problems only; Fix field removed from output format.
  Planner prescribes solutions, writer implements them.
- Reviewer-structure-2 instructed to never suggest fixes (adversarial
  role is to find problems others miss).
- Remove lit-heal from deep-research (expensive agent shouldn't do DB
  maintenance; kept on literature-reviewer).

### Writer Invocation
- Planner docs dual writer modes: draft mode (full WIP with skills) for
  new sections, fix mode (target text + edit, no WIP) for surgical
  revisions. Same agent, same quality, cheaper per-fix invocation.

### Semantic Search
- Switch AFT semantic backend from local fastembed to Mistral
  mistral-embed (1024-dim, OpenAI-compatible endpoint).
- Clear 103MB cached fastembed index for clean rebuild.
- Document AFT tool coverage in planner.md: aft_search only indexes
  code files; use aft_outline/aft_zoom for markdown.

### Documentation
- oksh reference removed from automation.md (stale)
- OpenCode README now documents cortexkit/{aft,magic-context}.jsonc
- Editor description in opencode.json matches AGENTS.md
- Top-level README config table includes cortexkit entries

## v8.1.1 — 2026-07-15

### Attribution
- Add McGuire (1997) heuristic framework crediting in COPYING.md
- Add full writing-examples author attribution table (Sarnecka, Hagá, Earp & Trafimow, Santos et al.)
- Add scientific-writing, peer-review, literature-review skill inspirations

### Cleanup
- Remove stale commented_lit_tree file
- Top-level README now documents cortexkit/{aft.jsonc,magic-context.jsonc}

## v8.1.0 — 2026-07-15

### AFT Configuration
- Enable `bash.rewrite: true` so shell `grep`/`find`/`cat` calls are intercepted and rewritten to AFT tools with hints.
- Explicitly set `hoist_builtin_tools` and `tool_surface` in `cortexkit/aft.jsonc`.

### Permissions & Routing
- Add planner bash block denying `grep`/`rg`/`find` (was inheriting global allows, enabling AFT-avoidance).
- Remove `grep`/`rg`/`find` from writer bash allowlist.
- Rename `@coding-style` to `@r-style`, point at full `skills/r-analysis-quarto/` directory.
- Add `@writing-examples` hidden reference — grouped examples by section type from published papers and user's own work.

### Agent Instructions
- Planner: replace Inspect bash tools with AFT tools, add "Route first, explore never" rule, add r-analysis/automation expert delegation rules, rewrite WIP EVIDENCE field (facts not prose), add WIP principle, add concision rule.
- r-analysis: remove redundant style snippet (already loaded in writing skills), add style checklist (tabs, base pipes, ≤80 chars), add Context7 trigger for bleeding-edge packages.
- automation: add Context7 trigger for unfamiliar CLI tools.
- strategist: add concision rule for expensive model.

### Coding Style
- Add concrete R code examples to `coding_style.md` (pipe style, indentation, function calls, helper functions, object naming).
- Fix pipe-chain example: `filter(ds, ...) |>` not `ds |> filter(...)`.

### Writing Examples
- Create `writing-examples/` with 5 grouped files (abstract, intro, methods, results, discussion) covering 12 examples across the user's thesis, tgtbtu, Hagá, Sarnecka, and Earp & Trafimow.
- Update all 9 writing skills to mention `@writing-examples` reference.

### Documentation
- Add commit-message conventions to `git-workflow` snippet and `automation` agent (verb-first, ≤50 chars, no `feat:`/`fix:` prefix).
- Remove stale loop-prevention line from AGENTS.md.

## [v8.0.0] — 2026-07-14

### Added
- `reviewer-structure-2`: adversarial second structural critique running
  only at Full Ensemble Checkpoints with `deepseek-v4-pro`.
- `strategist`: tool-less arbitration agent for disputed or non-obvious
  reviewer disagreements. Batched, single-turn, zero-tool design caps
  per-call cost. Decisions persisted to ctx_memory for citable evidence.
- `theoretical-paper` snippet: planner routing guidance for
  theoretical/review papers (skip methods/results, use theoretical
  structures in intro/discussion).

### Changed
- **Editor** updated for 4-reviewer collation with consensus categories:
  Consensus Issues (≥2 reviewers), Single-Source Issues (1 reviewer),
  Direct Disagreements. Blind-spot detection preserved.
- **Planner** now distinguishes Fast Loop vs. Full Ensemble Checkpoint
  routing per AGENTS.md §Review Loop Types. Strategist Escalation
  Protocol added with batched single-call-per-checkpoint design.
- **Model reassignments** (see set_models.sh): writer, reviewer-structure,
  editor, literature-reviewer moved to cheaper pools; lit-reviewer and
  deep-research off glm-5.2; planner retains exclusive deepseek-v4-pro.

### Removed
- **Guard agent retired.** Step limits in opencode.json replace loop
  detection; `chkdrft` handles mechanical placeholder/citation counting.
  Guard's regression detection was unreliable for scientific prose (no
  deterministic ground truth for text regressions).

## [v7.8.1] — 2026-07-14

### Changed
- **STYLE.md removed from global instructions.** Core rules now delivered
  via `This snippet contains the core writing conventions that should be referenced by all skills.

## Voice and Tone
- Use a confident, matter-of-fact academic voice
- Assume a scientifically literate reader
- Prefer concrete, example-rich explanations
- Use first-person plural ("we") when standard for the venue

## Paragraph Structure
- Use the hamburger model (topic sentence, supporting evidence, concluding/linking sentence)
- Create topic-sentence outlines for major sections
- Use explicit signposting in early drafts, refine in later revisions

## Sentence-Level Style
- Bring main verbs early in sentences
- Follow end-weight principle (longer phrases toward end)
- Use topic → comment ordering
- Avoid multiple negations
- Prefer concrete, specific words over abstract nominalizations
- Maintain consistent terminology across text, tables, figures, and code
- **MANDATORY**: Hard-wrap all prose to 72 characters per line

## Titles and Headings
- Paper and section titles should be provocative and memorable
- Use 4 blank lines before H1, 3 before H2, 2 before H3, 1 before H4

## Page Breaks and Custom Styles
- For Word conversion, use OpenXML page breaks with proper spacing
- Apply custom styles: Title, Abstract, Figure, References
- Do NOT remove custom styles when editing existing documents` snippet in writing skills; full document available on
  demand as `@style` project reference. Saves ~222 lines of context per
  session for non-writing agents (guard, automation, r-analysis, editor).
- `This snippet contains the core writing conventions that should be referenced by all skills.

## Voice and Tone
- Use a confident, matter-of-fact academic voice
- Assume a scientifically literate reader
- Prefer concrete, example-rich explanations
- Use first-person plural ("we") when standard for the venue

## Paragraph Structure
- Use the hamburger model (topic sentence, supporting evidence, concluding/linking sentence)
- Create topic-sentence outlines for major sections
- Use explicit signposting in early drafts, refine in later revisions

## Sentence-Level Style
- Bring main verbs early in sentences
- Follow end-weight principle (longer phrases toward end)
- Use topic → comment ordering
- Avoid multiple negations
- Prefer concrete, specific words over abstract nominalizations
- Maintain consistent terminology across text, tables, figures, and code
- **MANDATORY**: Hard-wrap all prose to 72 characters per line

## Titles and Headings
- Paper and section titles should be provocative and memorable
- Use 4 blank lines before H1, 3 before H2, 2 before H3, 1 before H4

## Page Breaks and Custom Styles
- For Word conversion, use OpenXML page breaks with proper spacing
- Apply custom styles: Title, Abstract, Figure, References
- Do NOT remove custom styles when editing existing documents` added to `methods`, `results`, `discussion`, and
  `copyedit` skills (was already in `intro`, `abstract`, `title`,
  `lit-review-section`, `apa7-refs`, `finding-refs`, `r-analysis-quarto`).
- `read-style` snippet updated to reflect new mechanism.
- `copyedit/SKILL.md` section-number references replaced with descriptive
  anchors (no longer depends on STYLE.md being in context).

### Added
- `references` block in `opencode.json`: `style` (STYLE.md), `coding-style`
  (R coding conventions), `lit-index` (SQLite bibliography).
- Explicit `sqlite3 *` bash permission for `literature-reviewer` and
  `deep-research` agents (safer than relying on global inheritance given
  known subagent permission propagation bug).

### Fixed
- `#lit-alert` and `#lit-heal` in `literature-reviewer.md` and
  `deep-research.md` were snippet-style references pointing to non-existent
  snippet files. Replaced with explicit labels: skills (loaded via `skill`
  tool), commands (slash commands), and snippets (auto-expanded).
- `skills/lit-review-section/SKILL.md` heading updated from stale
  `# Skill: lit-review` to `# Skill: lit-review-section`.
- `examples-disclaimer` snippet references verified across all skills.

### Removed
- `reviewer-output-rules` snippet consolidated into `reviewer-output-format`
  (merged output template with output principles — 1 snippet instead of 2
  with ~80% overlap).

## [v7.8.0] - 2026-06-18

### Added
- skills/reply-to-reviewers/SKILL.md: new skill
  - 4-step process: distinguish editor from reviewers → decide on each
    comment → make changes → write response letter
  - Rebuttal ammunition: power analysis (T-shirt sizes, N-hacking,
    post-hoc power, "inadequate = reject"), passive voice (Pullman 2014),
    reviewer overreach
  - Tone: respectful but not obsequious, confident but not combative
  - Source: Sarnecka (2024), The Writing Workshop, Ch. 5
- commands/reply-to-reviewers.md: command routing to writer
- skills/abstract/SKILL.md: two annotated examples
  - Example 1 (appe2026): empirical, 4 studies, N=4084, mediation
  - Example 2 (escon2021): multi-study, Roman numeral signposting,
    N per study, null results reported
  - Both demonstrate: gap-first opening, specific Ns, null results,
    implications beyond "more research needed"
- agents/writer.md, agents/planner.md: reply-to-reviewers added to
  Relevant Skills sections

## [2026-06-16] — v7.3.0: Comprehensive DB healing, lit-heal skill rewrite

### Changed
- `lit-heal` skill rewritten with lessons from healing 1,515 papers:
  - **Bold DO-NOT-USE warning** against mechanical fixer scripts
    (_heal.py, _fix_all.py, litfix). These scripts cannot distinguish
    between an article's own DOI and DOIs cited in its reference list.
  - **LLM-reads-text workflow** replaces broken mechanical extraction.
    LLM reads first 5 pages of PDF text, identifies real title
    semantically, verifies DOI against OpenAlex before applying.
  - **Cardinal rule**: filenames are authoritative for author and
    publication year. Do NOT change year or first_author fields.
  - **Real garbage patterns** documented from actual data (journal
    names, watermarks, SAGE artifacts, ScienceDirect headers,
    ResearchGate boilerplate, ALL-CAPS running heads).
  - Direct `sqlite3 UPDATE` replaces `litfix` wrapper (unreliable).

### Fixed
- 1,515 papers verified, 0 garbage titles, 0 missing titles, all locked
- 3 scanned PDFs OCR'd via Tesseract
- Wrong DOIs corrected (cited-paper DOIs replaced with article DOIs)
- 77 duplicate records removed, 15 orphan records removed

## [2026-06-16] — v7.2.0: Lit-heal skill (LLM-powered audit and repair)

### Added
- `lit-heal` skill: instructs agents (literature-reviewer, deep-research) to:
  1. Query DB for garbage titles, missing DOIs, empty fields
  2. Look up real metadata via OpenAlex
  3. Apply fixes via direct SQL
  4. Report summary
- All three lit skills now loaded by both lit agents

### Changed
- `lit-alert` replaces `lit-recommend` (redundant with regular lit-reviewer
  invocations). Lit-alert is unique: personalized, incremental, state-tracking
  (reads `~/lit/_last_check`, searches your authors × your topics × since
  last check).

## [2026-06-16] — v7.1.0: Lit-recommend skill (LLM-curated paper recommendations)

### Added
- `lit-recommend` skill: instructs agents (literature-reviewer, deep-research) to:
  1. Analyze existing directory content (index, notes, top authors)
  2. Search OpenAlex by author, topic, and citation graph
  3. **Judge relevance semantically** — read each candidate's title/abstract
  4. Output curated recommendations to `_recommendations.md`
- `lit-recommend` command: user-invocable paper recommendation workflow
- `literature-reviewer` agent now loads `#lit-recommend` snippet

### Changed
- Recommendation quality: replaces keyword-matching `_recommend.py` approach
  with LLM-in-the-loop curation (eliminates off-target suggestions like
  ChatGPT papers in crisis/ directories)

### Design Rationale
Python scripts cannot judge semantic relevance. An LLM agent can read a
candidate's title and abstract and decide: "Does this belong in `discrim`,
or is it a CS paper that happened to match the keyword 'bias'?"

## [2026-06-16] — v7.0.0: Literature library indexer, agent-editable DB, recommendation system

### Added
- `~/lit/_index.py`: PDF indexer (stdlib only) with 3-strategy DOI extraction (PyMuPDF, pdfgrep, pdftotext)
- `~/lit/_index.db`: SQLite database with FTS5 full-text search, `locked` column for manual corrections
- `~/lit/_index.md` + per-directory `_index.md`: human-readable paper indexes
- `~/lit/test_index.py`: 41-unit test suite for the indexer
- `~/lit/_recommend.py`: OpenAlex API queries for candidate papers, supports polite pool
- `~/lit/_recommendations.md`: generated report with OA/paywalled split
- `litindex.sh`, `litsearch.sh`, `litfix.sh`: shell wrappers + aliases
- `lit-search.md` + `lit-index.md`: agent command guides
- `AGENTS.md`: Agent Capabilities section and Delegation Guide
- `plannotator-awareness` snippet: Plannotator feedback processing rules (approve-with-annotations → revise first; clean → delegate)

### Changed
- `_index.py --update` now skips locked (manually-corrected) records
- Planner: "Proceed with implementation" now correctly triggers delegation, not self-execution
- `lit-index` snippet: expanded with DOI, metadata, and re-indexing queries
- `~/lit/.gitignore`: added `__pycache__/`, `*.db-shm`, `*.db-wal`
- All CHANGELOG gaps filled across both repos

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
- `account.json` added to read/external_directory deny list alongside `auth.json` and `mcp_keys.env`

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

## [v7.4.0] - 2026-06-18

### Skills Updated

#### review-detail
- Added logical fallacy catalog (causation, generalization, authority, statistical, structural, science-specific)
- Added bias detection checklist with "check whether" framing (not accusatory)
- Added statistical red flags (8 items)
- Added primacy/recency rule placement (critical rules at start AND end)

#### methods
- Added "Power Analysis and Sample Size" section (user's perspective on power analysis)
- Added "Experimental Design Principles" section (Fisher, design choices)
- Added "Remember" section with 3 critical takeaways
- Power analysis framed as "informed guesses," not precise calculations
- Against T-shirt effect sizes, N-hacking, post-hoc power

### Agents Updated

#### editor
- Added "Blind Spot Detection" section (forced-disagreement on unanimous reviews)
- Core Tension / Blind Spot output format for consensus blind spots

#### deep-research
- Added "Sources Discipline" section (save sources, dedup before re-querying)
- Rate-limit awareness (OpenAlex polite pool)

#### literature-reviewer
- Added compact "Sources Discipline" section

### Commands Updated

#### lit-index
- Documented locked flag behavior in all index modes

#### lit-heal
- Updated to reference direct SQL instead of litfix
- Noted locked records preserved in all re-index modes

### Fixed
- lit/_index.py: full re-index now respects locked flag (critical fix)

## [v7.5.0] - 2026-06-18

### Skills Refined (post-audit)

#### review-detail
- Fallacy catalog condensed: 21 named fallacies → 6 categories with examples
- Rationale: models know the instances; instruction is the category check

#### copyedit
- Generic prose sections (Structure, Paragraph, Sentence, Word) condensed into
  single "Prose Quality" section anchored to STYLE.md paragraphs
- Expanded: Markdown compliance, terminology consistency, custom Word styles,
  pandoc pipe tables, OpenXML page breaks
- Focus: what's SPECIFIC to this workflow, not what models already know

#### discussion
- Added "Multiple Theoretical Perspectives (Perspectivism)" section
- McGuire's perspectivism as behavioral instruction: multiply lenses, avoid
  single-framework absolutism, frame limitations perspectivally

#### intro
- Added "Multiple Perspectives" subsection
- Frame gaps as "what existing perspectives miss" not just "what's unstudied"

### Documentation Updated

#### README.md (top-level)
- Added: ghostty, zen, scripts/, ~/lit library, versioning section
- Updated: license table, Quick Start with set_models.sh

#### README.md (opencode)
- Fixed stale model assignments (now references set_models.sh)
- Added: AFT plugin, lit skills (index/alert/heal), scientific workflow
  integrations, snippets expansion note, 4-plugin config example

### Audit Summary
- Sarnecka: craft already in STYLE.md (hamburger, end-weight, imageability
  via concrete-words rule). Wellness pillars intentionally excluded.
- Pullman: passive voice nuance already in STYLE.md §5.1
- McGuire: perspectivism NOW integrated (was missing — corrected)
- Generic knowledge (fallacy definitions, prose best practices) condensed
  to make room for workflow-specific instruction

## [v7.6.0] - 2026-06-18

### New Skill: writing-craft

Three-layer architecture implemented:
- STYLE.md = how to format and sound
- writing-craft = how to think about the paper intellectually
- section skills = how to structure each specific section

writing-craft covers:
- Paper types (empirical, theoretical, meta-research)
- Contribution framing (7 McGuire generative moves)
- Perspectivism (5 guidelines from McGuire's epistemology)
- Paragraph philosophy (hamburger, old-to-new, end-weight, imageability)
- Revision philosophy (nurture-before-prune, structure-before-sentences,
  reverse outlining)

### Section Skills Trimmed

- intro: removed McGuire contribution framing + multi-perspective sections
  (now in writing-craft), replaced with references
- discussion: removed perspectivism + follow-up heuristics sections
  (now in writing-craft), replaced with references
- methods: added writing-craft reference, kept section-specific content

### Agent Skill Awareness

All 11 agent definitions updated with "Relevant Skills" sections:
- writer: 11 writing skills
- reviewer-structure: 3 skills
- reviewer-detail: 3 skills (incl. mcguire-heuristics snippet)
- copyeditor: 2 skills
- editor: 2 skills
- literature-reviewer: 5 skills
- deep-research: 5 skills
- r-analysis: 2 skills
- guard: 1 skill (manuscript-workflow)
- planner: full skill catalog with selection guidance
- automation: 2 skills (incl. lit-index snippet)

Agents can now proactively load relevant skills instead of waiting
for the planner to specify them in a WIP.

### License Attribution

- review-detail skill: fallacy catalog, bias detection, and statistical
  red flags adapted from scientific-critical-thinking skill by K-Dense Inc.
  (MIT License). License text copied to LICENSES/MIT-K-Dense.
- README.md license table updated.

## [v7.7.0] - 2026-06-18

### Added
- COPYING.md: central attribution file for adapted content
  - review-detail fallacy catalog/bias detection: K-Dense Inc. (MIT)
  - editor blind spot detection: inspired by consciousness-council
  - deep-research/lit-reviewer sources discipline: inspired by research-lookup

### Removed
- Inline attribution from review-detail/SKILL.md (moved to COPYING.md
  to avoid polluting LLM context with author names)

### Changed
- writing-craft/SKILL.md: trimmed from 120 to 75 lines
  - Removed Paragraph Philosophy and Revision Philosophy sections
    (were duplicating STYLE.md content)
  - Replaced with 7-line pointer to STYLE.md and manuscript-workflow
  - Updated frontmatter description to match trimmed scope

## [v7.7.1] - 2026-06-18

### Fixed
- methods skill power analysis: 82 → 25 lines, actionable only
  - Dropped "broader judgment" section (rebuttal arguments belong in
    reply-to-reviewers, not methods drafting)
  - Condensed prose to bullets
  - Shortened Remember items to single lines
- Snippet heading nesting:
  - examples-disclaimer.md: removed h1 (was nesting under h2 in skills)
  - reviewer-output-rules.md: removed h1, demoted h2→h3 subsections
  - style-core.md: removed h1 (h2s become direct skill subsections)
- mcguire-heuristics references: removed # prefix in review-detail and
  writing-craft (was expanding 118 lines mid-sentence)
- Snippet catalog sync: removed 4 deleted, added 2 missing

## [v7.7.2] - 2026-06-18

### Rationale

The power analysis section was recapping the user's unpublished
manuscript in non-actionable prose. It made the reviewer adopt the
user's specific power philosophy rather than checking whether power
was adequately addressed. The passive voice guidance was too quiet
to overcome the anti-passive bias in LLM training data.

### Fixed
- methods skill: power philosophy removed (39 lines → 4-line reminder).
  The writer should write standard adequate power analysis, not adopt
  the user's personal stance on T-shirt effect sizes and N-hacking.
- review-detail skill: 2 neutral power checks added to Statistical
  Red Flags. Checks for presence and adequacy, not specific philosophy.
- STYLE.md 5.1: passive voice section rewritten. Explicitly cites
  Pullman (2014), names the anti-passive crusade as misguided, and
  instructs resistance to reflexive passive-flagging. Five concrete
  rules replacing the previous three quiet bullet points.
