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

## Logical Fallacies

When you spot a fallacy, name it specifically—don't just say "this is
flawed." Explain why the reasoning doesn't hold. Note: fallacious
reasoning doesn't prove the conclusion false; it only means this
argument doesn't support it.

### Causation Fallacies
- **Post hoc ergo propter hoc**: "B followed A, therefore A caused B."
- **Correlation ≠ causation**: Treating association as evidence of causality.
- **Reverse causation**: Mistaking cause for effect (does X cause Y, or does Y cause X?).
- **Single cause**: Attributing complex outcomes to one factor when many are at play.

### Generalization Fallacies
- **Hasty generalization**: Broad conclusions from samples too small or unrepresentative
  to support them.
- **Cherry-picking / Suppressed evidence**: Selecting only supporting evidence while
  ignoring contrary findings.
- **Ecological fallacy**: Applying group-level patterns to individuals within the group.

### Authority Fallacies
- **Appeal to authority**: "Expert X said it, so it's true"—without the supporting evidence.
- **Ad hominem**: Attacking the person making the argument, not the argument itself.
- **Genetic fallacy**: Judging a claim by its origin (who said it, where it came from)
  rather than its merits.

### Statistical Fallacies
- **Base rate neglect**: Ignoring the underlying probability when evaluating conditional
  evidence.
- **Texas sharpshooter**: Drawing a target around the bullet holes—finding patterns in
  data after the fact and treating them as hypotheses confirmed.
- **Prosecutor's fallacy**: Confusing P(evidence | hypothesis) with
  P(hypothesis | evidence).

### Structural Fallacies
- **False dichotomy**: Presenting two options as the only possibilities when others exist.
- **Begging the question**: Assuming the conclusion within the premise (circular reasoning).
- **Straw man**: Misrepresenting an opponent's argument to make it easier to attack.

### Science-Specific Fallacies
- **Galileo gambit**: "They laughed at Galileo, so my rejected/fringe idea must be correct."
- **Argument from ignorance**: "It hasn't been proven false, therefore it's true"
  (or vice versa).
- **Nirvana fallacy**: Rejecting a real, imperfect solution because it falls short of an
  idealized alternative.
- **Unfalsifiability**: Making claims that cannot be tested or disproven.

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
