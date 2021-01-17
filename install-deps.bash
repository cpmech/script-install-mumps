#!/bin/bash

set -e

# arguments
INTEL=${1:-"OFF"}

# intel compilers + MKL + intel MPI
if [ "${INTEL}" = "ON" ]; then
    curl -L https://apt.repos.intel.com/intel-gpg-keys/GPG-PUB-KEY-INTEL-SW-PRODUCTS.PUB | sudo apt-key add -
    echo "deb https://apt.repos.intel.com/oneapi all main" | sudo tee /etc/apt/sources.list.d/oneAPI.list

# gcc + openblas + openmpi
else
    sudo apt-get update -y && apt-get install -y --no-install-recommends \
        ca-certificates \
        cmake \
        curl \
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
fi
