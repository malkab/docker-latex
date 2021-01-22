# Text workflow Docker based on TeX Live

FROM ubuntu:latest
LABEL author="Juan Pedro Perez"
LABEL author_email="jp.perez.alcantara@gmail.com"
LABEL maintainer="Juan Pedro Perez"
LABEL maintainer_email="jp.perez.alcantara@gmail.com"
LABEL description="Text workflow Docker based on TeX Live"


# Non-interactive tzdata
ENV DEBIAN_FRONTEND=noninteractive
ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8
RUN echo "Europe/Madrid" > /etc/timezone

# Package configuration
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get dist-upgrade -y && \
    apt-get update && \
    apt-get install -y \
      make \
      locales \
      locate \
      apt-file \
      less \
      python3 \
      wget \
      vim \
      python3-pip \
      imagemagick

RUN pip3 install mkdocs mkdocs-material mkdocs-bootswatch

RUN locale-gen es_ES.UTF-8

# Add assets
COPY ./assets/pandoc.deb /

# Copy configurations
COPY ./assets/dot.bashrc /root/.bashrc
COPY ./assets/dot.vimrc /root/.vimrc

# Install pandoc
RUN dpkg -i /pandoc.deb && \
  rm /pandoc.deb

# Clean a little bit
RUN apt-get clean

# /bin/bash
ENTRYPOINT ["/bin/bash"]
