#!/bin/bash

# Mounts the texlive-xxx ISO image

# Image to mount
ISO_NAME=texlive2019-20190410.iso





# ---

mkdir -p texlive-mount-point

mount $ISO_NAME $(pwd)/texlive-mount-point
