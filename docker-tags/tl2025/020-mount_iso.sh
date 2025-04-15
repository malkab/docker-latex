#!/bin/bash

IMAGE_TAG=tl2025

mkdir -p texlive_mount_point

sudo mount assets/texlive/texlive_$IMAGE_TAG.iso \
    ./texlive_mount_point
