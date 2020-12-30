#!/bin/bash

set -e

sudo () {
  [[ $EUID = 0 ]] || set -- command sudo "$@"
  "$@"
}

# options
INTEL=${1:-"false"}
SIMPLE=${2:-"false"}
ZNUMBERS=${3:-"false"}

# constants
MUMPS_VERSION="5.3.5"
MUMPS_GZ=mumps_$MUMPS_VERSION.orig.tar.gz
MUMPS_DIR=MUMPS_$MUMPS_VERSION
HERE=`pwd`
PDIR=$HERE/patch

# download and exctract the source code
#curl http://deb.debian.org/debian/pool/main/m/mumps/$MUMPS_GZ -o /tmp/$MUMPS_GZ
rm -rf /tmp/$MUMPS_DIR
cd /tmp
tar xzf /tmp/$MUMPS_GZ
#rm /tmp/$MUMPS_GZ

# patch and compile
cd $MUMPS_DIR
patch -u libseq/Makefile $PDIR/libseq/Makefile.diff
patch -u PORD/lib/Makefile $PDIR/PORD/lib/Makefile.diff
patch -u src/Makefile $PDIR/src/Makefile.diff
patch -u Makefile $PDIR/Makefile.diff
if [ "${INTEL}" = "true" ]; then
  echo ">>>>>>>>>>>>>>>>>>>>>> using Intel MKL/MPI <<<<<<<<<<<<<<<<<<<<<<<<<<<"
  if [ "${SIMPLE}" = "true" ]; then
    echo "...................... simple ..........................."
    cp $PDIR/Makefile.inc.intel.simple.txt Makefile.inc
  else
    cp $PDIR/Makefile.inc.intel.txt Makefile.inc
  fi
else
  echo ">>>>>>>>>>>>>>>>>>>>>> using GCC + Open{Blas,MPI} <<<<<<<<<<<<<<<<<<<<<<<<<<<"
  if [ "${SIMPLE}" = "true" ]; then
    echo "...................... simple ..........................."
    cp $PDIR/Makefile.inc.simple.txt Makefile.inc
  else
    cp $PDIR/Makefile.inc.txt Makefile.inc
  fi
fi
make d
if [ "${ZNUMBERS}" = "true" ]; then
  make z
fi
chmod -x lib/*

# copy include and lib files to the right places
PREFIX=/usr/local
INCDIR=$PREFIX/include/mumps
LIBDIR=$PREFIX/lib/mumps
sudo mkdir -p $INCDIR/
sudo mkdir -p $LIBDIR/
sudo cp -av include/*.h $INCDIR/
sudo cp -av lib/libpord*.* $LIBDIR/
sudo cp -av lib/libdmumps*.* $LIBDIR/
if [ "${ZNUMBERS}" = "true" ]; then
  sudo cp -av lib/libzmumps*.* $LIBDIR/
fi
sudo cp -av lib/libmumps_common*.* $LIBDIR/
cd $HERE
sudo cp -av mumps.ld.so.conf /etc/ld.so.conf.d/
sudo ldconfig