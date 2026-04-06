library(DT)
library(knitr)

pretty_table <- function(x) {
	x <- data.frame(x)

	if (nrow(x) > 6) {
		datatable(x, rownames = FALSE) |> formatRound(sapply(x, is.numeric), digits = 3)
	} else {
		kable(x, digits = 3, format.args = list(scientific = FALSE, nsmall = 3))
	}
}
