#!/bin/bash

IMAGE_TAG=tl2025

docker build -f Dockerfile -t latex_manual_install:$IMAGE_TAG .