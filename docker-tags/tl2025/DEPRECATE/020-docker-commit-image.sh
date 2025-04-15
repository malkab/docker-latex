#!/bin/bash

# Version: 2021-07-06

# -----------------------------------------------------------------
#
# Document here the purpose of the script.
#
# -----------------------------------------------------------------
#
# Commits a container into an image.
#
# -----------------------------------------------------------------
# Check mlkcontext to check. If void, no check will be performed. If NOTNULL,
# any activated context will do, but will fail if no context was activated.
MATCH_MLKCTXT=common
# Container name, mandatory.
CONTAINER_NAME=$(docker ps -aq --filter "name=latex-install-container_")
# The name of the image to push, mandatory.
IMAGE_NAME=malkab/latex
# The tag.
IMAGE_TAG="tl${MLKC_TEXT_WORKFLOWS_TEXLIVE_YEAR}"
# Latest? Tag the image as latest, too. Defaults to false.
LATEST=true





# ---

# Check mlkcontext is present at the system
if command -v mlkctxt &> /dev/null ; then

  if ! mlkctxt -c $MATCH_MLKCTXT ; then exit 1; fi

fi

echo "BASE CONTAINER: ${CONTAINER_NAME}"
echo "BUILDING IMAGE: ${IMAGE_NAME}:${IMAGE_TAG}"
echo -------------

# Commit
docker commit $CONTAINER_NAME $IMAGE_NAME:$IMAGE_TAG

# Tag latest, if asked
if [ "${LATEST}" = true ] ; then

  docker tag $IMAGE_NAME:$IMAGE_TAG $IMAGE_NAME:latest

fi
