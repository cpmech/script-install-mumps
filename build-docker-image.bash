#!/bin/bash

docker build --no-cache -t gosl/mumps:latest .
docker images -q -f "dangling=true" | xargs docker rmi
