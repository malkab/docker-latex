#!/bin/bash

# Clean assets

# Drop install-base container

docker rm text-workflows-install-container

# Drop the install-base image

docker rmi malkab/text-workflows-install-base:latest
