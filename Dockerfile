FROM ubuntu:20.04

# essential tools
ENV DEBIAN_FRONTEND=noninteractive
SHELL ["/bin/bash", "-c"]
RUN apt-get update -y && apt-get install -y --no-install-recommends \
  ca-certificates \
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
  patch \
  && apt-get clean && rm -rf /var/lib/apt/lists/*

# install MUMPS
COPY . /tmp/app
WORKDIR /tmp/app
RUN bash install-mumps.bash
