#!/bin/bash

IMAGE_TAG=tl2025

# Crea un container temporal para instalar manualmente el TeXLive
docker run -ti \
    --name latex_install_container_$IMAGE_TAG \
    -v $(pwd):/ext \
    -v ./texlive_mount_point/:/texlive \
    -p 8000:8000 \
    --entrypoint /bin/bash \
    --workdir /texlive \
    --user root \
    latex_manual_install:$IMAGE_TAG