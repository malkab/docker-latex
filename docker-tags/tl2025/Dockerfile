# Text workflow Docker based on TeX Live
FROM debian_devcontainer:bookworm AS build
LABEL author="Juan Pedro Perez"
LABEL author_email="jp.perez.alcantara@gmail.com"
LABEL maintainer="Juan Pedro Perez"
LABEL maintainer_email="jp.perez.alcantara@gmail.com"
LABEL description="Text workflow Docker based on TeX Live. To be used as a DevContainer."

WORKDIR /

USER root

# Configurar esto.
ENV TEX_YEAR=2025

# Package configuration
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get dist-upgrade -y && \
    apt-get update && \
    apt-get install -y \
      imagemagick \
      libncurses5 \
      python3 \
      python3-pip

RUN ldconfig

RUN ln -s /usr/bin/python3 /usr/bin/python

RUN python3 -m pip install --upgrade --break-system-packages \
  mkdocs \
  mkdocs-material \
  mkdocs-bootswatch

# Add assets
COPY assets/pandoc/pandoc*.deb /pandoc.deb

# Install pandoc
RUN dpkg -i /pandoc.deb && \
  rm /pandoc.deb

# Clean a little bit
RUN apt-get clean

USER vscode