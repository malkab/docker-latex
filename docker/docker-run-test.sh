#!/bin/bash

MKDOCSSERVERPORT=8000

# Run
docker run -ti --rm \
    -v `pwd`/../examples/:/ext-src/ \
    --name text-workflows-test \
    -p "${MKDOCSSERVERPORT}:8000" \
    --workdir /ext-src \
    malkab/text-workflows
