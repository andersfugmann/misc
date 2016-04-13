.DELETE_ON_ERROR:

%.pdf: %.tex
	pdflatex $<

%: %.ml
	ocamlc -o $@ $<

clean:
	$(RM) slides.aux slides.log slides.nav slides.out slides.snm slides.toc
