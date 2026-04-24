# Git Workflow

Solo-owner hybrid of gitflow and gitlabflow:

- `main` is the development branch
- `refactor` is the primary feature/development branch
- Stable release branches are created only when needed (rare)
- Hotfix branches are created only when needed (very rare)
- Feature branches use a descriptive name only — no `feature/` prefix
- If two refactors are concurrent, use separate descriptive branches
- **When working on `refactor`: if `refactor` is behind `main`, rebase `refactor` on top of `main` so the feature is always able to be gracefully applied with a merge of `refactor` to `main`**

Commit style (kernel-inspired):
- Atomic commits with very short subjects
- Descriptive body when detail is needed
- The `git graph` alias is available: `git log --all --graph --oneline`

Commit delegation:
- `planner`, `automation`, and `r-analysis` may run `git commit` (permission: ask)
- All other agents are barred from committing
- Before delegating to read-only agents, `planner` must check `git status` and commit any pending changes atomically
- `guard` should suggest an atomic commit checkpoint after substantial writes

Merge strategy:
- Prefer true merge commits over squash cleanup unless the user explicitly requests squash
