---
name: r-analysis-quarto
description: Use when the task involves editing, debugging, or extending the R analysis pipeline (numbered scripts, run_all.R, report.qmd).
---

# Skill: r-analysis-quarto

Maintain and extend the R analysis pipeline so that it stays reproducible, readable,
and aligned with the project's house style.

#style-core

## Project layout

Scripts live under `project/scripts/`; data under `project/data/`.
Always reference data as `../data/<name>.csv` from inside the scripts directory.

Data flow (do not alter without approval):

1. `0-anonymize.R` → writes `../data/raw_ds.csv` (treat as documentation; rarely runnable)
2. `1-wrangle.R`   → reads `raw_ds.csv`, writes and re-reads `wrangled_ds.csv`
3. `2-analyze.R`   → reads `wrangled_ds.csv`, fits confirmatory models
4. Optional extra scripts (e.g. `3-graphs.R`, `4-model_selection.R`) → exploratory work and/or additional analysis that don't fit in 2-analyze.R
5. `run_all.R`     → sources the above in order, skipping `0-anonymize.R` by default
6. `report.qmd`    → sources `run_all.R`, prints objects via `knitr::kable()` / `DT::datatable()`

## R coding conventions

- Main dataset: `ds`. Subset when needed: `voi` (only when `ds` must survive).
- Object naming: models `m_<label>`, ANOVA tables `aov_<label>`, emmeans `emm_<label>`
- Use lists of specs to supply to get every emm and comparison emmeans,
  ex: `emmeans(m, list(~ 1, pairwise ~ A, pairwise ~ B, pairwise ~ A  B, pairwise ~ B | A))`
- Use base pipe `|>` only; never `%>%`.
- Pipes only when they materially improve readability.
- `snake_case` identifiers throughout.
- Indentation with tabs; alignment with spaces.
- First argument on the same line as the function call; later arguments aligned.
- Explicit `return()` at the end of functions.
- Function bodies ~24 lines; hard limit ~48.
- Code lines ~80 chars; comment/prose lines ~72 chars.
- Be very, very sparse with comments, document only non-obvious gotchas
  (e.g., `# Doing x here or otherwise y() will err`) or important
  decisions (`# Full model returned isSingular warning, this is the final model`)

For extended coding style guidance (tab size, spacing, function limits,
linting), see `coding_style.md` in this skill directory.

## Style conventions

- Treat the pipeline `0-anonymize.R → 1-wrangle.R → 2-analyze.R →
  3-extra_analysis.R → run_all.R → report.qmd` as the **single source
  of truth** for data handling and analyses.
- Do not change analysis logic silently when revising text; instead,
  propose code changes explicitly and keep writing synced with updated
  outputs.
- When writing methods or results, map each described operation or model
  to a **named object** in the scripts (e.g., `m_h1h2`, `emm_h3`,
  `mc_h4_2`) and ensure terminology matches the object's role.
- Use **Quarto** (`report.qmd`) as the main vehicle to:
  - Render key descriptive plots and model summaries.
  - Produce publication-ready tables (e.g., via helper functions like
    `pretty_table()` and `kable`-like outputs) that the paper can adapt
    rather than copy blindly.

## Collaboration with the user

#style-core
(scope confirmation, outline/reverse-outline before rewrites, deference
to user on substantive choices).

## Workflow

1. Classify the change: PII → `0-anonymize.R` only; cleaning/exclusions → `1-wrangle.R`;
   confirmatory → `2-analyze.R`; exploratory/robustness/graphs → additional numbered scripts.
2. Keep relative data paths unchanged.
3. Ensure all objects needed by `report.qmd` exist in the global env after `run_all.R`.
4. Update inline comments when sample sizes or exclusion counts change.

## Guardrails

- Do not alter the data flow without explicit user approval.
- Do not invent results; base all descriptions on concrete R output.
- Insert `# TODO: confirm` comments for any substantive analytical decisions.
