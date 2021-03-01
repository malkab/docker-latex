#!/bin/bash

# Version: 2021-01-21

# -----------------------------------------------------------------
#
# Creates a first image with all the preliminary packages needed for installing
# TexLive, including Pandoc and ImageMagick. This image will be used to install
# TexLive from the CD ISO image.
#
# -----------------------------------------------------------------
#
# Builds a Docker image.
#
# -----------------------------------------------------------------
# Check mlkcontext to check. If void, no check will be performed. If NOTNULL,
# any activated context will do, but will fail if no context was activated.
MATCH_MLKCONTEXT=
# The name of the image to push.
IMAGE_NAME=malkab/text-workflows-install-base
# The tag.
IMAGE_TAG=latest
# Dockerfile.
DOCKERFILE=.
# Latest? Tag the image as latest, too.
LATEST=false





# ---

# Check mlkcontext is present at the system
if command -v mlkcontext &> /dev/null
then

  if ! mlkcontext -c $MATCH_MLKCONTEXT ; then exit 1; fi

fi

echo "BUILDING IMAGE: ${IMAGE_NAME}:${IMAGE_TAG}"
echo -------------

# Build
docker build -t $IMAGE_NAME:$IMAGE_TAG $DOCKERFILE

# Tag latest, if asked
if [ "${LATEST}" = true ] ; then

  docker tag $IMAGE_NAME:$IMAGE_TAG $IMAGE_NAME:latest

fi
