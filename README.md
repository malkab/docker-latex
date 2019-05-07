# Text Workflows Collection

This Docker image contains all the software needed to conduct automated text workflows with two environments:

- **pandoc + Markdown + LaTeX:** a classical workflow going from GitHub Flavored Markdown to LaTeX, DOCX, and PDF;

- **MkDocs:** a technical data site build from Markdown.

For **pandoc** and **LaTeX** the **Memoir** template is loaded. Memoir has lots of options that can be checked out at the **docker/assets/templates/Memoir/README.md**.


## MkDocs Styles

The list of installed MkDocs styles can be checked out in the following links:

- [https://mkdocs.github.io/mkdocs-bootswatch/](https://mkdocs.github.io/mkdocs-bootswatch/)

- [https://github.com/squidfunk/mkdocs-material](https://github.com/squidfunk/mkdocs-material)
