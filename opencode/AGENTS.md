# AGENTS.md – Global Registry and Workflow Rules

This file defines the agent roster, routing logic, workflow modes, checkpoint rules, anti-loop controls, and anti-fabrication policy for the OpenCode Manuscript Workflow.

## Configuration Authority

- `opencode.json` is the single source of truth for model selection, fallbacks, permissions, and runtime configuration.
- `AGENTS.md` is the single source of truth for agent responsibilities, routing policy, workflow modes, checkpoint rules, anti-loop policy, anti-fabrication rules, and conflict resolution.

If this file and `opencode.json` disagree about runtime behavior, `opencode.json` wins.

## Agent Roster

| Agent | Mode | Responsibility |
|-------|------|----------------|
| `planner` | primary | Orchestrator, task decomposition, routing, workflow-state management |
| `automation` | primary | Shell, git, and terminal-native execution |
| `writer` | primary | Manuscript drafting and revision (instruction-following) |
| `editor` | subagent | Sort reviewer outputs into chronological edit list |
| `reviewer-structure` | subagent | Big-picture review: structure, arguments, impact |
| `reviewer-detail` | subagent | Detail review: citations, conceptual clarity, argument issues |
| `copyeditor` | subagent | Prose review: titles, paragraphs, sentences, words, markdown compliance |
| `guard` | subagent | Safety, regression, loop detection |
| `literature-reviewer` | subagent | Fast literature search and source notes |
| `deep-research` | subagent | Exhaustive multi-step evidence gathering |
| `r-analysis` | primary | R / Quarto pipeline coding and editing |

#anti-fabrication-short

#placeholder-discipline

## Agent Capabilities

- **Can edit files**: `automation`, `writer`, `r-analysis` (all others read-only)
- **Can run arbitrary shell**: `automation`, `r-analysis` (others: global read-only only)
- **Can spawn subagents**: `planner` only (via `task` tool)
- **Can commit**: `automation`, `r-analysis` (requires user approval; others: denied)
- **Can push**: none (user handles all remote operations manually)
- **Local literature index**: `literature-reviewer` and `deep-research` have access to `~/lit/_index.db` (SQLite + FTS5) and `~/lit/_index.md`. See `snippet/lit-index.md`.
- **MCP servers**: all agents have access to Context7, Citecheck, OpenAlex, Semantic Scholar (globally configured)

## Delegation Guide

| Task | Delegate to |
|------|------------|
| Shell commands, git, file ops, installs | `automation` |
| Writing prose (sections, edits) | `writer` |
| R/Quarto pipeline, stats | `r-analysis` |
| Code exploration, file search | built-in `explore` |
| Building software, writing scripts | built-in `build` |
| General questions | built-in `general` |

Never delegate manuscript workflow tasks (review, research, drafting) to built-in agents.

## User Invocation

- Direct invocation: `@agentname`
- Mode switching: "high-control mode", "autonomous batch mode"
- Checkpoint request: "guard checkpoint" or "run guard"

## Conflict Resolution

When agents disagree:
1. planner gathers positions
2. planner presents options
3. user decides
4. rationale is documented in comments or commit messages

This file governs workflow behavior. Runtime configuration belongs in `opencode.json`.
