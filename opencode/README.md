# OpenCode Manuscript Workflow

A specialized AI agent system designed for academic manuscript writing, revision, and optimization. The workflow uses a team of specialist agents that collaborate to help you produce high‑quality papers through structured drafting, expert review, and iterative improvement.

## Overview

The OpenCode Manuscript Workflow implements a multi‑agent system where each agent has a specific role in the academic writing process:

- **Planner** (primary): Orchestrates the workflow, decomposes tasks, manages overall progress, and delegates to specialist agents.

- **Writer** (primary): Handles manuscript drafting and revision, executing Planner's structured Writer Instruction Packets (WIP).

- **Editor** (subagent): Collates all four reviewer outputs, categorizing
  issues by consensus level: Consensus Issues (flagged by ≥2 reviewers),
  Single-Source Issues (1 reviewer), and Direct Disagreements.

- **Reviewer Ensemble** (subagents, launched by Planner):
  - `reviewer-structure`: Big‑picture critique (structure, arguments, impact).
  - `reviewer-structure-2`: Adversarial second structural opinion — runs only
    at Full Ensemble Checkpoints with a deliberately skeptical posture.
  - `reviewer-detail`: Citations, conceptual clarity, and argument issues.
    Includes a logical fallacy catalog, bias‑detection checklist (framed as
    questions, not accusations), and statistical red‑flag patterns.
  - `copyeditor`: Prose, titles, paragraphs, sentences, words, markdown
    compliance.

- **Strategist** (subagent, checkpoints only): Tool‑less arbitration for
  disputed or non‑obvious reviewer disagreements. Receives a batched
  Escalation Packet from Planner; decisions are persisted to cross‑session
  memory for citable evidence.

- **Support Agents**:
  - `literature-reviewer`: Fast academic search and paper summaries.
    DB‑first sourcing: consult `~/lit/_index.db` before MCP/API searches.
  - `deep-research`: Exhaustive multi‑step evidence gathering. Same DB‑first
    discipline, plus a sources file for tracking provenance.
  - `r-analysis`: R / Quarto pipeline edits and statistical code changes.
  - `automation`: Shell, git, and terminal‑native execution.

## Key Features

