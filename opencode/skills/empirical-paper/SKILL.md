---
name: empirical-paper
description: Use when writing or revising empirical manuscript sections (Abstract, Introduction, Method, Results, Discussion) from R and Quarto outputs.
---

# Skill: empirical-paper

Write and revise empirical manuscripts from completed analyses, following `/home/random_user/.config/opencode/STYLE.md`
and structure.md.

## Required context

Gather before drafting: study design, hypotheses, analysis artefacts (R objects,
`report.qmd` output), preregistration, target journal and word limits, any existing text.
If missing, ask or insert `<!-- TODO: ... -->` placeholders.

## Statistical reporting (APA 7 default)

- Italicise statistics: *t*, *F*, *p*, *M*, *SD*, *r*.
- p-values: three decimals, no leading zero (`p = .021`).
- Lead with substantive interpretation; statistics follow in parentheses.
- Never fabricate numbers. Mark missing quantities as `<!-- TODO: compute X -->`.
- Distinguish confirmatory (preregistered) from exploratory analyses explicitly.

## Workflow: three passes

1. **Outline pass** – topic-sentence outline per section; confirm with user.
2. **Draft pass** – fill paragraphs following `/home/random_user/.config/opencode/STYLE.md` hamburger structure.
3. **Revision pass** – tighten language, check statistical consistency and terminology.

## Guardrails

- Never fabricate data, p-values, sample sizes, or effect sizes.
- Never reinterpret results without surfacing the interpretive step to the user.
- Clearly label non-significant findings and exploratory analyses.
