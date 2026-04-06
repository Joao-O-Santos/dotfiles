# Data Wrangling Script

library(tidyr)

# Read raw anonymized dataset
ds <- read.csv("../data/raw_ds.csv")
# Import CV dictionary to properly number CVs
dict <- read.csv("../data/cv_dict.csv")

# Remove extra headers, write to file and reimport dataset to fix errors
ds <- ds[-c(1,2), ]
write.csv(ds, "../data/wrangled_ds.csv", row.names = FALSE)
ds <- read.csv("../data/wrangled_ds.csv")
# Exclude participants who failed attention checks
# Notes:
# - Initial dataset contained 1249 responses, including previews
# - N = 911 after excluding previews
# - N = 899 after excluding pps who failed the first AI check
# - N = 899 after excluding pps who failed the first attention check
# - N = 898 after excluding a pp who failed the second attention check
# - N = 897 after excluding a pp who did not identify as White
ds <- subset(ds,
             DistributionChannel != "preview" &
             grepl("2|two|Two", RedRoses) &
             Attentioncheck1 < 2 & Attentioncheck2 <= 2 &
             grepl("4", EthnicityDemo))
# Assign a participant number to each participant
ds$pp <- sprintf("pp%03d", 1:nrow(ds))
ds$order <- paste0("order", ds$order)
# Improve column names
colnames(ds) <- gsub("referent", "advisor", colnames(ds))
colnames(ds) <- gsub("Ater", "After", colnames(ds))
colnames(ds) <- gsub("Rate(\\d)After_1", "final_rating_b\\1", colnames(ds))
colnames(ds) <- gsub("Rate(\\d)_1", "initial_rating_b\\1", colnames(ds))
colnames(ds) <- gsub("(ethnicity|advicenum|CV)(\\d)", "\\1_b\\2", colnames(ds))
# Compute weight of advice
ds$Trust_b1 <- rowMeans(ds[ ,c("TrustSource1_1", "TrustSource1_2", "TrustSource1_3")])
ds$Trust_b2 <- rowMeans(ds[ ,c("TrustSource2_1", "TrustSource2_2", "TrustSource2_3")])
# Fix ethnicity labels on second block to match the first
ds$ethnicity_b2 <- gsub("English", "British", ds$ethnicity_b2)
# Keep only relevant columns
coi <- grep("pp|CV|advisor|ethnicity|order|advicedirection|_b\\d",
            colnames(ds), value = TRUE)
ds <- ds[ ,coi]
ds <- pivot_longer(ds, -c("pp", "CVset", "advisor", "order", "advicedirection"),
                   names_pattern = "(.*)_(b1|b2)",
                   names_to = c("measure", "block"),
                   values_transform = as.character)
ds <- pivot_wider(ds, names_from = "measure")
coi <- c("initial_rating", "final_rating", "Trust", "advicenum")
ds[ ,coi] <- apply(ds[ ,coi], 2, as.numeric)
ds$CV <- dict[match(ds$CV, dict$Key), "Value"]
ds$WOA <- (ds$final_rating - ds$initial_rating) / (ds$advicenum - ds$initial_rating)
ds$abs_diff_final_init <- abs(ds$final_rating - ds$initial_rating)
ds$abs_diff_final_advice <- abs(ds$final_rating - ds$advicenum)
ds$ego_discount <- ds$abs_diff_final_advice - ds$abs_diff_final_init

# Write wrangled dataset to file
write.csv(ds, "../data/wrangled_ds.csv", row.names = FALSE)
