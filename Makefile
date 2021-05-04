.PHONY: force
.DELETE_ON_ERROR:

.DEFAULT_GOAL = all

.PHONY: all
all: polyglot-2016-04.pdf issuu_ocaml_gadt-2021-05-04.pdf

%.pdf: %.tex force
	pdflatex $<

%: %.ml
	ocamlfind ocamlc -package mparser -linkpkg -o $@ $<

%.byte: %.ml
	ocamlfind ocamlc -package mparser -linkpkg -o $@ $<

%.js: %.byte
	js_of_ocaml $<

clean:
	$(RM) *.aux *.log *.nav *.out *.snm *.toc *.pdf

force:
