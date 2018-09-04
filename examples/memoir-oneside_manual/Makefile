# Makefile for building the project into PDF

# Pandoc executable
PANDOC=pandoc
TEMPLATESDIR=/templates


# A single PDF with all contents

.PHONY: clean prep


memoir-pdf-full : prep
	$(PANDOC) src/chapter00.md src/chapter01.md memoir.yaml -s --top-level-division=chapter --table-of-contents --number-sections --highlight-style=haddock --template="$(TEMPLATESDIR)/Memoir/Memoir.tex" -o out/Memoir-Default.tex

	$(PANDOC) src/Chapter00.md src/Chapter01.md memoir.yaml -s --top-level-division=chapter --table-of-contents --number-sections --highlight-style=haddock --template="$(TEMPLATESDIR)/Memoir/Memoir.tex" -o out/Memoir-Default.pdf


memoir-html-full : prep
	$(PANDOC) src/Chapter00.md src/Chapter01.md memoir.yaml -s --top-level-division=chapter --table-of-contents --number-sections --highlight-style=tango --mathjax -o out/Memoir-Default.html


memoir-docx-full : prep
	$(PANDOC) src/Chapter00.md src/Chapter01.md memoir.yaml -s --top-level-division=chapter --table-of-contents --number-sections --highlight-style=tango --mathjax -o out/Memoir-Default.docx


memoir-simple-chapter : prep
	$(PANDOC) src/Chapter01.md memoir.yaml -s --template="$(TEMPLATESDIR)/Memoir/Memoir.tex" -o out/Memoir-Simple_Chapter.tex

	$(PANDOC) src/Chapter01.md memoir.yaml -s --template="$(TEMPLATESDIR)/Memoir/Memoir.tex" -o out/Memoir-Simple_Chapter.pdf


default-pandoc-template-simple-chapter : prep
	$(PANDOC) src/Chapter01.md -s -o out/default-pandoc-template-simple-chapter.tex

	$(PANDOC) src/Chapter01.md -s -o out/default-pandoc-template-simple-chapter.pdf


prep : 
	mkdir -p out


clean :
	rm -Rf out/*

