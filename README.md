# Script to install the MUMPS Sparse Solver

The script `install-mumps.bash` builds both static and **dynamic** libraries for the MUMPS sparse solver. The script offers an option to use the Intel compilers.

The script downloads MUMPS' source code from the Debian repository, compiles the code and installs the headers to `/usr/local/include/mumps` and the libraries (static and **dynamic**) to `/usr/local/lib/mumps`. The intel libraries have the suffix `_intel`.

You may build a Docker image or run the script directly in an Ubuntu/Linux system. The docker image is quite convenient for use with Visual Code remote development tools.

## Docker Image

We can build the Docker image by running:

```bash
bash build-docker-image.bash
```

Open the terminal in a temporary Docker container:

```bash
docker run --rm -it mumps /bin/bash
```

Or use with [Visual Code Remote Development](https://code.visualstudio.com/docs/remote/remote-overview). To do so, create a directory and copy the `.devcontainer` directory into it.


## Ubuntu/Linux 20.10

The installation in Ubuntu/Linux is quite simple too. First, install OpenBLAS and ordering packages and then run the script as follows.

### Install dependencies:

```bash
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
  make \
  patch
```

### Compile and install MUMPS on Ubuntu:

Execute the following command:

```bash
bash install-mumps.bash
```

To use the Intel compilers (and MKL), execute the following command:

```bash
bash install-mumps true
```

### Remove include and library files on Ubuntu:

Execute the following command:

```bash
./uninstall-mumps-be-careful.bash
```

Output:

```
Are you sure [y/n]? y
sudo rm -rf /usr/local/include/mumps
sudo rm -rf /usr/local/lib/mumps
sudo rm -f /etc/ld.so.conf.d/mumps.conf
sudo ldconfig
DONE
```