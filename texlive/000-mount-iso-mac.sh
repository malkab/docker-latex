#!/bin/bash

# Mounts the texlive-xxx ISO image

# Image to mount
ISO_NAME=texlive2019-20190410.iso





# ---

mkdir -p texlive-mount-point

hdiutil mount $ISO_NAME -mountroot $(pwd)/texlive-mount-point
