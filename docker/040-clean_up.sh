#!/bin/bash

# Clean assets

# Drop install-base container
docker rm $(docker ps -aq --filter "name=text-workflows-install-container")

# Drop the install-base image
docker rmi malkab/text-workflows-install-base:latest
