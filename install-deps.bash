#!/bin/bash

set -e

# fake sudo function to be used by docker build
sudo () {
  [[ $EUID = 0 ]] || set -- command sudo "$@"
  "$@"
}

# arguments
INTEL=${1:-"OFF"}

# intel
if [ "${INTEL}" = "ON" ]; then
    # add intel list to APT:
    cd /tmp
    wget https://apt.repos.intel.com/intel-gpg-keys/GPG-PUB-KEY-INTEL-SW-PRODUCTS.PUB
    sudo apt-key add GPG-PUB-KEY-INTEL-SW-PRODUCTS.PUB
    echo "deb https://apt.repos.intel.com/oneapi all main" | sudo tee /etc/apt/sources.list.d/oneAPI.list

    # install the compilers, MKL and MPI
    sudo apt-get update -y \
    && sudo apt-get install -y --no-install-recommends \
    intel-oneapi-compiler-dpcpp-cpp-and-cpp-classic \
    intel-oneapi-compiler-fortran \
    intel-oneapi-mkl-devel \
    intel-oneapi-mpi-devel

    # install deps
    sudo apt-get update -y && apt-get install -y --no-install-recommends \
    ca-certificates \
    cmake \
    curl \
    gdb \
    git \
    make \
    patch \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# gcc
else
    # install deps
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
    patch \
    && apt-get clean && rm -rf /var/lib/apt/lists/*
fi
