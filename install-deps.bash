#!/bin/bash

set -e

# fake sudo function to be used by docker build
sudo () {
  [[ $EUID = 0 ]] || set -- command sudo "$@"
  "$@"
}

# arguments
INTEL=${1:-"OFF"}
MPI=${2:-"OFF"}

# install essential tools
sudo apt-get update -y && \
sudo apt-get install -y --no-install-recommends \
    cmake \
    g++ \
    gdb \
    git \
    libmetis-dev \
    make \
    patch

# install Intel tools
if [ "${INTEL}" = "ON" ]; then

    # create oneAPI apt source file
    curl -L https://apt.repos.intel.com/intel-gpg-keys/GPG-PUB-KEY-INTEL-SW-PRODUCTS.PUB | sudo apt-key add -
    echo "deb https://apt.repos.intel.com/oneapi all main" | sudo tee /etc/apt/sources.list.d/oneAPI.list

    # install Intel compilers and MKL
    sudo apt-get update -y && \
    sudo apt-get install -y --no-install-recommends \
        intel-oneapi-compiler-dpcpp-cpp-and-cpp-classic \
        intel-oneapi-compiler-fortran \
        intel-oneapi-mkl-devel
    
    # if MPI, install Intel MPI
    if [ "${MPI}" = "ON" ]; then
        sudo apt-get install -y --no-install-recommends \
            intel-oneapi-mpi-devel
    fi

# install "Open" tools
else

    # install GNU compilers and OpenBLAS
    sudo apt-get install -y --no-install-recommends \
        gfortran \
        libopenblas-dev

    # if MPI, install OpenMPI (and other libs)
    if [ "${MPI}" = "ON" ]; then
        sudo apt-get install -y --no-install-recommends \
            libopenmpi-dev \
            libparmetis-dev \
            libptscotch-dev \
            libscalapack-mpi-dev
    fi
fi
