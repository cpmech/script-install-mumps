# Script to install the MUMPS Sparse Solver

**Note:** This script does not generate the MPI version anymore.

The script `install-mumps.bash` builds both static and dynamic libraries for the MUMPS sparse solver (with OpenMP). The source code is downloaded from the Debian repository.

Alternatively, Docker images can be used. The images are based on **ubuntu:22.04**:

```bash
docker pull cpmech/mumps-solver
```

## Installing MUMPS locally (Debian/Linux)

First, install all dependencies:

```bash
./install-deps.bash
```

and (if you want to use Intel MKL and Fortran compiler)

```bash
./install-intel-mkl-and-ifort-linux
```

Then, run (for OpenBLAS):

```bash
./install-mumps.bash
```

Or, run (with Intel MKL):

```bash
./install-mumps.bash mkl
```

All libraries can **co-exist** with each other and the **default Debian** libraries in your system. The following combinations are possible:

## Docker

The Docker image can be built by running:

```bash
./build-docker-image.bash
```

To check the Docker image, open a terminal in a temporary Docker container:

```bash
docker run --rm -it mumps-solver /bin/bash
```

To use [Visual Code Remote Development](https://code.visualstudio.com/docs/remote/remote-overview), copy the directory named `.devcontainer` to your project. Then, open your project folder in VS Code and click the green button at the window's left-bottom corner. Choose _Reopen in Container_.

If you want to debug using the VS Code editor, copy the `.vscode` directory to your project and modify as appropriate.

The figure below shows VS Code Remote Dev + Docker + Debugging:

![VS Code Remote Development](Script-Install-Mumps-001.gif)

## Installed files

The following libraries are installed, considering all flag combinations (from `tree /usr/local/lib/mumps`):

```text
/usr/local/lib/mumps
├── libdmumps_cpmech.a
├── libdmumps_cpmech.so
├── libmpiseq_cpmech.a
├── libmpiseq_cpmech.so
├── libmumps_common_cpmech.a
├── libmumps_common_cpmech.so
├── libpord_cpmech.a
├── libpord_cpmech.so
├── libzmumps_cpmech.a
└── libzmumps_cpmech.so

0 directories, 10 files
```

The include files are (from `tree /usr/local/include/mumps`):

```text
/usr/local/include/mumps
├── cmumps_c.h
├── cmumps_root.h
├── cmumps_struc.h
├── dmumps_c.h
├── dmumps_root.h
├── dmumps_struc.h
├── mumps_compat.h
├── mumps_c_types.h
├── smumps_c.h
├── smumps_root.h
├── smumps_struc.h
├── zmumps_c.h
├── zmumps_root.h
└── zmumps_struc.h

0 directories, 14 files
```

## Uninstall

To remove all include and library files, run:

```bash
./uninstall-mumps.bash
```

## Development

Use `diff -u original.file modified.file`. The `-u` option stands for unified.
