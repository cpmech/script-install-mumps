#!/bin/bash

docker build --no-cache -t mumps_open . -f Dockerfile-open
docker images -q -f "dangling=true" | xargs docker rmi
