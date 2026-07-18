---
name: r-analysis-quarto
description: Use when the task involves writing, refactoring, and/or debugging R code and Quarto reports (numbered scripts, run_all.R, report.qmd).
---

# Skill: r-analysis-quarto

Maintain and extend the R analysis pipeline so that it stays reproducible and
readable.

#style-core

## Project layout

The bundled `_quarto.yml` and `report.qmd` are project-specific examples, not
runnable global templates.

Scripts live under `project/scripts/`; data under `project/data/`.
Always reference data as `../data/<name>.csv` from inside the scripts directory.

Data flow (do not alter without approval):

1. `0-anonymize.R` → writes `../data/raw_ds.csv` (treat as documentation; rarely runnable)
2. `1-wrangle.R`   → reads `raw_ds.csv`, writes and re-reads `wrangled_ds.csv`
3. `2-analyze.R`   → reads `wrangled_ds.csv`, fits confirmatory models
4. Optional extra scripts (e.g. `3-graphs.R`, `4-model_selection.R`) → exploratory work and/or additional analysis that don't fit in 2-analyze.R
5. `run_all.R`     → sources the above in order, skipping `0-anonymize.R` by default
6. `report.qmd`    → sources `run_all.R`, prints objects via `knitr::kable()` / `DT::datatable()`

## R tool enforcement

Use r-air for formatting and jarl for linting. Enforce tabs for indentation.
Do not apply manual naming, pipe, comment, line-length, spacing, function-limit,
or other non-tab rules from `coding_style.md`; r-air and jarl defaults govern
source formatting and linting. Before formatting an R project, ensure its root
contains the canonical `air.toml` from this skill directory; copy it when
absent. After writing or editing R code, run `r-air format` and `jarl check` on
the file and fix issues they flag.

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

1. Classify the change: data anonymization → `0-anonymize.R` only;
   cleaning/exclusions → `1-wrangle.R`; confirmatory → `2-analyze.R`;
   exploratory/robustness/graphs → additional numbered scripts.
2. Keep relative data paths unchanged.
3. Ensure all objects needed by `report.qmd` exist in the global env after `run_all.R`.
4. Update inline comments when sample sizes or exclusion counts change.

## Guardrails

- Do not alter the data flow without explicit user approval.
- Do not invent results; base all descriptions on concrete R output.
- Insert `# TODO: confirm` comments for any substantive analytical decisions.
