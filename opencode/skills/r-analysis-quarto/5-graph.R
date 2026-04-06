# Graph

# Import packages.
library(ggplot2)

# Load the CIs for the main analysis.
g <- data.frame(blame_lmm_cis)
g <- g[complete.cases(g), ]
g <- ggplot(g, aes(y = trial_type, x = emmean, color = scenario_type)) +
            geom_segment(aes(x = -50, xend = 50, y = "critical", yend = "critical"),
                         colour = "grey", size = 2, lineend = "round") +
            geom_segment(aes(x = -50, xend = 50, y = 'filler', yend = "filler"),
                         colour = "grey", size = 2, lineend = "round") +
            geom_errorbar(aes(xmin = lower.CL, xmax = upper.CL),
                          width = 0.1, color = "black") +
            geom_point(size = 5) +
            # Add labels of targets per rcd_main_dv value
            annotate("text",
                     x = c(-55, 56, -55, 56),
                     y = c('critical', 'critical', 'filler', 'filler'),
                     label = c("Adults", "Children", "Males", "Females")) +
            scale_y_discrete(name = "Trial Type",
                             limits = c("filler", "critical"),
                             labels = c('Filler', 'Critical')) +
            scale_x_continuous(name = "Rating (Recoded)",
                               breaks = seq(-50, 50, 10), limits =c(-60, 60)) +
            scale_color_manual(name = "Scenario Type",
                               labels = c("Mishap", "Non-mishap"),
                               values = c("red", "blue")) +
            theme_classic() +
            theme(text = element_text(family = "Liberation Serif", size = 12))

ggsave("../results/graph_s3_1.png", g, width = 10, height = 2, dpi = 900)
