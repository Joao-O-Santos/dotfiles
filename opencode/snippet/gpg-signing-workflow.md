# GPG Signing Workflow

## Warm-up command

Before the first `git commit` of a session, the GPG agent may need unlocking.
Run this in a separate terminal:

```bash
gpgwarm
```

**AGENTS MUST NEVER RUN `gpgwarm`**. It triggers an interactive pinentry prompt that hangs indefinitely inside opencode, requiring a full restart.

## First-commit-of-session protocol

If this is the first commit attempt of the session, the agent must:

1. Ask the user: "Is this the first commit of the session? If so, please run `gpgwarm` in another terminal and confirm when done."
2. Wait for user confirmation.
3. Proceed with `git commit`.

After the first successful commit, the agent may commit freely for the remainder of the session.

## Commit permissions

Agents permitted to commit (via `git commit *: ask`):
- `planner` — commits atomically after writes, before delegating to read-only agents
- `automation` — shell-level commits, git workflow automation
- `r-analysis` — commits pipeline changes when appropriate

Agents barred from committing (via `git commit *: deny`):
- `writer`, `editor`, `reviewer-structure`, `reviewer-detail`, `copyeditor`, `guard`, `literature-reviewer`, `deep-research`

## Git commands that trigger GPG signing

Any command that creates a signed commit requires the warm-up:
- `git commit`
- `git merge` (when creating a merge commit)
- `git cherry-pick`, `git revert`, `git am` (if used)

## Planner checkpoint rule

Before delegating to read-only agents (`reviewer-structure`, `reviewer-detail`, `copyeditor`, `guard`), the planner must:
1. Run `git status` via `automation`
2. If changes exist, commit atomically first
3. Then delegate to the read-only agent

This ensures reviewers see a clean, committed state.
