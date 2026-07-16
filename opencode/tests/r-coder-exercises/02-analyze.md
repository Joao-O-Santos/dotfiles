# Exercise 02: Mixed Model Analysis

## Prompt

Using `../data/wrangled_ds.csv` from Exercise 01, write `2-analyze.R` that:
1. Fits a mixed ANOVA with `afex::mixed()` — Condition (A/B/C) as between, Measure (pre/post) as within, random intercepts for pp
2. Computes estimated marginal means with `emmeans`
3. Runs pairwise comparisons with Tukey correction
4. Reports results in APA format (F, p, ηp²)

---

## Measurable Metrics

| Metric | How to measure | Target |
|--------|---------------|--------|
| Script runs without errors | `Rscript 2-analyze.R` exit code | 0 |
| Model converges | No warnings about singular fits or convergence | 0 warnings |
| Time to working script | Clock from prompt to first successful run | ___ min |
| Fix iterations | Count of `r-coder` invocations before correct | ≤ 3 |

## Manual Metrics

| Criterion | Check |
|-----------|-------|
| Uses `afex::mixed()` | Does it use afex, not base `aov()`? |
| Uses `emmeans` for post-hoc | Does it use emmeans, not manual contrasts? |
| Reports ηp² | Does it report partial eta squared? |
| Reports 95% CI | Does it include confidence intervals? |
| Follows coding_style.md | Tabs, pipes, ≤80 chars, `ds` naming |
| Comments explain decisions | Why this model? Why these contrasts? |
