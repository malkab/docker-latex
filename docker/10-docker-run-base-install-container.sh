#!/bin/bash

MKDOCSSERVERPORT=8000

# For Linux, left blank
TEXLIVE_MOUNT_NAME=TeXLive2019





# ---
docker run -ti \
  -v $(pwd)/:/ext-src/ \
  -v $(pwd)/../texlive-iso/texlive-mount-point/$TEXLIVE_MOUNT_NAME:/texlive \
  --name text-workflows-install-container \
  -p "${MKDOCSSERVERPORT}:8000" \
  --workdir /ext-src \
  malkab/text-workflows-install-base:latest
