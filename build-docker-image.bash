#!/bin/bash

set -e

# arguments
INTEL=${1:-"OFF"}
MPI=${2:-"OFF"}

# image name
NAME="mumps_open"
if [ "${INTEL}" = "ON" ]; then
    NAME="mumps_intel"
fi
if [ "${MPI}" = "ON" ]; then
    NAME="${NAME}_mpi"
fi

# build Docker image
docker build --no-cache -t $NAME . \
    --build-arg INTEL=$INTEL \
    --build-arg MPI=$MPI

# remove dangling images
docker images -q -f "dangling=true" | xargs docker rmi 2>/dev/null

echo
echo
echo
echo "... SUCCESS ..."
echo
echo "... image ${NAME} created ..."
echo
