#!/bin/bash

set -e

INTEL=${1:-"OFF"}
MPI=${2:-"OFF"}

if [ "${INTEL}" = "ON" ]; then
    source /opt/intel/oneapi/setvars.sh --force
fi

bash install-mumps.bash $INTEL OFF    # {open,intel}_seq
bash install-mumps.bash $INTEL OFF ON # {open,intel}_seq_omp

if [ "${MPI}" = "ON" ]; then
    bash install-mumps.bash $INTEL ON    # {open,intel}_mpi
    bash install-mumps.bash $INTEL ON ON # {open,intel}_mpi_omp
fi
