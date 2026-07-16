# Exercise 01: Data Wrangling

## Prompt

Given a dataset at `../data/raw_ds.csv` with columns:
- `ProlificID`, `Age`, `Gender`, `Education`
- `Rating1`, `Rating2`, `Rating3` (7-point Likert scales)
- `Condition` (A, B, C)
- `AttentionCheck` (1 = passed, 0 = failed)

Write `1-wrangle.R` that:
1. Removes participants who failed the attention check
2. Creates a participant ID column (`pp`)
3. Pivots ratings to long format
4. Computes mean rating per participant per condition
5. Saves to `../data/wrangled_ds.csv`

---

## Measurable Metrics (counted automatically)

| Metric | How to measure | Target |
|--------|---------------|--------|
| Script runs without errors | `Rscript 1-wrangle.R` exit code | 0 |
| Time to working script | Clock from prompt to first successful run | ___ min |
| Fix iterations | Count of `r-coder` invocations before correct | ≤ 3 |
| Report renders | `quarto render report.qmd` exit code | 0 |

## Manual Metrics (you judge)

| Criterion | Check |
|-----------|-------|
| Uses `ds` for main dataset | Does the script use `ds` as the primary variable name? |
| Uses `matches()` or tidyverse `select()` for column selection | Does it use `matches()` or tidyverse `select()`? |
| Tabs for indentation | Are indents tabs, not spaces? |
| Pipes: first function gets ds as argument, rest piped at line end | Does first function take `ds` as argument; does `\|>` appear at end of line, not start? |
| ≤80 char lines | Are lines wrapped at 80 chars? |
| Sparse comments | Comments explain WHY, not WHAT? |
| Follows coding_style.md | Does it match the conventions in coding_style.md? |
