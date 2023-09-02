FROM ubuntu:22.04

# essential tools
ENV DEBIAN_FRONTEND=noninteractive
SHELL ["/bin/bash", "-c"]
RUN apt-get update -y && apt-get install -y --no-install-recommends \
  ca-certificates \
  curl \
  gnupg \
  && apt-get clean && rm -rf /var/lib/apt/lists/*

# copy files
COPY . /tmp/script-install-mumps
WORKDIR /tmp/script-install-mumps

# install dependencies
RUN bash install-deps.bash \
  && apt-get clean && rm -rf /var/lib/apt/lists/*

# install libraries
RUN bash install-mumps.bash

# configure image for remote development
RUN bash zscripts/common-debian.sh
