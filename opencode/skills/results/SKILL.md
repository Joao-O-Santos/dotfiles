---
name: results
description: Draft or revise results sections for empirical papers.
---

# Skill: results

## Rules

- **Lead with meaning**, then show evidence
- Use **present tense** for inferential statements
- Emphasize significance as a property of evidence, not the effect itself
- Report effect sizes (η²~p~ for ANOVAs, Cohen's *d* for *t*-tests, *r* for correlations)
- Use HTML entities for Greek letters (&eta;, &beta;, &alpha;, &chi;, &omega;)
- Subscripts use pandoc tilde notation (M~psych~)
- Superscripts use caret notation (&eta;~p~^2^)

## Structure

1. **Substantive interpretation** first, statistics second
2. Report interactions first if they qualify main effects
3. Use estimated marginal means to break down main effects
4. Use simple contrasts to break down interactions

## Example
#results-reporting

## Common Mistakes

- Don't start paragraphs with statistics; lead with the substantive claim
- Don't report main effects when a significant interaction qualifies them without noting the qualification
- Don't use Unicode Greek letters or LaTeX math; use HTML entities

## Workflow

1. Extract key findings from R/Quarto outputs
2. Organize by hypothesis/research question
3. Draft substantive statements first, add statistics
4. Cross-check with analysis scripts

## Note on Examples

The examples above demonstrate form, style, and structure. Their content and topics are for illustration only—do not copy substance into your writing.