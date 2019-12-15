# Text workflow Docker based on TeX Live

FROM ubuntu:bionic
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
      locate \
      apt-file \
      less \
      python3 \
      wget \
      vim \
      python3-pip

RUN pip3 install mkdocs mkdocs-material mkdocs-bootswatch


# Add assets
COPY assets/pandoc-2.8.1-1-amd64.deb /


# Install pandoc
RUN dpkg -i /pandoc-2.8.1-1-amd64.deb && \
  rm /pandoc-2.8.1-1-amd64.deb 
  

# Clean a little bit
RUN apt-get clean


# /bin/bash
ENTRYPOINT ["/bin/bash"]
