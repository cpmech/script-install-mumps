# Script to install the MUMPS Sparse Solver

## For Ubuntu 20.10

This script will download MUMPS from the Debian repository and install in the `/usr/local` directory as dynamic library. It will also configure ldconfig in the end.

```bash
bash install-deps.bash
bash install-mumps.bash
```

## Docker Image

```bash
bash build-docker-image.bash
bash docker-shell-into.bash
```
