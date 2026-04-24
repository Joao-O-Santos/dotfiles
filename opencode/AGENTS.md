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
| `r-analysis` | primary | R / Quarto pipeline edits and statistical-code changes |

#anti-fabrication-short

#placeholder-discipline

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
