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
| `editor` | subagent | Collates reviewer outputs, categorizes by consensus level |
| `reviewer-structure` | subagent | Big-picture review: structure, arguments, impact |
| `reviewer-structure-2` | subagent | Adversarial second structural critique (checkpoints only) |
| `reviewer-detail` | subagent | Detail review: citations, conceptual clarity, argument issues |
| `copyeditor` | subagent | Prose review: titles, paragraphs, sentences, words, markdown compliance |
| `literature-reviewer` | subagent | Fast literature search and source notes |
| `deep-research` | subagent | Exhaustive multi-step evidence gathering |
| `r-analysis` | primary | R / Quarto pipeline coding and editing |
| `strategist` | subagent | Gated arbitration for disputed or non-obvious fixes |

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
- **Mechanical checks**: `chkdrft` (citations needed, TODOs left) handles placeholder/citation tracking. Run via `automation` before commits or on demand. Step limits in opencode.json handle loop prevention.

## Delegation Guide

| Task | Delegate to |
|------|------------|
| Shell commands, git, file ops, installs | `automation` |
| Writing prose (sections, edits) | `writer` |
| R/Quarto pipeline, stats | `r-analysis` |
| Code exploration, file search | built-in `explore` |
| Building software, writing scripts | built-in `build` |
| General questions | built-in `general` |
| Mechanical checks (TODOs, citations) | `automation` (run `chkdrft`) |

Never delegate manuscript workflow tasks (review, research, drafting) to built-in agents.

## User Invocation

- Direct invocation: `@agentname`
- Mode switching: "high-control mode", "autonomous batch mode"
- Mechanical check: "run chkdrft" (counts citations needed, TODOs left)

## Conflict Resolution

When agents disagree:
1. planner gathers positions
2. planner presents options
3. user decides
4. rationale is documented in comments or commit messages

## Review Loop Types

Two review loop types exist:

**Fast Loop** (default, used for ordinary iterative draft↔revise
cycles): `reviewer-structure`, `reviewer-detail`, `copyeditor` run
independently, in parallel, with no cross-exposure between them.
Planner applies straightforward fixes directly. No `editor`,
`reviewer-structure-2`, or `strategist` involvement.

**Full Ensemble Checkpoint** (triggered at Checkpoint Schedule items
2, 3, 4, 5 — first full draft, reviewer-fix application, major
refactors, branch-wide rewrites): all four reviewer agents run
(`reviewer-structure`, `reviewer-structure-2`, `reviewer-detail`,
`copyeditor`), independently and in isolation from each other.
`editor` collates the four reports into consensus categories. Planner
then applies the Consensus Rule below. `strategist` is only called
for items `editor` flags as non-obvious or disputed.

## Consensus Rule (Full Ensemble Checkpoints only)

All escalated items are batched into a single `strategist` call per
checkpoint. Strategist receives only the Strategist Escalation Packet
packed by planner — it has no tools and makes no external calls.

- **Consensus Issues** (flagged by ≥2 reviewers, per `editor`'s
  report): auto-apply eligible in autonomous mode; presented as a
  batch for approval in high-control mode.
- **Single-Source Issues** (flagged by exactly 1 reviewer): if the
  fix is mechanically obvious, planner may apply it directly. If not,
  route to `strategist` in the batched call. Otherwise, log as
  `<!-- TODO: reviewer flagged, unconfirmed -->` and do not apply
  without further confirmation.
- **Direct Disagreements**: always route to `strategist` (batched),
  never resolved by planner alone.
- **Strategist override rule**: planner may push back on a
  `strategist` decision only by citing a specific artifact — a git
  diff, or a Magic Context memory (category `REVIEW_DECISIONS`,
  planner-written upon strategist receipt) retrievable via
  `ctx_search`. A re-argued opinion without new evidence does not
  qualify as grounds for override.
- **Stop-loss**: max 2 strategist calls per checkpoint (initial +
  one context-request follow-up). Items unresolved after that become
  `<!-- TODO: reviewer flagged, unconfirmed -->`.

This file governs workflow behavior. Runtime configuration belongs in `opencode.json`.
