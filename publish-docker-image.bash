#!/bin/bash

# image name
NAME="cpmech/mumps-solver"
VERSION="latest"

# publish
docker logout
docker login
docker push $NAME:$VERSION
