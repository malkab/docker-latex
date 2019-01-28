# Makefile for building the project into PDF

# Pandoc executable
PANDOC=pandoc
TEMPLATESDIR=/templates


# A single PDF with all contents

.PHONY: clean prep


memoir-pdf-full : prep
	$(PANDOC) src/chapter00.md src/chapter01.md memoir.yaml -s --table-of-contents --top-level-division=chapter --number-sections --highlight-style=haddock --template="$(TEMPLATESDIR)/Memoir/Memoir.tex" -o out/memoir-default.tex

	$(PANDOC) src/chapter00.md src/chapter01.md memoir.yaml -s --table-of-contents --top-level-division=chapter --number-sections --highlight-style=haddock --template="$(TEMPLATESDIR)/Memoir/Memoir.tex" -o out/memoir-default.pdf


memoir-html-full : prep
	$(PANDOC) src/chapter00.md src/chapter01.md memoir.yaml -s --top-level-division=chapter --table-of-contents --number-sections --highlight-style=tango --mathjax -o out/memoir-default.html


memoir-docx-full : prep
	$(PANDOC) src/chapter00.md src/chapter01.md memoir.yaml -s --top-level-division=chapter --table-of-contents --number-sections --highlight-style=tango --mathjax -o out/memoir-default.docx


memoir-simple-chapter : prep
	$(PANDOC) src/chapter01.md memoir.yaml -s --template="$(TEMPLATESDIR)/Memoir/Memoir.tex" -o out/memoir-simple_chapter.tex

	$(PANDOC) src/chapter01.md memoir.yaml -s --template="$(TEMPLATESDIR)/Memoir/Memoir.tex" -o out/memoir-simple_chapter.pdf


default-pandoc-template-simple-chapter : prep
	$(PANDOC) src/chapter01.md -s -o out/default-pandoc-template-simple-chapter.tex

	$(PANDOC) src/chapter01.md -s -o out/default-pandoc-template-simple-chapter.pdf


prep : 
	mkdir -p out


clean :
	rm -Rf out

