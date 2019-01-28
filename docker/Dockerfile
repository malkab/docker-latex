# Text workflow Docker based on TeX Live

FROM malkab/nodejs-dev:v10.13.0
LABEL maintainer="Juan Pedro Perez"
LABEL maintainer_email="jp.perez.alcantara@gmail.com"
LABEL description="Text workflow Docker based on TeX Live and with Node for creating workers."


# Non-interactive tzdata
ENV DEBIAN_FRONTEND=noninteractive
ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8
RUN echo "Europe/Madrid" > /etc/timezone

# Package configuration
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get dist-upgrade -y
RUN apt-get update
RUN apt-get install -y \
        texlive-xetex \
        texlive-science \
        texlive-lang-spanish \
        texlive-fonts-extra \
        make \
        python3 \
        python3-pip

RUN pip3 install mkdocs mkdocs-material mkdocs-bootswatch

# Add assets
COPY assets/templates/ /templates/
COPY assets/pandoc-2.5-1-amd64.deb /

# Install pandoc
RUN dpkg -i /pandoc-2.5-1-amd64.deb && rm /pandoc-2.5-1-amd64.deb

# /bin/bash
ENTRYPOINT ["/bin/bash"]
