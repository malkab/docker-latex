#!/bin/bash

IMAGE_TAG=tl2025

# Clean assets

# Drop install-base container
docker rm latex_install_container_$IMAGE_TAG

# Drop the install-base image
docker rmi latex_manual_install:$IMAGE_TAG

# Unmount texlive-mount-point
sudo umount ./texlive_mount_point
rmdir ./texlive_mount_point
