---
name: review-detail
description: Detail-focused review for citations, conceptual clarity, and argument issues.
---

# Skill: review-detail

Three rules to carry through every review: name fallacies specifically,
frame bias checks as questions not accusations, and always check for
correlation-masquerading-as-causation.

## Focus Areas

### Claims Missing Citations
- Factual statements without references
- Claims not backed by evidence
- Unclear if point is being made or cited

### Lacking Conceptual Clarity
- Multiple terms for same concept
- Same term for different concepts
- Ambiguous terminology

### Issues with Arguments
- Logical fallacies (see catalog below)
- Missing steps in reasoning
- Lack of clarity
- Ignored counterfactuals

### Alternative Explanations (McGuire Heuristics)

A core function of peer review is surfacing competing explanations
the authors may not have considered or rebutted. Use the McGuire
heuristics (see #mcguire-heuristics) to systematically generate
alternative accounts:

- Has the contrary been considered? (E10)
- Could causal direction be reversed? (E11)
- What moderators qualify the effect? (E14)
- Are there multiple explanations for the finding? (H23)
- Could opposing counterforces be at work? (H25)
- What do deviant cases/outliers reveal? (K35)
- Can conflicting prior results be reconciled? (L37)

Raise these as questions, not accusations. Frame as: "Have the
authors considered the possibility that...?"

## Logical Fallacies

Check for fallacies in these categories. Name the specific fallacy when
found, but don't limit checking to this list — the categories are prompts,
not exhaustive catalogs.

- **Causation fallacies** (e.g., post hoc ergo propter hoc, correlation=causation,
  reverse causation)
- **Generalization fallacies** (e.g., hasty generalization, cherry-picking,
  ecological fallacy)
- **Authority fallacies** (e.g., appeal to authority, ad hominem, genetic fallacy)
- **Statistical fallacies** (e.g., base rate neglect, Texas sharpshooter,
  prosecutor's fallacy)
- **Structural fallacies** (e.g., false dichotomy, begging the question, straw man)
- **Science-specific fallacies** (e.g., Galileo gambit, argument from ignorance,
  nirvana fallacy, unfalsifiability)

When identifying a fallacy: name it, explain why the reasoning is flawed,
note that fallacious reasoning doesn't prove the conclusion false — just
that this argument doesn't support it.

## Bias Detection

Frame these as checks, not accusations. Use "check whether" language.
Raise questions; don't assign motives. A reviewer asks "Was preregistration
available?" not "The authors definitely HARKed."

### Researcher Bias
- Check whether hypotheses appear to have been stated after results were known (HARKing).
- Check whether only supporting findings are discussed while null or contradictory
  results are omitted.
- Check whether the literature review omits studies with negative or null findings
  (publication / file-drawer bias).
- Check whether the study was preregistered and whether the analysis plan was followed
  transparently.

### Selection Bias
- Check whether the sample is representative of the claimed target population.
- Check whether dropout or attrition differs systematically between groups.

### Analysis Bias
- Check whether multiple analyses appear to have been run until significance was
  found (p-hacking).
- Check whether all planned analyses are reported, or only the significant ones
  (selective reporting).
- Check whether subgroup analyses were conducted without correction for multiple
  comparisons.
- Check whether covariates or exclusion criteria appear to have been chosen after
  seeing results.

## Statistical Red Flags

- Correlation presented as evidence of causation
- Regression to the mean ignored (extreme groups shift toward the mean on remeasurement)
- Base rate neglected in interpreting diagnostic or predictive claims
- Simpson's paradox: a trend that appears in subgroups disappears or reverses when
  groups are combined
- P-values interpreted as "probability the null hypothesis is true"
- Non-significance interpreted as "no effect" (absence of evidence ≠ evidence of absence)
- Statistical significance conflated with practical or clinical importance
- Suspicious clustering of p-values just below .05

## Output Format

### Claims Missing Citations
- **Problem** (10-25 words): [description]
- **Solution**: MUST ADD REFERENCE FOR CLAIM, or TODO placeholder, or remove claim

### Lacking Conceptual Clarity
- **Problem** (10-25 words): [description]
- **Solution**: [which term to use]

### Issues with Arguments
- **Problem** (10-25 words): [description]
- **Solution**: [proposed fix]

## Rules

#reviewer-output-rules

## Note on Examples

#examples-disclaimer

## Remember

1. **Name fallacies specifically** — "post hoc fallacy" tells the author what to fix;
   "this is flawed" does not.
2. **Bias checks are questions, not accusations** — frame as "check whether," not
   "the authors did X."
3. **Correlation ≠ causation is the most common and most important catch** — always
   check for it.

