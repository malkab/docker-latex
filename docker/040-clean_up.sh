#!/bin/bash

# Clean assets

# Drop install-base container
docker rm $(docker ps -aq --filter "name=latex-install-container_")

# Drop the install-base image
docker rmi malkab/latex-install-base:latest

# Unmount texlive-mount-point
sudo umount ../texlive/texlive-mount-point
rmdir ../texlive/texlive-mount-point
