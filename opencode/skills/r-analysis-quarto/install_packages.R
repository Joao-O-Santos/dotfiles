packages <- c("afex", "car", "DT", "dplyr", "emmeans", "effectsize", "ggplot2", "lme4", "mediation", "metafor", "parameters", "robustbase", "tidyr", "WRS2")
packages <- setdiff(packages, row.names(installed.packages()))
install.packages(packages, repos = "https://cloud.r-project.org/")
