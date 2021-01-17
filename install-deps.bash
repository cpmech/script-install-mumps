#!/bin/bash

set -e

# arguments
INTEL=${1:-"OFF"}

# intel compilers + MKL + intel MPI
if [ "${INTEL}" = "ON" ]; then
    curl -L https://apt.repos.intel.com/intel-gpg-keys/GPG-PUB-KEY-INTEL-SW-PRODUCTS.PUB | sudo apt-key add -
    echo "deb https://apt.repos.intel.com/oneapi all main" | sudo tee /etc/apt/sources.list.d/oneAPI.list

    sudo apt-get update -y && \
    sudo apt-get install -y --no-install-recommends \
        cmake \
        g++ \
        gdb \
        git \
        intel-oneapi-compiler-dpcpp-cpp-and-cpp-classic \
        intel-oneapi-compiler-fortran \
        intel-oneapi-mkl-devel \
        intel-oneapi-mpi-devel\
        make \
        patch

# gcc + openblas + openmpi
else
    sudo apt-get update -y && \
    sudo apt-get install -y --no-install-recommends \
        cmake \
        g++ \
        gdb \
        git \
        gfortran \
        libopenblas-dev \
        libopenmpi-dev \
        libscalapack-mpi-dev \
        make \
        patch
fi
