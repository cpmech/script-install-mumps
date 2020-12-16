#!/bin/bash

sudo apt-get update -y && sudo apt-get install -y --no-install-recommends \
  curl \
  g++ \
  git \
  gfortran \
  libopenblas-dev \
  libopenmpi-dev \
  libparmetis-dev \
  libptscotch-dev \
  libscalapack-mpi-dev \
  libscotch-dev \
  make \
  patch
