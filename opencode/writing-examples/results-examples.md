<!-- Example: Results Mixed Anova -->

The examples above demonstrate form, style, and structure. Their content and topics are for illustration only—do not copy substance into your writing.

# Results — Mixed ANOVA with afex + emmeans (User's Voice)

**Source**: PhD thesis (2024).
**Skill**: `results`
**Key patterns**: afex mixed ANOVA, ANOVA-style reporting with F/t/p/ηp², emmeans pairwise with Tukey, narrative interpretation

Quantitative Measures

Global Ratings. We fitted a 3 × 3 mixed ANOVA on global ratings, with measure
(global opinion, valence and distance) as repeated measure and target as between-participants
factor. Note the aov_4() function from the afex (Singmann et al., 2023) detected a violation of the
sphericity assumption and automatically applied the Greenhouse-Geisser correction to the
degrees of freedom. As expected, there was a main effect of target, F(2, 113) = 27.65, MSE =
432.20, p < .001, ηp² = .329; M_adults = 48.37, SE = 1.90, 95%CI = [44.61, 52.13]; M_pre-schoolers =
66.42, SE = 1.95, 95%CI = [62.56, 70.28]; M_school-aged = 65.11, SE = 1.95, 95%CI = [61.26, 68.97].
There was also a main effect of measure, F(1.18, 133.05) = 41.33, MSE = 891.80, p < .001, ηp² =
.268. [...] Yet, there was no significant
evidence of an interaction, F(2.35, 133.05) = 1.18, MSE = 891.80, p = .315, ηp² = .315. Despite
this, to paint a complete picture it pays to look at the pairwise comparisons between targets on
the estimated marginal means for each measure (with Tukey's p-value correction on each triplet).
Doing so tells us that there were significant differences between global opinion ratings for adults
(M = 56.62, SE = 2.95, 95%CI = [50.76, 62.49]), and both preschool- (M = 76.89, SE = 3.04,
95%CI = [70.87, 82.91]) and school-aged children (M = 70.26, SE = 3.04, 95%CI = [64.24,
76.28]), respectively, t(113) = -4.78, SE = 4.24, p < .001; t(113) = -3.21, SE = 4.24, p = .002.
Yet, there were no significant differences between preschool- and school-aged children, t(113) =
1.54, SE = 4.3, p = .126. Thus, we see participants' global opinion of both children categories
was more favorable than their opinion of adults. Note the global opinion of all groups was above
the scale's midpoint (i.e., 50).
