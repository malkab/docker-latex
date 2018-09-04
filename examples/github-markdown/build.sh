#!/bin/bash

# Builds the PDF

PANDOC=pandoc
TEMPLATESDIR=/templates

mkdir -p out

$PANDOC src/example-github-markdown.md memoir.yaml -s --top-level-division=chapter --table-of-contents --number-sections --highlight-style=haddock --template="${TEMPLATESDIR}/Memoir/Memoir.tex" -o out/example-github-markdown.tex

$PANDOC src/example-github-markdown.md memoir.yaml -s --top-level-division=chapter --table-of-contents --number-sections --highlight-style=haddock --template="${TEMPLATESDIR}/Memoir/Memoir.tex" -o out/example-github-markdown.pdf
