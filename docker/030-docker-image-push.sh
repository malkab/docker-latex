#!/bin/bash

# Version: 2021-01-21

# -----------------------------------------------------------------
#
# Document the script purpose here.
#
# -----------------------------------------------------------------
#
# Pushes images to the GitLab registry with confirmation.
#
# -----------------------------------------------------------------
# Check mlkcontext to check. If void, no check will be performed. If NOTNULL,
# any activated context will do, but will fail if no context was activated.
MATCH_MLKCONTEXT=
# A set of images to upload, in the form (image0 image1). Could be multiline
# inside the parentheses. Provide the full image names as shown in docker
# images.
IMAGES=(
  malkab/text-workflows:tl$MLKC_TEXT_WORKFLOWS_TEXLIVE_YEAR
  malkab/text-workflows:latest
)
# The user for login. Leave blank if the default DockerHub repo is going to be
# used.
USER=
# The registry for login. Leave blank if the default DockerHub repo is going to
# be used.
REGISTRY=





# ---

# Check mlkcontext is present at the system
if command -v mlkcontext &> /dev/null ; then

  if ! mlkcontext -c $MATCH_MLKCONTEXT ; then exit 1 ; fi

fi

if [ ${#IMAGES[@]} == 0 ]; then

  echo "No images defined, exiting..."

  exit 1

fi

if [ ! -z "${USER}" ] ; then

  echo Please provide registry credentials, if GitLab, this implies an API token...

  docker login $REGISTRY -u $USER

fi

for IMAGE in "${IMAGES[@]}" ; do

  echo -------------
  echo PUSHING IMAGE ${IMAGE}
  echo -------------
  docker push $IMAGE

done
