#
# Makefile to install techcv and compile the CV example
#


PACKAGENAME := techcv

TEXMFHOME := $(shell kpsewhich -var-value=TEXMFHOME)
PREFIX := ${TEXMFHOME}/tex/latex/${PACKAGENAME}

CV := CV

LATEXMK := $(shell which latexmk)
COMPILER=pdflatex
BIBCOMPILER=biber

all: install pdf clean

install: techcv.cls
	install -d ${PREFIX}
	install -m 644 $< ${PREFIX}

pdf: ${CV}.tex
ifdef LATEXMK
	${LATEXMK} $<
else
	${COMPILER} -interaction=nonstopmode -file-line-error  --shell-escape -jobname=CV $<
	${BIBCOMPILER} ${CV}
	${COMPILER} -interaction=nonstopmode -file-line-error  --shell-escape -jobname=CV $<
	${COMPILER} -interaction=nonstopmode -file-line-error  --shell-escape -jobname=CV $<
endif

clean: 
ifdef LATEXMK
	${LATEXMK} -c
	rm -f *.bbl *.run.xml
else
	rm -f *.aux *.log *.bbl *.blg *.toc *.lof *.lot *.out *.glo *.ist *.acr *.alg *.glg *.gls *.acn *.nav *.snm *.run.xml *.bcf
endif


