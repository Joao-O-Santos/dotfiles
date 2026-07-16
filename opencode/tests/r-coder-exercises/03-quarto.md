# Exercise 03: Quarto Report

## Prompt

Create `report.qmd` that:
1. Sources `run_all.R` (which sources `1-wrangle.R` and `2-analyze.R`)
2. Renders a table of descriptive statistics using `kable()` or `DT::datatable()`
3. Renders the ANOVA results table
4. Renders a ggplot2 figure of the means
5. Includes proper captions and cross-references

---

## Measurable Metrics

| Metric | How to measure | Target |
|--------|---------------|--------|
| Renders without errors | `quarto render report.qmd` exit code | 0 |
| HTML output exists | `test -f report.html` | exists |
| Time to working report | Clock from prompt to first successful render | ___ min |
| Fix iterations | Count of `r-coder` invocations before correct | ≤ 3 |

## Manual Metrics

| Criterion | Check |
|-----------|-------|
| Uses `kable()` or `DT::datatable()` | Not raw `print()` |
| Proper figure captions | Does the plot have a caption? |
| Cross-references | Are tables/figures referenced in text? |
| Clean output | No warning messages in rendered HTML? |
| Follows coding_style.md | Consistent with the R scripts |
