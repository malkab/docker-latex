#!/bin/bash

# Version: 2021-01-21

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
MATCH_MLKCONTEXT=common
# Container name
CONTAINER_NAME=$(docker ps -aq --filter "name=text-workflows-install-container")
# The name of the image to push.
IMAGE_NAME=malkab/text-workflows
# The tag.
IMAGE_TAG="tl${MLKC_TEXT_WORKFLOWS_TEXLIVE_YEAR}"
# Latest? Tag the image as latest, too.
LATEST=true





# ---

# Check mlkcontext is present at the system
if command -v mlkcontext &> /dev/null
then

  if ! mlkcontext -c $MATCH_MLKCONTEXT ; then exit 1; fi

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
