library(dplyr)

get_descs <- function(data = NULL, variable = NULL) {
	descs <- summarise(data,
	                   N = n(),
	                   Min = min({{ variable }}, na.rm = TRUE),
	                   Max = max({{ variable }}, na.rm = TRUE),
	                   Range = Max - Min,
	                   Q1 = quantile({{ variable }}, na.rm = TRUE, 0.25)[[1]],
	                   Mdn = median({{ variable }}, na.rm = TRUE),
	                   Q3 = quantile({{ variable }}, na.rm = TRUE, 0.75)[[1]],
	                   IQR = IQR({{ variable }}, na.rm = TRUE),
	                   M = mean({{ variable }}, na.rm = TRUE),
	                   SD = sd({{ variable }}, na.rm = TRUE),
	                   SE = SD / sqrt(N),
	                   CI_L = M - (SE * -qt(0.025, N - 1)),
	                   CI_U = M + (SE * -qt(0.025, N - 1)))

	return(descs)
}
