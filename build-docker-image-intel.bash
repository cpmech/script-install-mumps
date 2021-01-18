#!/bin/bash

docker build --no-cache -t mumps_intel . -f Dockerfile-intel
docker images -q -f "dangling=true" | xargs docker rmi
