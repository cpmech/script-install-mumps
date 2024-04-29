#!/bin/bash

set -e

# fake sudo function to be used by docker build
sudo () {
  [[ $EUID = 0 ]] || set -- command sudo "$@"
  "$@"
}

# install dependencies
sudo apt-get update -y && \
sudo apt-get install -y --no-install-recommends \
    cmake \
    curl \
    g++ \
    gdb \
    gfortran \
    git \
    libmetis-dev \
    libopenblas-dev \
    libopenmpi-dev \
    libscalapack-mpi-dev \
    make \
    patch
