#!/bin/bash

set -e

# arguments
INTEL=${1:-"OFF"}
MPI=${2:-"OFF"}

# intel
if [ "${INTEL}" = "ON" ]; then

    source /opt/intel/oneapi/setvars.sh --force

    bash install-metis.bash ON
    bash install-mumps.bash ON OFF    # intel_seq
    bash install-mumps.bash ON OFF ON # intel_seq_omp

    if [ "${MPI}" = "ON" ]; then
        bash install-mumps.bash ON ON    # intel_mpi
        bash install-mumps.bash ON ON ON # intel_mpi_omp
    fi

# open
else

    bash install-mumps.bash OFF OFF    # open_seq
    bash install-mumps.bash OFF OFF ON # open_seq_omp

    if [ "${MPI}" = "ON" ]; then
        bash install-mumps.bash OFF ON    # open_mpi
        bash install-mumps.bash OFF ON ON # open_mpi_omp
    fi
fi
