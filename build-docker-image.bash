#!/bin/bash

set -e

# arguments
INTEL=${1:-"OFF"}
MPI=${2:-"OFF"}

# suffix
SFX="_open"
if [ "${INTEL}" = "ON" ]; then
    SFX="_intel"
fi

# build Docker image
docker build --no-cache -t mumps$SFX . \
    --build-arg INTEL=$INTEL \
    --build-arg MPI=$MPI

# remove dangling images
docker images -q -f "dangling=true" | xargs docker rmi 2>/dev/null
