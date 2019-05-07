#!/bin/bash

# Pushes the image to DockerHub

docker login
docker push malkab/text-workflows:latest
