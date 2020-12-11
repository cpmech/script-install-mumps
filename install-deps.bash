#!/bin/bash

sudo apt-get update -y
sudo apt-get install -y --no-install-recommends \
  build-essential \
  gcc \
  gfortran \
  libopenmpi-dev \
  liblapacke-dev \
  libopenblas-dev \
  libmetis-dev \
  libparmetis-dev \
  libscotch-dev \
  libptscotch-dev \
  libatlas-base-dev \
  libscalapack-mpi-dev \
  libsuitesparse-dev \
  libfftw3-dev \
  libfftw3-mpi-dev \
  intel-mkl-full

