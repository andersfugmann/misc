.PHONY: force
.DELETE_ON_ERROR:

.DEFAULT_GOAL = polyglot-2016-04.pdf

%.pdf: %.tex force
	pdflatex $<

%: %.ml
	ocamlfind ocamlc -package mparser -linkpkg -o $@ $<

%.byte: %.ml
	ocamlfind ocamlc -package mparser -linkpkg -o $@ $<

%.js: %.byte
	js_of_ocaml $<

clean:
	$(RM) slides.aux slides.log slides.nav slides.out slides.snm slides.toc

force:
