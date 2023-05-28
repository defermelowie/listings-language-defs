MAIN := example.tex
OUTDIR := ./out

.PONY: build

build: setup
	pdflatex -output-directory=$(OUTDIR) $(MAIN)

setup:
	mkdir -p ./out

clean:
	rm -rf $(OUTDIR)/*
