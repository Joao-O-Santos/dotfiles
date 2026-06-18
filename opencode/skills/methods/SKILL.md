---
name: methods
description: Draft or revise method sections for empirical papers.
---

# Skill: methods

Load writing-craft alongside this skill for paragraph philosophy, concrete
language, and revision thinking.

## Structure

### Participants
#method-participants

### Materials (if needed)
Briefly describe stimuli, measures, apparatus

### Procedure
#method-procedure


## Power Analysis and Sample Size

Treat a priori power analysis as **informed guessing at best**, not as a
precision tool. The parameters you feed into any power calculation — effect
size, variance, even the choice of test — rest on assumptions that are
themselves uncertain. The goal is not to produce a single defensible *N*;
it is to make your reasoning transparent and to avoid the worst
decision-making traps.

### What to do

**Communicate uncertainty.** When you base a power analysis on an effect
size from a prior study or meta-analysis, report the confidence interval
around that estimate. Run the analysis for the lower bound, the point
estimate, and the upper bound. Alternatively, present a power curve
showing how power varies across the plausible range of effect sizes. A
single-point power estimate — especially one reported to multiple decimal
places — creates a false sense of precision.

**Base estimates on expected results, not abstract benchmarks.** For
simple models, translate the expected pattern of means and variances into
an effect size and plug it into standard software. For complex models
(e.g., linear mixed models, SEM), simulate power from the expected
pattern of results or from pilot data. Do not reduce a rich set of
predictions to a single standardized effect size when the model itself
has many moving parts. When simulation is impractical, power the study
for a simpler proxy test (e.g., the pairwise comparison that tests your
central hypothesis).

**Admit when available resources determine sample size.** If your *N* is
set by budget, participant-pool constraints, or the logistics of a
special population, say so. Pre-registration templates and many journals
explicitly permit resource-based sample-size justification. N-hacking —
tweaking effect-size inputs until the power analysis returns the *N* you
already had in mind — is a form of Texas sharpshooter fallacy and
produces numbers that fool no one, least of all an attentive reviewer.

### What to avoid

**T-shirt effect sizes.** Do not plug Cohen's small/medium/large
benchmarks into a power analysis as though they were meaningful. These
labels are arbitrary, context-free, and tell you nothing about whether
the effect you are studying is theoretically or practically important.
Derive your target effect size from the literature on your specific
phenomenon, from a mini meta-analysis of the most relevant prior work, or
from the smallest effect that would matter for your theoretical claim.

**N-hacking.** If you find yourself adjusting the effect size, alpha, or
tail count until the output matches a round number you can afford, you
are N-hacking. Set your parameters before running the analysis, document
them, and if the resulting *N* is infeasible, adjust your design — not
the inputs to the power calculation.

**Post-hoc power analysis.** Once data are collected, observed power is a
direct transformation of the *p*-value and adds no new information. Do
not report post-hoc power to argue that a non-significant result would
have been significant with more participants. If you want to assess what
effect sizes your study could have detected, report a sensitivity power
analysis — but make clear it is a sensitivity analysis, not a
retrospective power claim.

### Broader judgment

**Publication bias, not small *N*, is the deeper problem.** Small samples
produce noisy estimates that both over- and under-estimate true effects.
The reason the literature accumulates inflated estimates is that
publication bias filters out non-significant findings. Power analysis
helps, but it does not fix the incentive structure.

**Inadequate power analysis alone is not sufficient grounds for
rejection.** When a power analysis rests on thin evidence or an
assumption the reviewer finds questionable, the appropriate response is
to request a sensitivity analysis or a power curve — not to reject the
manuscript outright. Meaningful sensitivity analyses can be added during
revision.

**Balance power with ethics.** Collecting more data than needed wastes
participants' time and funnels resources away from other research.
Chasing 80% power for an arbitrary effect-size benchmark, without first
trying to increase the effect through better design, can itself be an
ethical lapse. Power is not an unconditional good — it must be weighed
against cost, feasibility, and participant burden.


## Experimental Design Principles

Power is not only a function of *N*. Design choices that increase the
signal-to-noise ratio can raise power far more efficiently than adding
participants. When drafting a methods section, make these design
decisions explicit and justify them.

### Fisher's three principles

**Randomization.** Random assignment of participants to conditions breaks
the link between treatment and potential confounds. Describe the
randomization procedure concretely: how the sequence was generated, how
it was implemented, and whether any stratification or blocking was used.

**Replication.** Replication here means running multiple independent
experimental units per condition — not the reproducibility sense of the
term. It is the foundation of error estimation. Report how many
observations per cell, how many trials per participant, and how stimulus
sampling was handled.

**Blocking.** When you expect systematic variation from a known source
(e.g., experimenter, day of testing, stimulus set), block on it so that
variation is removed from the error term. Blocking increases precision
without increasing *N*.

### Design-structure decisions

**Between-subjects vs. within-subjects.** Within-subject designs remove
individual-difference variance from the error term and typically require
fewer participants to achieve the same power. But they introduce carryover
effects and demand counterbalancing. Choose deliberately and describe the
trade-off in the methods section.

**Factorial designs.** Crossing two or more factors in a single experiment
is usually more efficient than running separate experiments for each
factor. Factorial designs let you test interactions, which are often the
theoretically central question. Describe the full factorial structure,
including whether factors are manipulated within or between subjects.

### Increasing effect size through design

The most underused lever in power analysis is design quality. Stronger
manipulations, more sensitive measures, better-controlled settings, and
clearer instructions all increase the effect size — and because power is
sensitive to effect size (it enters the non-centrality parameter as a
squared term in many common tests), even modest design improvements can
yield large power gains. When *N* is constrained, invest effort in making
the effect larger rather than lamenting the sample size.


## Rules

- Write from **participant's POV**, not researcher's
- Present chronologically
- Include counterbalancing and randomization details
- Align with what scripts actually did for exclusions/cleaning

## Common Mistakes

- Don't write "we then asked..." — write from participant's experience
- Don't omit counterbalancing details
- Don't deviate from actual script procedures

## Workflow

1. Outline subsections first
2. Draft each subsection
3. Cross-check with analysis scripts

## Note on Examples

#examples-disclaimer


## Remember

1.  **Power analysis is an informed guess, not a precise calculation.**
    Communicate uncertainty with power curves, confidence-interval ranges,
    and explicit assumptions rather than a single point estimate.

2.  **Increase effect size through better design, not just larger *N*.**
    Stronger manipulations, blocking, and within-subject designs often
    yield more power than adding dozens of participants to a noisy
    between-subjects study.

3.  **Admit when resources determine sample size.** Do not N-hack. A
    transparent statement that *N* is constrained by budget, population,
    or logistics is scientifically honest and accepted by most journals and
    pre-registration templates.
