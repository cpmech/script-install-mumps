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

Open your project folder (e.g. this repo folder) in Visual Studio Code and click the green button at the window's left-bottom corner. Then choose _Reopen in Container_.

![](vscode-open-in-container.gif)

If you want to debug using  VS Code, copy the `.vscode` directory to your project and modify as appropriate. See the example below of how convenient it is to use VS Code for debugging the code.

![](Script_Install_MUMPS_1.gif)

## Ubuntu/Linux 20.10

The installation in Ubuntu/Linux is quite simple too. First, install OpenBLAS and ordering packages and then run the script as follows.

### Install dependencies:

#### Without MPI (seq)

```bash
sudo apt-get update -y \
&& sudo apt-get install -y --no-install-recommends \
  curl \
  g++ \
  gdb \
  git \
  gfortran \
  libopenblas-dev \
  libmetis-dev \
  make \
  patch
```

#### With MPI

```bash
sudo apt-get update -y \
&& sudo apt-get install -y --no-install-recommends \
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
  patch
```

### Compile and install MUMPS on Ubuntu:

Execute the following command:

```bash
bash install-mumps.bash
```

To use the Intel compilers (and MKL), execute the following command:

```bash
bash install-mumps.bash ON
```

To enable OpenMPI, with Intel or not, set the second argument to ON:

```bash
bash install-mumps.bash {ON,OFF} ON
```

By default, this script will compile MUMPS with METIS and SCOTCH. To compile a _simple_ version without those libraries, run:

```bash
bash install-mumps.bash {ON,OFF} {ON,OFF} ON
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

## Installing Intel Tools

Reference: https://software.intel.com/content/www/us/en/develop/articles/installing-intel-oneapi-toolkits-via-apt.html

Add intel list to APT:

```bash
cd /tmp
wget https://apt.repos.intel.com/intel-gpg-keys/GPG-PUB-KEY-INTEL-SW-PRODUCTS.PUB
sudo apt-key add GPG-PUB-KEY-INTEL-SW-PRODUCTS.PUB
echo "deb https://apt.repos.intel.com/oneapi all main" | sudo tee /etc/apt/sources.list.d/oneAPI.list
```

Install the compilers, MKL and MPI

```bash
sudo apt-get update -y \
&& sudo apt-get install -y --no-install-recommends \
  intel-oneapi-compiler-dpcpp-cpp-and-cpp-classic \
  intel-oneapi-compiler-fortran \
  intel-oneapi-mkl-devel \
  intel-oneapi-mpi-devel
```

As an alternative, `sudo apt-get install intel-hpckit` brings "everything".

You may then run `source /opt/intel/oneapi/setvars.sh` to prepare the environment or, better, run with a configuration and only the tools we need. First, create the `config.txt` file:

```
default=exclude
compiler=latest
mkl=latest
mpi=latest
```

Then, run:

```
source /opt/intel/oneapi/setvars.sh --config="config.txt"
```
