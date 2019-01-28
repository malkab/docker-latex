#!/bin/bash

# Builds the PDF

PANDOC=pandoc
TEMPLATESDIR=/templates

mkdir -p out



$PANDOC -s \
    --table-of-contents \
    --top-level-division=chapter \
    --number-sections \
    --highlight-style=haddock \
    --include-in-header=src/header.tex \
    --template="${TEMPLATESDIR}/Memoir/Memoir.tex" \
    -o out/example-github-markdown.tex \
    src/example-github-markdown.md \
    memoir.yaml
    

$PANDOC -s \
    --table-of-contents \
    --number-sections \
    --top-level-division=chapter \
    --highlight-style=haddock \
    --include-in-header=src/header.tex \
    --template="${TEMPLATESDIR}/Memoir/Memoir.tex" \
    -o out/example-github-markdown.pdf \
    src/example-github-markdown.md \
    memoir.yaml 