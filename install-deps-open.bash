#!/bin/bash

set -e

sudo apt-get update -y && \
sudo apt-get install -y --no-install-recommends \
    cmake \
    g++ \
    gdb \
    git \
    gfortran \
    libopenblas-dev \
    libopenmpi-dev \
    libparmetis-dev \
    libptscotch-dev \
    libscalapack-mpi-dev \
    make \
    patch
