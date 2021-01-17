FROM ubuntu:20.04

# essential tools
ENV DEBIAN_FRONTEND=noninteractive
SHELL ["/bin/bash", "-c"]
RUN apt-get update -y && apt-get install -y --no-install-recommends \
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

# copy files
COPY . /tmp/app
WORKDIR /tmp/app

# install MUMPS
RUN bash install-mumps.bash

# configure image for remote development
RUN bash common-debian.sh
