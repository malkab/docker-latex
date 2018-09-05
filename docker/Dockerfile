# Text workflow Docker based on TeX Live

FROM ubuntu:latest
LABEL maintainer="Juan Pedro Perez"
LABEL maintainer_email="jpperezalcantara@us.es"
LABEL description="Text workflow Docker based on TeX Live."


# Non-interactive tzdata
ENV DEBIAN_FRONTEND=noninteractive
ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8
RUN echo "Europe/Madrid" > /etc/timezone


# Package configuration
RUN apt-get update
RUN apt-get upgrade -y 
RUN apt-get install -y \
        texlive-xetex \
        texlive-science \
        pandoc \
        pandoc-citeproc \
        texlive-lang-spanish \
        make \
        python3 \
        python3-pip

RUN pip3 install mkdocs mkdocs-material mkdocs-bootswatch


# Add assets
COPY assets/templates/ /templates/

# Workdir
WORKDIR /ext-src

# /bin/bash
ENTRYPOINT ["/bin/bash"]
