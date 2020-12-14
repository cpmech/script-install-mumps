FROM ubuntu:20.04

# disable tzdata questions
ENV DEBIAN_FRONTEND=noninteractive

# use bash
SHELL ["/bin/bash", "-c"]

# enable non-free
RUN sed -i "s#deb http://deb.debian.org/debian sid main#deb http://deb.debian.org/debian sid main non-free#g" /etc/apt/sources.list

# install apt-utils
RUN apt-get update -y && \
  apt-get install -y apt-utils 2> >( grep -v 'debconf: delaying package configuration, since apt-utils is not installed' >&2 ) \
  && apt-get clean && rm -rf /var/lib/apt/lists/*

# essential tools
RUN apt-get update -y && apt-get install -y --no-install-recommends \
  ca-certificates \
  netbase \
  curl \
  git \
  && apt-get clean && rm -rf /var/lib/apt/lists/*

# required compilers and libraries for gosl
RUN apt-get update -y && apt-get install -y --no-install-recommends \
  build-essential \
  gcc \
  gfortran \
  libopenmpi-dev \
  libopenblas-dev \
  libmetis-dev \
  libscotch-dev \
  libscalapack-mpi-dev \
  && apt-get clean && rm -rf /var/lib/apt/lists/*

# copy patches and script
COPY patch /tmp/patch
COPY install-mumps.bash /tmp/install-mumps.bash 

# download the source code of MUMPS and compile it
WORKDIR /tmp
RUN bash install-mumps.bash
