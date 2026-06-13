# NEWS — OpenCode Manuscript Workflow

Notable changes to the OpenCode configuration, agents, plugins, and related tooling.

## 2026-06-13 — README sync, Plannotator env, Magic Context expansion

- **README** synced with current config: Plannotator plugin documented, magic-context example updated (deepseek-v4-pro, memory, sidekick), model assignments now reference `set_models.sh`, `account.json` added to denied files list.
- **Plannotator** data directory environment variable added to shellrc.
- **r-analysis** agent updated in opencode+planner temp config.
- **Magic Context** config expanded: `memory` block with `git_commit_indexing`, `sidekick` block with `deepseek-v4-flash`.

## 2026-06-11 — Model upgrades, writer autonomy, account.json lockdown

- **Magic Context** historian and dreamer models upgraded to `deepseek-v4-pro`.
- **Writer** agent empowered with more creative autonomy.
- **Model assignments** upgraded across agents; temperatures adjusted.
- **account.json** added to read/external_directory deny list alongside `auth.json` and `mcp_keys.sh`.

## 2026-04-27 — PDF tools, model bumps

- **PDF tool guidance** (`pdftotext`, `pdfgrep`) added to research and automation skills and global bash permissions.
- **Historian/dreamer** models bumped to `qwen3.6-plus`.

## 2026-04-24–26 — Major config refactor, Plannotator, snippets DRY

- **Plannotator plugin** (`@plannotator/opencode@latest`) added with `plan-agent` workflow; planner restructured with routing table, stop-loss limits, and Plannotator awareness.
- **AGENTS.md** slimmed from ~183 to ~45 lines; agent-specific content extracted into snippets.
- **Ten new snippets** added for DRY agent config: `agents-ref`, `stop-loss-limits`, `routing-table`, `research-separation`, `checkpoint-schedule`, `git-workflow`, `read-style`, `mcp-tool-awareness`, `snippet-catalog`, `plannotator-awareness`.
- **Temperatures** migrated from agent frontmatter to `opencode.json` per-agent config.
- **Per-agent `steps` limits** added as structural backstops for loop prevention.
- All agent files updated with snippet references replacing inline boilerplate.
- **Commands directory** added.

## 2026-04-22–23 — MCP integration, Magic Context, Git workflow

- **MCP servers** configured: Context7 (docs/API), Citecheck (bibliographic verification), OpenAlex (scholarly metadata), Semantic Scholar (paper retrieval).
- **Magic Context** plugin installed (`@cortexkit/opencode-magic-context`); `magic-context.jsonc` created.
- **MCP-first search** strategy adopted for literature-reviewer and deep-research agents.
- **Build agent** added; kimi-k2.5 switched to k2.6 across agents.
- **GPG signing workflow** snippet added and referenced in planner, automation, guard, and r-analysis agents.
- **Git commit** requires explicit approval; deny by default, explicit ask for planner/automation/r-analysis.
- **Git Workflow** section expanded with solo-owner branch model and commit delegation rules.
- **STYLE.md** updated: custom styles reduced to 3 `:::` markers.

## 2026-04-21 — Editor agent, subagent refactor, WIP pipeline

- **Editor agent** added: collates and sorts reviewer output into chronological edit list.
- **Reviewers** (`reviewer-structure`, `reviewer-detail`, `copyeditor`) changed from primary to subagent mode.
- **Writer** reframed as instruction-following prose engine receiving Writer Instruction Packets (WIP).
- **Planner** given non-negotiable prohibition (no prose, no file editing, no mutating shell), WIP spec, and review pipeline.
- **apa7-refs** skill added for APA 7th edition reference formatting.
- **Review → Edit → Write pipeline** formalized with input handling steps.

## 2026-04-18–19 — Section skills, reviewer agents, snippets integration

- **Section-based skills** replaced paper-type skills: `intro`, `lit-review-section`, `methods`, `results`, `discussion`, `manuscript-workflow`.
- **Specialized reviewer agents** created: `reviewer-structure`, `reviewer-detail`, `copyeditor`.
- **opencode-snippets** plugin integrated with synthetic examples.
- **Title and abstract** skills added.
- **Shared snippets** system established; agent/skill renames (`lit-review-section`, `finding-refs`, `literature-reviewer`).
- **tui.json** added for snippets plugin UI configuration.
- **README.md** and **CHANGELOG.md** documentation created.

## 2026-04-14–17 — Provider refactor, early config iterations

- **Model providers** refactored: HuggingFace replaced with OpenCode Go, Zen, and OpenRouter.
- Multiple config iterations refining agent definitions, model assignments, and workflow logic.

## 2026-04-06–10 — Initial setup

- **OpenCode workflow files** first added.
- **Config consolidated**: primary automation agent, deep-research subagent, model conflicts and fallbacks fixed.
- **Critical bugs** and structural issues from initial workflow critique addressed.
