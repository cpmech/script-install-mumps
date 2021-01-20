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

For the Intel case with MPI, `install-mumps.bash` will call the `install-metis.bash` script to install ParMetis because we cannot use Debian's libparmetis-dev with Intel. Then, the {Par}Metis include files and libraries will be copied to `/usr/local/include/metis` and `/usr/local/lib/metis`, respectively.

If you compile the code using the Intel tools (after `source setvars.sh`) and decide to compile the `_open` version, you'll have to open another terminal (because of setvars.sh).

## Docker

We can build the Docker image by running:

```bash
./build-docker-image.bash [INTEL] [MPI]
```

Both the `*_mpi` and `*_seq` Docker images will include the `*_omp` libraries. Also, the `*_mpi` Docker image will also contain the `*_seq` libraries.

The Docker image will have a size of approximately 1GB; however, the `_intel` Docker image will be about 8GB!

For instance (output of `docker image ls`):

```
REPOSITORY       TAG     IMAGE ID  CREATED         SIZE
mumps_open_mpi   latest  ...       2 minutes ago   933MB
mumps_open_seq   latest  ...       12 minutes ago  807MB
mumps_intel_seq  latest  ...       22 minutes ago  7.36GB
mumps_intel_mpi  latest  ...       40 minutes ago  8GB
```

To check the Docker image, open a terminal in a temporary Docker container:

```bash
docker run --rm -it mumps_open_seq /bin/bash
# or
docker run --rm -it mumps_intel_mpi /bin/bash
```

To use [Visual Code Remote Development](https://code.visualstudio.com/docs/remote/remote-overview), copy the directory named `.devcontainer` to your project. Then, open your project folder in VS Code and click the green button at the window's left-bottom corner. Choose _Reopen in Container_. See image below:

![](vscode-open-in-container.gif)

If you want to debug using the VS Code editor, copy the `.vscode` directory to your project and modify as appropriate. See the example below of how convenient it is to use VS Code for debugging the code.

![](Script_Install_MUMPS_1.gif)

## Installed files

Considering all flag combinations, we get (from `tree /usr/local/lib/mumps`):

```
/usr/local/lib/mumps
├── libdmumps_intel_mpi.a
├── libdmumps_intel_mpi_omp.a
├── libdmumps_intel_mpi_omp.so
├── libdmumps_intel_mpi.so
├── libdmumps_intel_seq.a
├── libdmumps_intel_seq_omp.a
├── libdmumps_intel_seq_omp.so
├── libdmumps_intel_seq.so
├── libdmumps_open_mpi.a
├── libdmumps_open_mpi_omp.a
├── libdmumps_open_mpi_omp.so
├── libdmumps_open_mpi.so
├── libdmumps_open_seq.a
├── libdmumps_open_seq_omp.a
├── libdmumps_open_seq_omp.so
├── libdmumps_open_seq.so
├── libmpiseq_intel_seq_omp.so
├── libmpiseq_intel_seq.so
├── libmpiseq_open_seq_omp.so
├── libmpiseq_open_seq.so
├── libmumps_common_intel_mpi.a
├── libmumps_common_intel_mpi_omp.a
├── libmumps_common_intel_mpi_omp.so
├── libmumps_common_intel_mpi.so
├── libmumps_common_intel_seq.a
├── libmumps_common_intel_seq_omp.a
├── libmumps_common_intel_seq_omp.so
├── libmumps_common_intel_seq.so
├── libmumps_common_open_mpi.a
├── libmumps_common_open_mpi_omp.a
├── libmumps_common_open_mpi_omp.so
├── libmumps_common_open_mpi.so
├── libmumps_common_open_seq.a
├── libmumps_common_open_seq_omp.a
├── libmumps_common_open_seq_omp.so
├── libmumps_common_open_seq.so
├── libpord_intel_mpi.a
├── libpord_intel_mpi_omp.a
├── libpord_intel_mpi_omp.so
├── libpord_intel_mpi.so
├── libpord_intel_seq.a
├── libpord_intel_seq_omp.a
├── libpord_intel_seq_omp.so
├── libpord_intel_seq.so
├── libpord_open_mpi.a
├── libpord_open_mpi_omp.a
├── libpord_open_mpi_omp.so
├── libpord_open_mpi.so
├── libpord_open_seq.a
├── libpord_open_seq_omp.a
├── libpord_open_seq_omp.so
├── libpord_open_seq.so
├── libzmumps_intel_mpi.a
├── libzmumps_intel_mpi_omp.a
├── libzmumps_intel_mpi_omp.so
├── libzmumps_intel_mpi.so
├── libzmumps_intel_seq.a
├── libzmumps_intel_seq_omp.a
├── libzmumps_intel_seq_omp.so
├── libzmumps_intel_seq.so
├── libzmumps_open_mpi.a
├── libzmumps_open_mpi_omp.a
├── libzmumps_open_mpi_omp.so
├── libzmumps_open_mpi.so
├── libzmumps_open_seq.a
├── libzmumps_open_seq_omp.a
├── libzmumps_open_seq_omp.so
└── libzmumps_open_seq.so

0 directories, 68 files
```

The include files are:

```
/usr/local/include/mumps
├── cmumps_c.h
├── cmumps_root.h
├── cmumps_struc.h
├── dmumps_c.h
├── dmumps_root.h
├── dmumps_struc.h
├── mumps_compat.h
├── mumps_c_types.h
├── mumps_int_def.h
├── smumps_c.h
├── smumps_root.h
├── smumps_struc.h
├── zmumps_c.h
├── zmumps_root.h
└── zmumps_struc.h
```

And, if Intel + MPI is selected, we get:

```
/usr/local/include/metis
├── metis.h
└── parmetis.h
```

## Uninstall

To remove all include and library files, run:

1. `uninstall-mumps.bash`
2. `uninstall-parmetis.bash`
