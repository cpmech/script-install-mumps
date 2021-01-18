#!/bin/bash

set -e

source /opt/intel/oneapi/setvars.sh --force
bash install-metis.bash ON
bash install-mumps.bash ON
bash install-mumps.bash ON ON
bash install-mumps.bash ON ON ON