- **Section‑based skills**: Skills are organized around manuscript sections (introduction, literature review, methods, results, discussion) rather than paper "types." Recent additions include the `methods` skill with power‑analysis guidance (rooted in the user's perspective on a priori power analysis as informed guessing) and general experimental‑design principles.

- **Local literature library**: The `~/lit` directory holds ~1,500 indexed papers across 22 topics in a SQLite + FTS5 database (`~/lit/_index.db`). Three tools support it:
  - **lit-index** — indexes `~/lit` PDFs into the SQLite/FTS5 database for structured queries and full‑text search.
  - **lit-alert** — personalized new‑paper notification (like Google Scholar alerts for your `~/lit` library), checking for recent papers by your authors on your topics.
  - **lit-heal** — LLM‑powered database audit and repair; fixes garbled titles, missing DOIs, and wrong years that the mechanical indexer cannot resolve.
  These are loaded by the `literature-reviewer` and `deep-research` agents.

- **Two‑tier reviewer ensemble**: Fast Loop (3 reviewers in parallel for
  iterative drafting) vs. Full Ensemble Checkpoint (4 reviewers plus editor
  collation with consensus/single‑source/disagreement categorization, and
  strategist arbitration for genuinely disputed issues). Keeps routine
  iterations cheap while ensuring thorough scrutiny at major milestones.

- **Writer Instruction Packets (WIP)**: Planner sends Writer highly structured packets (task type, section, paragraph skeleton, evidence, placeholders, and skills) to keep drafting grounded in evidence.

- **Sandboxed permissions**: Only a small subset of agents can commit or run
  mutating git commands (and even then, only with "ask" permission).

- **Magic Context**: A context management plugin that replaces default compaction with cache‑aware summarization and long‑term memory.

- **AFT (Abstract File Trees)**: A code‑analysis plugin (`@cortexkit/aft-opencode@latest`) providing tree‑sitter‑powered symbol outlines, inline zoom, AST‑aware search/replace, code diagnostics, and import management — available to `r-analysis`, `automation`, and `writer`.

- **Plannotator**: A plan‑based decision plugin (`@plannotator/opencode@latest`) that enables agents to use `submit_plan` for structured planning instead of the `question` tool.

- **MCP‑backed literature search**: OpenAlex and Semantic Scholar MCP servers provide structured academic metadata and PDFs for the literature‑reviewing agents.

## Installation & Setup

### Prerequisites

- Node.js (for `npx`‑based MCP servers and optional plugins).
- Access to at least one LLM provider configured in `auth.json` (e.g., OpenRouter, Mistral, Opencode‑go).
- Bash shell (for `mcp_keys.env` and `set_models.sh`).

### 1. Clone and install

```bash
git clone git@github.com:Joao-O-Santos/dotfiles.git
cd dotfiles
# Plugins and MCP servers are installed on-demand via npx
```

### 2. Configure model providers

Edit `~/.config/opencode/auth.json` to include the providers you actually use, for example:

```json
{
  "openrouter":   { "type": "api", "key": "your-openrouter-key" },
  "mistral":      { "type": "api", "key": "your-mistral-key" },
  "opencode-go":  { "type": "api", "key": "your-opencode-go-key" }
}
```

Remove providers you don't use (e.g., `huggingface`, `ollama-cloud`) to keep things clean.

### 3. Configure MCP API keys

Create `~/.config/opencode/mcp_keys.env`:

```bash
#!/usr/bin/env bash

# Context7 (docs & API reference MCP)
export CONTEXT7_API_KEY="your_context7_key"

# OpenAlex (scholarly metadata MCP)
export OPENALEX_API_KEY="your_openalex_key"
export OPENALEX_EMAIL="your_email@example.com"

# Crossref (used by citecheck)
export CROSSREF_MAILTO="your_email@example.com"
```

Make it non‑world‑readable and don't commit it:

```bash
chmod 600 ~/.config/opencode/mcp_keys.env
echo "mcp_keys.env" >> ~/.config/opencode/.gitignore  # if you track that directory
```

### 4. Launch OpenCode with MCP keys and model assignments

In your shell rc (e.g., `.zshrc`):

```bash
source ~/.config/opencode/mcp_keys.env
source ~/.config/opencode/set_models.sh
alias oc="opencode --config ~/.config/opencode/opencode.json"
```

Then start OpenCode with:

```bash
oc
```

### 5. Magic Context setup

Magic Context is already registered in `opencode.json` via the plugin `"@cortexkit/opencode-magic-context"` and disables the built‑in compaction:

```json
"plugin": [
  "opencode-snippets",
  "@cortexkit/opencode-magic-context@latest",
  "@cortexkit/aft-opencode@latest",
  ["@plannotator/opencode@latest", {
    "workflow": "plan-agent",
    "planningAgents": ["plan", "planner"]
  }]
],
"compaction": {
  "auto": false,
  "prune": false
}
```

You still need a `magic-context.jsonc` (stored in `~/.config/opencode/magic-context.jsonc`) to pick the historian/dreamer model. A minimal example using your subscription models:

```jsonc
{
  "$schema": "https://raw.githubusercontent.com/cortexkit/opencode-magic-context/master/assets/magic-context.schema.json",
  "enabled": true,
  "historian": {
    "model": "opencode-go/deepseek-v4-pro"
  },
  "dreamer": {
    "model": "opencode-go/deepseek-v4-pro",
    "pin_key_files": { "enabled": true }
  },
  "memory": {
    "enabled": true,
    "git_commit_indexing": { "enabled": true }
  },
  "sidekick": {
    "enabled": true,
    "model": "opencode-go/deepseek-v4-flash"
  }
}
```

Magic Context then runs automatically; no further config in this repo is needed.

**Note:** `magic-context.jsonc` is not tracked in this repository — it
contains user-specific model preferences and should be created manually
alongside `opencode.json`. A minimal example is shown above.

## Usage

### Basic Commands

- Invoke agents directly:
  - `@writer "Draft the introduction section for a paper on X"`
  - `@literature-reviewer "Find recent papers on Y"`
  - `@r-analysis "Refactor this R/Quarto analysis pipeline"`
  - `@reviewer-structure-2 "Second opinion on the discussion structure"`
- Run mechanical check:
  - `"run chkdrft"` (counts citations needed, TODOs left)
- Switch workflow modes:
  - `"high-control mode"` or `"autonomous batch mode"`

### Workflow Modes

- **High‑Control Mode** (default): Planner pauses for approval at outline, topic‑sentence planning, large structural rewrites, major methods/results/discussion changes, and before executing reviewer‑suggested fixes.
- **Autonomous Batch Mode**: Planner runs end‑to‑end until a loop signal or blocker requires intervention.

### Agent Invocation Format

```text
@agentname "Your specific request here"
```

Examples:

- `@writer "Draft an introduction section for a paper on machine learning in healthcare"`
- `@reviewer-structure "Review the structure of my methods section"`
- `@copyeditor "Improve the prose and flow of this paragraph"`
- `@literature-reviewer "Find recent papers on transformer architectures in psychopathology research"`

## Configuration

### opencode.json

`opencode.json` is the single source of truth for model selection, permissions, MCP servers, and plugins. `AGENTS.md` is the single source for agent responsibilities and routing rules and **does not contain any model names** (kept model‑agnostic by design).

### Current Model Assignments

Model assignments are set via environment variables in `set_models.sh` (sourced before launching OpenCode) and referenced in `opencode.json` as `{env:AGENT_MODEL}`. The current mix uses DeepSeek, GLM, Qwen, MiniMax, and MiMo models via the `opencode-go` provider. See `set_models.sh` for exact per‑agent mappings.

### MCP Servers

MCP servers are defined in the top‑level `"mcp"` object of `opencode.json` (globally available, not per‑agent):

- **Context7** (`@upstash/context7-mcp`)
  - Agents: `r-analysis`, `automation`
  - Purpose: library/docs/API‑reference lookup for R, Quarto, and general coding
  - Env: `CONTEXT7_API_KEY`
- **Citecheck** (`@jhlee0619/citecheck`)
  - Agents: `reviewer-detail`, `copyeditor`
  - Purpose: bibliographic verification and repair via Crossref (and related sources)
  - Env: `CROSSREF_MAILTO`
- **OpenAlex MCP** (`@cyanheads/openalex-mcp-server`)
  - Agents: `literature-reviewer`, `deep-research`
  - Purpose: structured scholarly metadata and citation search
  - Env: `OPENALEX_API_KEY`, `OPENALEX_EMAIL`
- **Semantic Scholar MCP** (`paperplain-mcp`)
  - Agents: `literature-reviewer`, `deep-research`
  - Purpose: Semantic Scholar‑backed paper retrieval and summaries
  - Env: none required for basic usage

Each MCP entry uses `"type": "local"` with an `npx` command and, where needed, an `environment` block referencing your shell env (e.g., `$OPENALEX_API_KEY`).

## Review → Edit → Write Pipeline

There are two review modes:

### Fast Loop (default, iterative drafting)

1. **Launch Reviews**: Planner delegates simultaneously to
   `reviewer-structure`, `reviewer-detail`, `copyeditor`.
2. **Apply Fixes**: Planner applies straightforward fixes directly based
   on reviewer output. No `editor` or `strategist` involvement.
3. **Write & Commit**: Writer applies edits per WIP. Run `chkdrft` to
   verify no citations/placeholders were lost.

### Full Ensemble Checkpoint (major milestones)

1. **Launch All Reviewers**: Planner delegates simultaneously to
   `reviewer-structure`, `reviewer-structure-2`, `reviewer-detail`,
   `copyeditor`.
2. **Collate**: `editor` categorizes all four outputs into Consensus
   Issues (≥2 reviewers), Single-Source Issues (1 reviewer), and Direct
   Disagreements. Blind‑spot detection still runs.
3. **Strategist Escalation**: For Single-Source Issues where the fix is
   not mechanically obvious, and all Direct Disagreements, Planner
   batches them into a single `strategist` call. Strategist has no
   tools — it receives a curated Escalation Packet and returns
   decisions. Consensus Issues auto‑apply per the Consensus Rule.
4. **Write & Commit**: Writer applies edits per WIP. Planner persists
   strategist decisions to cross‑session memory for citable evidence.

## Extending the System

### Adding Custom Skills

1. Create a new directory under `skills/`.
2. Add a `SKILL.md` describing the skill and any conventions.
3. Reference the skill from agent prompts (e.g., `agents/planner.md`, `agents/writer.md`) or the snippet catalog (`snippet/snippet-catalog.md`).

### Adding Snippet Examples

1. Create markdown files in the `snippet/` directory.
2. Use `snippet-name` references (without the `#` prefix) in skills or agent instructions to inject content via the `opencode-snippets` plugin. The plugin inline‑expands snippet references at load time.
3. **Important**: Omit the `#` prefix when writing snippet references in documentation (README, AGENTS.md, etc.). The `#` prefix triggers syntax‑highlighted inline display in the OpenCode UI and should only appear in agent definitions that the plugin actively processes. In plain docs, the unprefixed form prevents accidental expansion.
4. Look at existing snippets for formatting and naming conventions. The snippet catalog (`snippet/snippet-catalog.md`) lists all available snippets with descriptions and primary users.

### Modifying Agent Permissions

Permissions are set at two levels:

1. **Global defaults** (top‑level `permission` block): apply to all agents unless overridden.
2. **Agent‑level overrides** (`agent.<name>.permission`): completely replace the global setting for that category — they do not merge.

Key permission categories:
- `edit`: allow/deny file editing.
- `webfetch`: allow/deny `webfetch` calls.
- `bash`: fine‑grained bash permissions. Most agents inherit the global allowlist (read‑only commands + git inspection). Only `automation`, `r-analysis`, `writer`, `literature-reviewer`, and `deep-research` define custom bash blocks.
- `external_directory` & `read`: filesystem access. Global allows `~/.config/opencode/**` (except `auth.json`, `account.json`, and `mcp_keys.env`) and `/tmp/**`.
