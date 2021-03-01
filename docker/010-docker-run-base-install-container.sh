#!/bin/bash

# Version 2021-01-20

# -----------------------------------------------------------------
#
# Run the base image to install TeX Live manually.
#
# -----------------------------------------------------------------
#
# Runs a arbitrary container.
#
# -----------------------------------------------------------------
# Check mlkcontext to check. If void, no check will be performed. If NOTNULL,
# any activated context will do, but will fail if no context was activated.
MATCH_MLKCONTEXT=
# Custom command or path to script (relative to WORKDIR) to execute, for example
# "ls -lh". Leave blank for using the image's built-in option.
COMMAND_EXEC=
# The network to connect to. Remember that when attaching to the network of an
# existing container (using container:name) the HOST is "localhost".
NETWORK=
# Container identifier root. This is used for both the container name (adding an
# UID to avoid clashing) and the container host name (without UID).
ID_ROOT=text-workflows-install-container
# The name of the image to pull, without tag.
IMAGE_NAME=malkab/text-workflows-install-base
# The tag.
IMAGE_TAG=latest
# A set of volumes in the form ("source:destination" "source:destination").
VOLUMES=(
  $(pwd)/:/ext-src/
  $(pwd)/../texlive/texlive-mount-point/:/texlive \
)
# Run mode. Can be PERSISTABLE (-ti), VOLATILE (-ti --rm), or DAEMON (-d). If
# blank, defaults to VOLATILE.
RUN_MODE=PERSISTABLE
# Replicas. If VOLATILE is true will fail. Keep in mind replicas will share
# volumes and all other configuration set. They'll be named with a -# suffix.
# Keep blank for no replicas.
REPLICAS=
# Open ports in the form (external:internal external:internal).
PORTS=(
  8000:8000
)
# Custom entrypoint, leave blank for using the image's built-in option.
ENTRYPOINT=/bin/bash
# Custom workdir.
WORKDIR=/ext-src
# The following options are mutually exclusive. Use display for X11 host server
# in Mac?
X11_MAC=false
# Use display for X11 host server in Linux?
X11_LINUX=false





# ---

# Check mlkcontext is present at the system
if command -v mlkcontext &> /dev/null ; then

  if ! mlkcontext -c $MATCH_MLKCONTEXT ; then exit 1 ; fi

fi

# Manage identifier
if [ ! -z "${ID_ROOT}" ] ; then

  CONTAINER_HOST_NAME="${ID_ROOT}_${MATCH_MLKCONTEXT}"
  CONTAINER_NAME="${CONTAINER_HOST_NAME}_$(uuidgen)"

fi

# Command, if any
if [ ! -z "${COMMAND_EXEC}" ] ; then

  COMMAND_EXEC="-c \"${COMMAND_EXEC}\""

fi

# Network, if any
if [ ! -z "${NETWORK}" ] ; then

  NETWORK="--network=${NETWORK}"

fi

# X11 for Mac
if [ "${X11_MAC}" = true ] ; then

  X11="-e DISPLAY=host.docker.internal:0"

  # Prepare XQuartz server
  xhost + 127.0.0.1

else

  X11=

fi

# X11 for Linux
if [ "${X11_LINUX}" = true ] ; then

  X11="-e DISPLAY=host.docker.internal:0 -v $HOME/.Xauthority:/root/.Xauthority:rw"

else

  X11=

fi

# Container name
if [ ! -z "${CONTAINER_NAME}" ] ; then

  CONTAINER_NAME="--name=${CONTAINER_NAME}"

fi

# Container host name
if [ ! -z "${CONTAINER_HOST_NAME}" ] ; then

  CONTAINER_HOST_NAME="--hostname=${CONTAINER_HOST_NAME}"

fi

# Entrypoint
if [ ! -z "${ENTRYPOINT}" ] ; then

  ENTRYPOINT="--entrypoint ${ENTRYPOINT}"

fi

# Workdir
if [ ! -z "${WORKDIR}" ] ; then

  WORKDIR="--workdir ${WORKDIR}"

fi

# Volumes
VOLUMES_F=

if [ ! -z "${VOLUMES}" ] ; then

  for E in "${VOLUMES[@]}" ; do

    VOLUMES_F="${VOLUMES_F} -v ${E} "

  done

fi

# Ports
PORTS_F=

if [ ! -z "${PORTS}" ] ; then

  for E in "${PORTS[@]}" ; do

    PORTS_F="${PORTS_F} -p ${E} "

  done

fi

# Run mode
if [ ! -z "$RUN_MODE" ] ; then

  if [ "$RUN_MODE" = "PERSISTABLE" ] ; then

    COMMAND="docker run -ti"

  elif [ "$RUN_MODE" = "VOLATILE" ] ; then

    COMMAND="docker run -ti --rm"

  elif [ "$RUN_MODE" = "DAEMON" ] ; then

    COMMAND="docker run -d"

  else

    echo Error: unrecognized RUN_MODE $RUN_MODE, exiting...
    exit 1

  fi

else

  COMMAND="docker run -ti --rm"

fi

# Iterate to produce replicas if VOLATILE is false
if [ ! -z "$REPLICAS" ] ; then

  if [ "$VOLATILE" = true ] ; then

    echo VOLATILE true and REPLICAS not blank are incompatible options

    exit 1

  fi

  for REPLICA in $(seq 1 $REPLICAS) ; do

    eval  $COMMAND \
          $NETWORK \
          ${CONTAINER_NAME}-${REPLICA} \
          ${CONTAINER_HOST_NAME}-${REPLICA} \
          $X11 \
          $VOLUMES_F \
          $PORTS_F \
          $ENTRYPOINT \
          $WORKDIR \
          $IMAGE_NAME:$IMAGE_TAG \
          $COMMAND_EXEC

  done

else

  eval  $COMMAND \
        $NETWORK \
        ${CONTAINER_NAME} \
        ${CONTAINER_HOST_NAME} \
        $X11 \
        $VOLUMES_F \
        $PORTS_F \
        $ENTRYPOINT \
        $WORKDIR \
        $IMAGE_NAME:$IMAGE_TAG \
        $COMMAND_EXEC

fi
