#!/bin/bash

INTEL=${1:-"OFF"}

if [ "${INTEL}" = "ON" ]; then
    docker build --no-cache -t mumps_intel . -f Dockerfile-intel
else
    docker build --no-cache -t mumps .
fi

docker images -q -f "dangling=true" | xargs docker rmi
