# Script to install the MUMPS Sparse Solver

The script `install-mumps.bash` builds both static and **dynamic** libraries for the MUMPS sparse solver. We offer options to use the Intel compilers and to use OpenMP. If needed, we also compile ParMetis with Intel MPI.

We also present a Dockerfile to build a Docker image. Note that with a Docker image, you won't "mess up" with your system. And you may use the very nice [Visual Code Remote Development](https://code.visualstudio.com/docs/remote/remote-overview) extension (here, "containerized dev" and not "remote dev" though). See the Docker section below.

The script `install-mumps.bash` downloads MUMPS' source code from the Debian repository, compiles the code and installs the headers to `/usr/local/include/mumps` and the libraries to `/usr/local/lib/mumps`.

We consider two sets of tools:

1. `_open`: GCC GFortran + OpenBLAS + OpenMPI; and
2. `_intel`: Intel compilers + Intel MKL + Intel MPI

## Usage (Debian/Linux)

Execute:

```bash
./install-deps.bash [INTEL] [MPI]
# and
./install-mumps.bash [INTEL] [MPI] [OMP] [ZNUMBERS]
```

where (the default options are all "OFF"):

1. INTEL -- "ON" or "OFF" => use the Intel tools
2. MPI -- "ON" or "OFF" => use {Intel,Open}MPI
3. OMP -- "ON" or "OFF" => allow use of OpenMP when posible
4. ZNUMBERS -- "ON" or "OFF" => compile also zmumps for complex numbers

The resulting libraries will have appropriate suffixes such as `_open` or `_intel`. All libraries can co-exist with each other and the default Debian libraries in your system. The following combinations are possible:

1. `_{open,intel}_seq` "sequential" version not using MPI
2. `_{open,intel}_seq_omp` as before but with OpenMP enabled
3. `_{open,intel}_mpi` version using MPI
4. `_{open,intel}_mpi_omp` as before but with OpenMP enabled

To install both non-OMP and OMP versions, use:

```bash
./all.bash [INTEL] [MPI]
```

**NOTE:** For the Intel case with MPI, `install-mumps.bash` will call the `install-metis.bash` script to install ParMetis because we cannot use Debian's libparmetis-dev with Intel. Then, the {Par}Metis include files and libraries will be copied to `/usr/local/include/metis` and `/usr/local/lib/metis`, respectively.

**NOTE:** If you compile the code using the Intel tools (after `source setvars.sh`) and decide to compile the `_open` version, you'll have to open another terminal (because of setvars.sh).

## Docker

We can build the Docker image by running:

```bash
./build-docker-image.bash [INTEL] [MPI]
```

**NOTE:** The Docker image will have a size of approximately 1GB; however, the `_intel` Docker image will be about 8GB!

To check the Docker image, open a terminal in a temporary Docker container:

```bash
docker run --rm -it mumps_open /bin/bash
# or
docker run --rm -it mumps_intel /bin/bash
```

To use [Visual Code Remote Development](https://code.visualstudio.com/docs/remote/remote-overview), copy the directory named `.devcontainer` to your project. Then, open your project folder in VS Code and click the green button at the window's left-bottom corner. Choose _Reopen in Container_. See image below:

![](vscode-open-in-container.gif)

If you want to debug using the VS Code editor, copy the `.vscode` directory to your project and modify as appropriate. See the example below of how convenient it is to use VS Code for debugging the code.

![](Script_Install_MUMPS_1.gif)

## Installed files

## Remove include and library files

1. `uninstall-metis.bash`
2. `uninstall-mumps.bash`
