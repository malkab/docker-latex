#!/bin/bash

IMAGE_TAG=tl2025

docker save -o latex_$IMAGE_TAG.tar.gz latex:$IMAGE_TAG