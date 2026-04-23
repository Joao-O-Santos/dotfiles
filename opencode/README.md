# OpenCode Manuscript Workflow

A specialized AI agent system designed for academic manuscript writing, revision, and optimization. The workflow uses a team of specialist agents that collaborate to help you produce high‑quality papers through structured drafting, expert review, and iterative improvement.

## Overview

The OpenCode Manuscript Workflow implements a multi‑agent system where each agent has a specific role in the academic writing process:

- **Planner** (primary): Orchestrates the workflow, decomposes tasks, manages overall progress, and delegates to specialist agents.

- **Writer** (primary): Handles manuscript drafting and revision, executing Planner’s structured Writer Instruction Packets (WIP).

- **Editor** (subagent): Collates reviewer outputs into a chronological edit list.

- **Reviewer Trio** (subagents, launched by Planner):
  - `reviewer-structure`: Big‑picture critique (structure, arguments, impact).
  - `reviewer-detail`: Citations, conceptual clarity, and argument issues.
  - `copyeditor`: Prose, titles, paragraphs, sentences, words, markdown compliance.

- **Support Agents**:
  - `literature-reviewer`: Fast academic search and paper summaries.
  - `deep-research`: Exhaustive multi‑step evidence gathering.
  - `r-analysis`: R / Quarto pipeline edits and statistical code changes.
  - `automation`: Shell, git, and terminal‑native execution.
  - `guard`: Safety checkpoints, regression control, and loop detection.

## Key Features

- **Section‑based skills**: Skills are organized around manuscript sections (introduction, literature review, methods, results, discussion) rather than paper “types”.

- **Specialized reviewer system**: Three distinct reviewer agents provide triangulated feedback that is richer than a single generic reviewer.

- **Writer Instruction Packets (WIP)**: Planner sends Writer highly structured packets (task type, section, paragraph skeleton, evidence, placeholders, and skills) to keep drafting grounded in evidence.

- **Guarded automation**: Guard enforces checkpoint and anti‑loop rules; only a small subset of agents can commit or run mutating git commands (and even then, only with “ask” permission).

- **Magic Context**: A context management plugin that replaces default compaction with cache‑aware summarization and long‑term memory.

- **MCP‑backed literature search**: OpenAlex and Semantic Scholar MCP servers provide structured academic metadata and PDFs for the literature-reviewing agents.

## Installation & Setup

### Prerequisites

- Node.js (for `npx`-based MCP servers and optional plugins).
- Access to at least one LLM provider configured in `auth.json` (e.g., OpenRouter, Mistral, Opencode-go).
- Bash shell (for `mcp_keys.sh`).

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

Remove providers you don’t use (e.g., `huggingface`, `ollama-cloud`) to keep things clean.

### 3. Configure MCP API keys

Create `~/.config/opencode/mcp_keys.sh`:

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

Make it non‑world‑readable and don’t commit it:

```bash
chmod 600 ~/.config/opencode/mcp_keys.sh
echo "mcp_keys.sh" >> ~/.config/opencode/.gitignore  # if you track that directory
```

### 4. Launch OpenCode with MCP keys

In your shell rc (e.g., `.zshrc`):

```bash
source ~/.config/opencode/mcp_keys.sh
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
  "@cortexkit/opencode-magic-context"
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
    "model": "opencode-go/qwen3.5-plus"
  },
  "dreamer": {
    "model": "opencode-go/qwen3.5-plus",
    "pin_key_files": { "enabled": true },
    "user_memories": { "enabled": true }
  }
}
```

Magic Context then runs automatically; no further config in this repo is needed.

## Usage

### Basic Commands

- Invoke agents directly:
  - `@writer "Draft the introduction section for a paper on X"`
  - `@literature-reviewer "Find recent papers on Y"`
  - `@r-analysis "Refactor this R/Quarto analysis pipeline"`
- Request checkpoints:
  - `"guard checkpoint"` or `"run guard"`
- Switch workflow modes:
  - `"high-control mode"` or `"autonomous batch mode"`

### Workflow Modes

- **High‑Control Mode** (default): Planner pauses for approval at outline, topic‑sentence planning, large structural rewrites, major methods/results/discussion changes, and before executing reviewer‑suggested fixes.
- **Autonomous Batch Mode**: Planner runs end‑to‑end until a guard checkpoint, loop signal, or blocker requires intervention.

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

### Current Model Assignments (summarized)

Actual model names live only in `opencode.json`, but at a high level:

- Planner / Editor / Reviewer‑Detail / Deep‑Research / Build: strong reasoning/coding models from the same family.
- Writer / Automation / R‑Analysis: cost‑effective general models (Qwen family) tuned for drafting or code.
- Copyeditor: mid‑sized model optimized for prose cleanup.
- Guard: cheaper model adequate for safety and regression checks.
- Literature‑reviewer: mid‑sized model good at search‑plus‑summarize.

See `opencode.json` for the exact mappings.

### MCP Servers

MCP servers are attached per‑agent (not globally) in `opencode.json`:

- **Context7** (`@upstash/context7-mcp`)
  - Agents: `build`, `r-analysis`
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

The core manuscript revision pipeline is:

1. **Identify Manuscript**
   - Planner locates the manuscript file, reads relevant sections, and determines scope (whole document vs. specific section).

2. **Launch Reviews**
   - Planner delegates simultaneously to:
     - `reviewer-structure`
     - `reviewer-detail`
     - `copyeditor`

3. **Collate Edits**
   - Planner passes all reviewer outputs to `editor`, which produces a **Chronological Edit List** describing what to change where.

4. **Checkpoint & Mode‑Dependent Handling**
   - In **High‑Control Mode**: Planner presents the edit list plus an execution plan to the user and waits for approval.
   - In **Autonomous Batch Mode**: Planner compiles WIP(s) from the edit list and delegates to `writer`, then triggers a `guard` checkpoint.

5. **Write & Commit**
   - Writer applies edits or drafts new text according to the WIP.
   - Guard checks for regressions, loops, and placeholder discipline.
   - Planner/Automation/R‑Analysis may propose git commits (always with “ask” permission).

## Extending the System

### Adding Custom Skills

1. Create a new directory under `skills/`.
2. Add a `SKILL.md` describing the skill and any conventions.
3. Reference the skill from `STYLE.md` or agent prompts as needed.

### Adding Snippet Examples

1. Create markdown files in the `snippet/` directory.
2. Use `#snippet-name` tags in skills or messages to inject examples via the `opencode-snippets` plugin.
3. Look at existing snippets for formatting and naming conventions.

### Modifying Agent Permissions

Adjust the `permission` blocks in `opencode.json`:

- `edit`: allow/deny file editing.
- `webfetch`: allow/deny `webfetch` calls.
- `bash`: fine‑grained bash permissions (including specific `git` commands).
- `external_directory` & `read`: control what parts of your filesystem agents can see.
