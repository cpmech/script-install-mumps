#!/bin/bash

docker build --no-cache -t gosl/mumps_dev:latest . --build-arg REM_DEV=1
docker images -q -f "dangling=true" | xargs docker rmi
