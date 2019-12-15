#!/bin/bash

# Commits the install container into a new image

# Install container name 
INSTALL_CONTAINER=text-workflows-install-container
# Image name
IMAGE_NAME=malkab/text-workflows:tl2019





# ---

docker commit $INSTALL_CONTAINER $IMAGE_NAME
