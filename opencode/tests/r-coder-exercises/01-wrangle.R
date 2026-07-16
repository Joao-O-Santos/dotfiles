# Exercise: Data Wrangling

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

## Expected Style

- Tabs for indentation, spaces for alignment
- Base R pipes `|>`, not `%>%`
- `ds` for main dataset, `voi` for subsets
- `coi` for column vectors
- ≤80 char lines
- Sparse comments (only non-obvious decisions)

## Evaluation Criteria

- [ ] Script runs without errors
- [ ] Follows coding_style.md conventions
- [ ] Uses `ds` for main dataset
- [ ] Pipes end at line end, not start
- [ ] Comments explain WHY, not WHAT

## Metrics

- Time to working script: ___
- Number of fix iterations: ___
- Style violations: ___
- Does report.qmd render? ___
