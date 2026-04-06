## 1. Statistical Reporting and Results Prose

- Base all statistical descriptions on **actual model objects and outputs** from scripts like `2-analyze.R`, preregistration scripts, and Quarto reports; do not invent numbers or patterns.
- **Lead with meaning**, then show evidence:
  - e.g., “There was strong evidence that egocentric discounting was greater when the advisor was an AI than a human, *F*(1, …) = …” rather than a bare list of statistics.
- Conventions:
  - Present tense for inferential statements.
  - “Significant evidence that X is higher than Y” instead of “X is significantly higher than Y.”
  - Avoid “participants differed significantly”; talk about effects or variables, not people.
  - Use estimated marginal means to break down main effects and interactions, and describe them in prose before or while referring to tables.
- For linear mixed models or GLMs, mention:
  - Fixed‑effect structure first, then random‑effects structure, following a maximal‑model‑then‑simplify approach.
  - How key contrasts or multiple comparisons were obtained (e.g., via `emmeans` and `pairs()` on specific grids).

## 2. R Analysis and Quarto Integration – Style Glue

- Treat the pipeline `0-anonymize.R → 1-wrangle.R → 2-analyze.R → 3-extra_analysis.R → run_all.R → report.qmd` as the **single source of truth** for data handling and analyses.
- Do not change analysis logic silently when revising text; instead, propose code changes explicitly and keep writing synced with updated outputs.
- When writing methods or results, map each described operation or model to a **named object** in the scripts (e.g., `m_h1h2`, `emm_h3`, `mc_h4_2`) and ensure terminology matches the object’s role.
- Use **Quarto** (`report.qmd`) as the main vehicle to:
  - Render key descriptive plots and model summaries.
  - Produce publication‑ready tables (e.g., via helper functions like `pretty_table()` and `kable`‑like outputs) that the paper can adapt rather than copy blindly.

## 3. Collaboration with the User

- At the start of a project, confirm scope and constraints (target journal, word limit, deadline, how much freedom there is to reorganize sections).
- Before large rewrites, provide or summarize:
  - A **topic‑sentence outline** for new work, or
  - A **reverse outline** for existing drafts, including notes about gaps, redundancy, and possible reordering.
- Defer to the user on substantive choices such as:
  - Which limitations to emphasize.
  - Desired strength of claims (e.g., “suggests” vs “demonstrates”).
  - Which secondary analyses (from `3-extra_analysis.R`) belong in the main text versus supplements or footnotes.
