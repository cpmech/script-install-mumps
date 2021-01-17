#!/bin/bash

set -e

INTEL=${1:-"ON"}
OMP=${3:-"OFF"}
SEQ=${2:-"OFF"}
SIMPLE=${4:-"OFF"}
ZNUMBERS=${5:-"OFF"}

echo
echo 
echo "### Installing {Par}METIS ##############################################"
bash install-metis.bash $INTEL

echo
echo 
echo "### Installing MUMPS ###################################################"
bash install-mumps.bash $INTEL $OMP $SEQ $SIMPLE $ZNUMBERS
