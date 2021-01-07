#!/bin/bash

docker build --no-cache -t mumps . --build-arg REM_DEV=1
docker images -q -f "dangling=true" | xargs docker rmi
