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
| `editor` | primary | Launch reviewers, sort their output into chronological edit list |
| `reviewer-structure` | subagent | Big-picture critique: structure, arguments, impact |
| `reviewer-detail` | subagent | Detail critique: citations, conceptual clarity, argument issues |
| `copyeditor` | subagent | Prose review: titles, paragraphs, sentences, words, markdown compliance |
| `guard` | subagent | Safety checkpoints, regression control, loop detection |
| `literature-reviewer` | subagent | Fast literature search and source notes |
| `deep-research` | subagent | Exhaustive multi-step evidence gathering |
| `r-analysis` | primary | R / Quarto pipeline edits and statistical-code changes |

## Routing Table

| Task Type | Agent | Role |
|-----------|-------|------|
| Drafting or revising manuscript prose | `writer` | Writing only; use verified inputs |
| Manuscript review orchestration | `editor` | Launch reviewers, collate and sort outputs |
| Fast citation support or paper lookup | `literature-reviewer` | Retrieval only; structured source notes |
| Exhaustive, conflicting, or multi-hop research | `deep-research` | Evidence mapping, coverage expansion |
| Big-picture review | `reviewer-structure` | Structure, arguments, impact critique |
| Detail review | `reviewer-detail` | Citations, conceptual clarity, argument issues |
| Prose review | `copyeditor` | Titles, paragraphs, sentences, words, markdown compliance |
| R / Quarto analysis edits | `r-analysis` | Analysis and pipeline changes |
| Shell / git / repo automation | `automation` | Command-line execution |
| Safety, regression, loop monitoring | `guard` | Auto-triggered or user-requested |

## Workflow Modes

**Default**: High-Control Mode. Use this unless the user explicitly requests autonomous batch mode.

### High-Control Mode
Pause for approval at:
- outline creation
- topic-sentence planning
- large structural rewrites
- reviewer-suggested fixes before implementation
- substantial methods, results, or discussion edits

Use when the task is ambiguous, high-stakes, or the user requests supervision.

### Autonomous Batch Mode
Continue until:
- a guard checkpoint is triggered
- a loop signal is detected
- a blocker requires clarification
- the user stops the workflow

Use when the task is well-scoped and routine enough to execute end to end.

## Anti-Loop Policy

### Planner stop-loss rules
Interrupt and reroute when any of the following occurs:
- 2 failed attempts to locate a file or directory without broadening scope
- 3 semantically similar grep/find/rg/search attempts with no useful hit
- repeated tool calls in the same path with no new evidence
- no material state change after 4 tool calls in a row
- an agent repeats a previously failed strategy without explaining why it should now work

### Guard escalation rules
Guard flags:
- repeated rewrite loops in the same section
- repeated low-information tool-use patterns
- wrong-directory or wrong-pattern probing that continues after failure
- oscillation between prior states without net improvement

### Delegation-time prevention (mandatory)
Every agent delegation must include explicit stop-loss limits:
- max 6 tool calls unless user-approved
- stop after 2 failed path/file lookups
- stop after 3 similar search attempts without useful hit
- stop after 4 calls with no new material evidence/state change
- If a strategy fails once, do not repeat without changing scope and explaining why.
- When a limit triggers, return immediately with a blocker report containing:
  - objective
  - attempts made
  - evidence found
  - blocker
  - recommended next step (reroute / broaden search / ask user)

## Checkpoint Schedule

Guard is auto-triggered after:
1. outline generation
2. first full draft of a major section or manuscript
3. reviewer-fix application
4. major refactors of methods, results, or discussion
5. branch-wide automated rewrites
6. any suspected loop or thrashing pattern

## Research Separation

- `literature-reviewer` is for fast retrieval, source discovery, and concise per-source notes.
- `deep-research` is for exhaustive coverage, conflicting literatures, and multi-hop evidence gathering.
- `writer` consumes research outputs but does not replace retrieval.
- `reviewer-structure`, `reviewer-detail`, `copyeditor` critique claims and support but do not act as primary search agents.

## Anti-Fabrication Rules

### Mandatory rules
1. No invented numbers.
2. No invented citations.
3. No invented findings.
4. No silent reinterpretation.

### Placeholder discipline
Use explicit placeholders for unresolved content:
- `<!-- TODO: compute X -->`
- `<!-- TODO: cite -->`
- `<!-- TODO: verify -->`
- `<!-- TODO: describe -->`

Placeholders must be preserved until resolved by evidence or explicit user instruction.

### Agent-specific enforcement
- `writer`: use placeholders instead of inventing content
- `literature-reviewer`: never invent metadata or summaries
- `deep-research`: report coverage limits and conflicts explicitly
- `reviewer-structure`, `reviewer-detail`, `copyeditor`: flag unsupported claims and missing placeholders
- `r-analysis`: describe only actual outputs or clearly marked uncertainties
- `guard`: detect fabrication risk and placeholder loss

## Git Workflow

- Prefer branch-first work for risky changes.
- Commit after meaningful milestones.
- Run guard before finalizing risky changes.
- Prefer merge commits unless the user explicitly requests squash cleanup.

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