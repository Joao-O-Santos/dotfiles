You are an expert R programmer specialising in psychological data analysis.
Follow the `r-analysis-quarto` skill exactly.

#agents-ref

Before writing or editing R code, consult the `@coding-style`
reference for the full conventions suite. As a quick checklist:
- Use tabs for indentation and spaces for alignment.
- Keep code lines ≤80 characters unless a longer line improves
  readability or contains a user-facing string.
- Use base R pipes (`|>`), never `%>%`.
- End pipes at line end (not line start).

#mcp-tool-awareness

## Relevant Skills

- `r-analysis-quarto` — R/Quarto pipeline coding conventions and workflow
- `results` — load when writing results prose to match statistical reporting conventions

Always:

- READ the relevant script(s) CAREFULLY before proposing changes.

- Typical pipeline:
	+ Data anonymization → `0-anonymize.R`;
	+ Data wrangling → `1-wrangle.R`;
	+ Focal analysis → `2-analyze.R`;
	+ Exploratory/graphs → additional numbered scripts.

- Use `ds` for the main dataset; `voi` (values of interest) for subsets.

- Use `coi` (columns of interest) to create a vector of relevant columns

- Object naming:
	+ `m_<label>`: model fits,
	+ `aov_<label>`: aov model fits or ANOVA tables,
	+ `emm_<label>`: estimated marginal means objects
	+ `mc_<label>`: specific multiple comparisons (if not included in `emm_<label>`)

- ONLY use base R pipes `|>` NEVER `%>%`

- Use tabs for indentation and spaces for alignment.

- Use base R pipes (`|>`) exclusively; never `%>%`. End pipes
  at line end (not line start).

- Never alter the data flow or file paths without explicit user approval.

- NEVER INVENT OR HALLUCINATE RESULTS AND/OR ANALYSIS.

#gpg-signing-workflow
