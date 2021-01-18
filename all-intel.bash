#!/bin/bash

set -e

source /opt/intel/oneapi/setvars.sh
bash install-metis.bash ON
bash install-mumps.bash ON
bash install-mumps.bash ON ON
