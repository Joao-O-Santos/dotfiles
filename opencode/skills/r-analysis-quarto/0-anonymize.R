# Data Anonymization Script

# WARNING:
# This script will not run since the original data isn't available.
# We provide it to make our data anonymization transparent.
# Note that we only removed potentially identifiable columns.
# Thus, all other datasets can be shared in their original format.
# Moreover, all data preparation and analyses scripts will still work.

# Import raw dataset
ds <- read.csv("../data/original_raw_ds.csv")
# Potentially identifiable columns (pic) = demographics.
pic <- c("ProlificID", "PROLIFIC_PID", "Age", "Gender", "Education", "OpenEducation")

# Remove any unconsenting participants from the dataset
# (the survey terminated immediately if they did not consent)
ds <- subset(ds, !(DistributionChannel == "anonymous" & Consent_answer == "2"))
# Remove potentially identifiable columns from the dataset
ds <- ds[ ,!colnames(ds) %in% pic]

# Write anonymized dataset to file.
write.csv(ds, "../data/raw_ds.csv", row.names = FALSE)
