# Git Workflow

Solo-owner hybrid of gitflow and gitlabflow:

- `main` is the development branch
- `refactor` is the primary feature/development branch
- Stable release branches are created only when needed (rare)
- Hotfix branches are created only when needed (very rare)
- Feature branches use a descriptive name only — no `feature/` prefix
- If two refactors are concurrent, use separate descriptive branches
- **When working on `refactor`: if `refactor` is behind `main`, rebase `refactor` on top of `main` so the feature is always able to be gracefully applied with a merge of `refactor` to `main`**

Commit style:
- Atomic commits, subject ≤50 characters, verb-first
- No subject-line prefixes (`feat:`, `fix:`, `refactor:`) — the verb is enough
- Descriptive body when detail is needed, wrapped at 72 characters
- The `git graph` alias is available: `git log --all --graph --oneline`

Good: `Add ensemble reviewer architecture`
Bad:  `feat: add ensemble reviewer architecture`
Bad:  `Add ensemble reviewer architecture for manuscript workflow` (too long)

Commit delegation:
- `automation` and `r-coder` may run `git commit` (permission: ask)
- `planner` is barred from committing — delegates to `automation`
- All other agents are barred from committing
- Before delegating to read-only agents, `planner` must delegate a `git status` check to `automation` and ensure any pending changes are committed atomically
- Suggest an atomic commit checkpoint after substantial writes

Merge strategy:
- Prefer true merge commits over squash cleanup unless the user explicitly requests squash

### Rewriting History Safely (git ≥ 2.54)

The `git history` experimental command provides atomic, conflict-safe history
rewriting without manual rebase gymnastics:

```bash
# Fold staged changes into an old commit (auto-rebases all branches)
git history fixup <commit>

# Reword a past commit message
git history reword <commit>

# Split one commit into two interactively
git history split <commit>
```

All three commands are atomic — they abort cleanly if conflicts arise, never
leaving the tree half-broken. `reword` and `split` don't touch the working
tree or index at all, so you can rewrite commits on a branch you don't have
checked out.

These are safer alternatives to `git rebase -i` for simple fixups and
message rewrites. For complex multi-commit reorganizations, interactive
rebase is still the right tool.
