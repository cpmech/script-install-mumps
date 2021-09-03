#!/bin/bash

# image name
NAME="mumps_open"

# build Docker image
docker build --no-cache -t $NAME .

# remove dangling images
docker images -q -f "dangling=true" | xargs docker rmi 2>/dev/null

echo
echo
echo
echo "... SUCCESS ..."
echo
echo "... image ${NAME} created ..."
echo
