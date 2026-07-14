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
- `automation` — shell-level commits, git workflow automation (planner delegates commits here)
- `r-analysis` — commits pipeline changes when appropriate

Agents barred from committing (via `git commit *: deny`):
- `planner`, `writer`, `editor`, `reviewer-structure`, `reviewer-detail`, `copyeditor`, `literature-reviewer`, `deep-research`

**Planner commit delegation**: When planner needs to commit (e.g., before launching reviewers), it delegates to `automation` with explicit commit instructions rather than committing directly.

## Git commands that trigger GPG signing

Any command that creates a signed commit requires the warm-up:
- `git commit`
- `git merge` (when creating a merge commit)
- `git cherry-pick`, `git revert`, `git am` (if used)
