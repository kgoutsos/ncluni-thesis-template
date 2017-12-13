MAINTEX = main.tex
MAINNAME:=$(MAINTEX:.tex=)
INBIB = references.bib
INGLO = special_pages/glossary.tex
INFILES = $(MAINTEX) $(wildcard chapters/*.tex) $(wildcard special_pages/*.tex) $(wildcard figures/*.tex)
AUXEXTS = *.aux *.bbl *.bcf *.blg *.gz *.log *.nav *.out *.run.xml *.snm *.synctex.gz *.tdo *.toc *.glo *.lof *.lot *.ist *.glg *.gls

all: $(MAINNAME).pdf

$(MAINNAME).gls: $(INGLO) $(INFILES)
	makeglossaries $(MAINNAME)

$(MAINNAME).bbl: $(INBIB) $(INFILES)
	pdflatex $(MAINNAME)
	biber $(MAINNAME)
	rm $(MAINNAME).pdf

$(MAINNAME).pdf: $(MAINNAME).bbl $(MAINNAME).gls $(INFILES)
	pdflatex $(MAINNAME)
	pdflatex $(MAINNAME)

.PHONY: clean clean-aux count

clean-aux:
	rm -f $(AUXEXTS)

clean:
	rm -f $(AUXEXTS) $(MAINNAME).pdf

count:
	texcount -inc -total $(MAINTEX)
