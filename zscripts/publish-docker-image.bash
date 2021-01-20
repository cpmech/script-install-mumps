#!/bin/bash

MPI=${1:-"OFF"}

USER="cpmech"
VERSION="latest"

NAME="mumps_open"
if [ "${MPI}" = "ON" ]; then
    NAME="${NAME}_mpi"
else
    NAME="${NAME}_seq"
fi

docker image tag $NAME $USER/$NAME:$VERSION

docker logout
docker login
docker push $USER/$NAME:$VERSION
