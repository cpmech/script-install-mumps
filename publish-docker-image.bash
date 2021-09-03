#!/bin/bash

# image name
NAME="cpmech/mumps_open"
VERSION="latest"

# publish
docker logout
docker login
docker push $NAME:$VERSION
