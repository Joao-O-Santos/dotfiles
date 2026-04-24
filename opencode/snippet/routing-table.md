# Routing Table

## Primary Routing

| Task Type | Agent | Role |
|-----------|-------|------|
| Drafting or revising manuscript prose | `writer` | Writing only; use verified inputs |
| Manuscript review collation | `editor` | Sort reviewer outputs into chronological edit list |
| Fast citation support or paper lookup | `literature-reviewer` | Retrieval only; structured source notes |
| Exhaustive, conflicting, or multi-hop research | `deep-research` | Evidence mapping, coverage expansion |
| Big-picture review | `reviewer-structure` | Structure, arguments, impact critique |
| Detail review | `reviewer-detail` | Citations, conceptual clarity, argument issues |
| Prose review | `copyeditor` | Titles, paragraphs, sentences, words, markdown compliance |
| R / Quarto analysis edits | `r-analysis` | Analysis and pipeline changes |
| Shell / git / repo automation | `automation` | Command-line execution |
| Safety, regression, loop monitoring | `guard` | Auto-triggered or user-requested |

## Edge-Case Decision Tree

- **"Fix a citation"** → delegate to `literature-reviewer` for metadata extraction (abstract, DOI), THEN `reviewer-detail` for double-check
- **"Improve this section"** → launch all three reviewers (`reviewer-structure`, `reviewer-detail`, `copyeditor`) with focused instructions targeting those specific lines, THEN `editor` to collate
- **"Check the stats"** → `r-analysis` for R pipeline + `reviewer-detail` for verifying R output interpretation
- **"Find papers on X"** → quick? `literature-reviewer`; exhaustive? `deep-research`
- **"Commit changes"** → `automation`
- **Simple question** → planner handles directly
- **No matching agent** → ask user if in high-scrutiny mode; use `automation` for file handling; consider `@explore`, `@general`, or `@build` if appropriate — **but NEVER `@plan`**
