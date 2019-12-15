#!/bin/bash

# Pushes the image to DockerHub

IMAGE_TAG=tl2019





# ---

docker login
docker push malkab/text-workflows:$IMAGE_TAG
