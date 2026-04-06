# AGENTS.md – Global Registry and Workflow Rules

This file defines the agent roster, routing logic, workflow modes, checkpoint schedule, and anti-fabrication rules for the OpenCode Manuscript Workflow.

## Agent Roster

| Agent | Mode | Model | Fallback | Responsibility |
|-------|------|-------|----------|----------------|
| `planner` | primary | `opencode/qwen3.6-plus-free` | `openrouter/qwen/qwen3.6-plus:free` | Orchestrator, task decomposition, routing (delegates to specialists) |
| `automation` | primary | `openrouter/xiaomi/mimo-v2-flash` | `openrouter/minimax/minimax-m1` | Direct shell/git automation (not routed through planner); agentic tool-calling optimized |
| `writer` | subagent | `mistral/mistral-small-latest` | `mistral/mistral-small-latest` | Unified manuscript drafting (empirical/theoretical) |
| `reviewer` | subagent | `mistral/mistral-large-latest` | `mistral/mistral-large-latest` | Critique and revision memos |
| `guard` | subagent | `opencode/qwen3.6-plus-free` | `openrouter/qwen/qwen3.6-plus:free` | Safety checkpoints and regression control |
| `literature-review` | subagent | `google/gemini-3.1-flash-lite-preview` | – | Fast academic search and paper summaries |
| `deep-research` | subagent | `openrouter/alibaba/tongyi-deepresearch-30b-a3b` | `openrouter/google/gemini-2.5-pro` | Exhaustive multi-step research via Tongyi DeepResearch |
| `r-analysis` | subagent | `openrouter/qwen/qwen3-coder:free` | `openrouter/qwen/qwen3-coder` | R/Quarto pipeline edits; code-generation optimized |

## Routing Table

| Task Type | Agent | Skill | Notes |
|-----------|-------|-------|-------|
| Empirical manuscript drafting | `writer` | `empirical-paper` | Load skill based on paper type |
| Theoretical manuscript drafting | `writer` | `theoretical-paper` | Load skill based on paper type |
| Literature search (fast) | `literature-review` | `literature-review` | Gemini Flash 3.1 online; quick citation lookups |
| Literature search (deep) | `deep-research` | `deep-research` | Tongyi DeepResearch; systematic reviews and exhaustive coverage |
| R/Quarto pipeline edits | `r-analysis` | `r-analysis-quarto` | Follow pipeline conventions |
| Shell/git automation | `automation` | `automation-cli` | Direct bash access; use oksh helpers |
| Critique/revision memos | `reviewer` | (read-only) | Milestone-based invocation |
| Safety checkpoints | `guard` | (auto-triggered) | Visible reports |

## Workflow Modes

### High-Control Mode
- **Pause points**: Outline creation, topic sentence planning, large structural rewrites, reviewer-suggested fixes, substantial results/discussion edits.
- **Use when**: User explicitly requests supervision, task is ambiguous/high-stakes, or user is actively supervising.
- **Behavior**: Planner pauses and asks for user approval before proceeding past pause points.

### Autonomous Batch Mode
- **Continue until**: Guard checkpoint triggered, user stops workflow, or major ambiguity blocks safe progress.
- **Use when**: Task is clearly scoped, user requests batch execution, or workflow is in a routine phase (e.g., applying reviewer fixes).
- **Behavior**: Planner continues routing and execution without pauses, but still triggers guard checkpoints.

### Mode Detection
Planner detects mode based on:
- Explicit user request (e.g., "high-control mode", "batch mode")
- Task ambiguity (high ambiguity → high-control)
- Task scope (large scope → suggest mode to user)
- User engagement (active supervision → high-control; hands-off → autonomous)

## Checkpoint Schedule

Guard is **auto-triggered** by planner after:

1. **Outline generation**: After first topic-sentence outline is created.
2. **First full draft**: After initial draft of a major section or full manuscript.
3. **Reviewer-fix application**: After reviewer-suggested fixes are applied.
4. **Major refactors**: After substantial rewrites of Methods/Results/Discussion sections.
5. **Branch-wide rewrites**: After any automated rewrite affecting >50% of manuscript files.

### Checkpoint Report Requirements
Guard produces a **visible report** containing:
- Timestamp and branch/commit info
- Changes since last checkpoint (lines changed, similarity scores)
- Warnings (loops, reversions, placeholder issues)
- Recommendations (proceed/commit/rollback)

## Git Workflow

### Branch-First Pattern
- Create task branches: `agent/intro-v2`, `agent/results-v2`, `fix/citations`, etc.
- Keep `main`/`master` stable; experiment in branches.

### Milestone Commits
- Commit after meaningful milestones:
  - Outline finalized
  - First draft completed
  - Reviewer feedback incorporated
  - Major section rewritten
