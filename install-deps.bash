#!/bin/bash

sudo apt-get update -y && sudo apt-get install -y --no-install-recommends \
  build-essential \
  gcc \
  gfortran \
  libopenmpi-dev \
  libopenblas-dev \
  libmetis-dev \
  libscotch-dev \
  libscalapack-mpi-dev
