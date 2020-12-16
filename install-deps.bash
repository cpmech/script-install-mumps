#!/bin/bash

sudo apt-get update -y && sudo apt-get install -y --no-install-recommends \
  curl \
  g++ \
  git \
  gfortran \
  libmetis-dev \
  libopenblas-dev \
  libopenmpi-dev \
  libscalapack-mpi-dev \
  libscotch-dev \
  make \
  patch
