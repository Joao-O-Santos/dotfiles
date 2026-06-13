# Phony targets
.PHONY: all deps site cached fast clean deep_clean 

all:
	quarto render

site: all

deps:
	Rscript utils/install_packages.R
	./utils/add_extensions.sh

cached:
	quarto render --cache

fast: cached

preview:
	quarto preview

clean:
	-rm -rf public .quarto
	
deep_clean:
	-rm -rf public .quarto _extensions
	-find -name "report_files" | xargs rm -rf
	-find -name "report_cache" | xargs rm -rf
