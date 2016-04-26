.DELETE_ON_ERROR:

%.pdf: %.tex
	pdflatex $<

%: %.ml
	ocamlfind ocamlopt -package mparser -linkpkg -o $@ $<

%.byte: %.ml
	ocamlfind ocamlc -package mparser -linkpkg -o $@ $<

%.js: %.byte
	js_of_ocaml $<

clean:
	$(RM) slides.aux slides.log slides.nav slides.out slides.snm slides.toc
