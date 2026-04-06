# Phony targets
.PHONY: all deep_clean deps site clean

all:
	quarto render

deps:
	Rscript utils/install_packages.R
	./utils/add_extensions.sh

site:
	quarto render

preview:
	quarto preview

clean:
	-rm -rf public .quarto
	-find -name "report_files" | xargs rm -rf
	
deep_clean:
	-rm -rf public .quarto _extensions