- Use explicit commit messages: "Add Methods section draft", "Apply reviewer fixes to Discussion".

### Guard Integration
- Run guard before finalizing risky changes.
- Incorporate guard feedback or recommend revert.
- Enable rollback/revert advice when a branch becomes unstable.

### Merge Strategy
- Prefer merge commits over rebasing for manuscript branches (preserve history).
- Squash only when explicitly requested for cleanup.

## Anti-Fabrication Rules (Canonical)

### Mandatory Rules
1. **No invented numbers**: Never fabricate statistical results, p-values, sample sizes, or effect sizes.
2. **No invented citations**: Never fabricate references, DOIs, or paper findings.
3. **No invented findings**: Never fabricate paper-specific results or conclusions.
4. **No silent reinterpretation**: Never alter analysis intent without user approval.

### Placeholder Discipline
- Mark all missing content with explicit placeholders:
  - `<!-- TODO: compute X -->` for missing statistics
  - `<!-- TODO: cite -->` for missing references
  - `<!-- TODO: verify -->` for uncertain claims
  - `<!-- TODO: describe -->` for missing methodological details
- Placeholders must be **explicit** about what's missing.
- Placeholders must be **preserved** through revisions unless resolved.
- Placeholders must be **resolved by user**, not guessed by agents.

### Agent-Specific Enforcement
- **Writer**: Inserts placeholders; never fabricates to fill gaps.
- **Reviewer**: Flags unsupported claims and missing placeholders.
- **R-analysis**: Bases all descriptions on actual R outputs.
- **Literature-review**: Never invents citations or summaries.
- **Guard**: Scans for fabrication and placeholder preservation.

## Model Escalation Path

### Strategy
- **Free OpenCode for orchestration**: Planner uses `opencode/qwen3.6-plus-free` for routing decisions (lenient quota).
- **OpenRouter fallback**: If OpenCode quota exhausted, fall back to `openrouter/qwen/qwen3.6-plus:free`.
- **Specialized free/paid agents**: Writer, reviewer use free Nemotron; r-analysis/automation use free with paid fallback.
- **Paid specialists**: `literature-review` (Gemini Flash), `deep-research` (Tongyi DeepResearch).

### Tier 1: Free OpenCode (Orchestration) — Lenient Quota
- `planner`: `opencode/qwen3.6-plus-free` → `openrouter/qwen/qwen3.6-plus:free` (orchestration, routing)
- `guard`: `opencode/qwen3.6-plus-free` → `openrouter/qwen/qwen3.6-plus:free` (safety monitoring)

### Tier 2: Specialized Free/Paid (Execution)
- `writer`: `mistral/mistral-small-latest` (manuscript drafting)
- `reviewer`: `mistral/mistral-large-latest` (critique)
- `r-analysis`: `openrouter/qwen/qwen3-coder:free` → `openrouter/qwen/qwen3-coder` (R code, statistical analysis)
- `automation`: `openrouter/xiaomi/mimo-v2-flash` → `openrouter/minimax/minimax-m1` (shell/git, agentic tool-calling)
- `literature-review`: `openrouter/google/gemini-flash-1.5-8b` (fast web-augmented search)

### Tier 3: Paid Specialist (Deep Research)
- `deep-research`: `openrouter/alibaba/tongyi-deepresearch-30b-a3b` → `openrouter/google/gemini-2.5-pro` (exhaustive multi-step research)

### Escalation Triggers
- Complex routing decisions → planner fallback to Mistral Large
- High-stakes writing (Abstract, key Results) → writer may use paid model
- Ambiguous user requests → planner fallback
- Complex R code generation → r-analysis fallback to paid Qwen3-Coder
- Complex shell/git tasks → automation fallback to MiniMax M1
- Guard-flagged issues requiring judgment → planner fallback
- Exhaustive literature search → deep-research (Tongyi DeepResearch)

## Workflow State

Planner maintains awareness of:
- Current mode (high-control vs autonomous)
- Active branch and commit history
- Last checkpoint timestamp and guard report
- Open placeholders and their locations
- User preferences (e.g., "always pause before Results edits")

## User Invocation

- **Direct agent invocation**: Use `@agentname` (e.g., `@reviewer critique draft.md`).
- **Mode switching**: "high-control mode", "autonomous batch mode".
- **Checkpoint request**: "guard checkpoint" or "run guard".

## Conflict Resolution

When agents disagree:
1. **Planner mediates**: Gather positions from all agents.
2. **User decides**: Present options to user for final decision.
3. **Document**: Add decision rationale as comment or commit message.

This file is the single source of truth for agent behavior and workflow rules. Updates here cascade to all agents.
