# Data Analysis Script

# Load Packages
library(afex)
library(emmeans)
library(mediation)
#lme4 not loaded here to avoid masking objects from afex

# Set options
options(contrasts = c("contr.sum", "contr.poly"))
afex_options(es_aov = "pes", method_mixed = "KR")
set.seed(123)

# Import dataset
ds <- read.csv("../data/wrangled_ds.csv")

# H1: Racial bias (initial rating greater for British than Roma)
m_h1 <- mixed(initial_rating ~ ethnicity + (1 | pp) + (1 | CV), ds)
emm_h1 <- emmeans(m_h1, list(~ 1, ~ ethnicity))
# H2: Egocentric discounting
m_h2 <- mixed(ego_discount ~ advisor * advicedirection + (1 | pp), ds,
              test_intercept = TRUE)
emm_h2 <- emmeans(m_h2, list(~ 1, pairwise ~ advisor))
# H3: WOA - Two-step hurdle model
voi <- subset(ds, is.finite(WOA))
# Step #1: Hurdle (binomial)
voi$updated <- voi$WOA != 0
m_h3h4_1 <- mixed(updated ~ advisor * advicedirection + (1 | pp), voi,
                  family = binomial, method = "LRT")
emm_h3h4_1 <- emmeans(m_h3h4_1, list(~ 1, ~ advisor), type = "response")
# Step #2: Magnitude (linear)
m_h3h4_2 <- mixed(WOA ~ advisor * advicedirection + (1 | pp), voi, subset = voi$updated)
emm_h3h4_2 <- emmeans(m_h3h4_2, list(~ 1, pairwise ~ advisor))
# Mediation analysis (H5 to H6)
# H5: Test for difference in perceived trust between advisors
m_h5 <- mixed(Trust ~ advisor + (1 | pp) + (1 | CV), ds)
emm_h5 <- emmeans(m_h5, list(~ 1, pairwise ~ advisor))
# No trust difference between AIs--opting for human vs both AIs contrast
voi$is_human <- ifelse(voi$advisor == "employee", 1, 0)
# Step #1: Hurdle Mediation
m_b_1 <- lme4::glmer(updated ~ Trust + (1 | pp), voi, family = binomial)
m_M_1 <- lme4::lmer(Trust ~ is_human + (1 | pp), voi, REML = FALSE)
m_Y_1 <- lme4::glmer(updated ~ Trust + is_human + (1 | pp), voi, family = binomial)
h7_1 <- mediate(m_M_1, m_Y_1, mediator = "Trust", treat = "is_human", sims = 5000)
# Step #1: Linear/Magnitude Mediation
m_b_2 <- lme4::lmer(WOA ~ Trust + (1 | pp), voi, subset = voi$updated, REML = FALSE)
m_M_2 <- lme4::lmer(Trust ~ is_human + (1 | pp), voi, subset = voi$updated, REML = FALSE)
m_Y_2 <- lme4::lmer(WOA ~ Trust + is_human + (1 | pp), voi, subset = voi$updated, REML = FALSE)
h7_2 <- mediate(m_M_2, m_Y_2, mediator = "Trust", treat = "is_human", sims = 5000)
