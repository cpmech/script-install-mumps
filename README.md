# Script to install the MUMPS Sparse Solver

**Warning:** This repository uses an outdated version of MUMPS (**5.4.0**) which is no longer in the Debian repository.

**Note:** This script does not generate the MPI version anymore.

The script `install-mumps.bash` builds both static and dynamic libraries for the MUMPS sparse solver, with OpenMP and without it.

Alternatively, Docker images can be used. The images are based on **ubuntu:20.04**:

```bash
docker pull cpmech/mumps-solver
```

## Installing MUMPS locally (Debian/Linux)

First, install all dependencies:

```bash
./install-deps.bash
```

Then, run:

```bash
./install-mumps.bash [OMP] [DYN] [ZNUMBERS]
```

where:

1. `OMP` = ON or OFF to use OpenMP
2. `DYN` = ON or OFF to compile shared library (.so)
3. `ZNUMBERS` = ON or OFF to compile also zmumps for complex numbers

All libraries can **co-exist** with each other and the **default Debian** libraries in your system. The following combinations are possible:

1. `*_open_seq{.a,.so}` sequential version not using MPI
2. `*_open_seq_omp{.a,.so}` sequential version with OpenMP enabled

You may also compile all combinations with

```bash
./all.bash
```

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
├── libdmumps_open_seq.a
├── libdmumps_open_seq_omp.a
├── libdmumps_open_seq_omp.so
├── libdmumps_open_seq.so
├── libmpiseq_open_seq.a
├── libmpiseq_open_seq_omp.a
├── libmpiseq_open_seq_omp.so
├── libmpiseq_open_seq.so
├── libmumps_common_open_seq.a
├── libmumps_common_open_seq_omp.a
├── libmumps_common_open_seq_omp.so
├── libmumps_common_open_seq.so
├── libpord_open_seq.a
├── libpord_open_seq_omp.a
├── libpord_open_seq_omp.so
├── libpord_open_seq.so
├── libzmumps_open_seq.a
├── libzmumps_open_seq_omp.a
├── libzmumps_open_seq_omp.so
└── libzmumps_open_seq.so

0 directories, 20 files

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
├── mumps_int_def.h
├── smumps_c.h
├── smumps_root.h
├── smumps_struc.h
├── zmumps_c.h
├── zmumps_root.h
└── zmumps_struc.h

0 directories, 15 files
```

## Uninstall

To remove all include and library files, run:

```bash
./uninstall-mumps.bash
```
