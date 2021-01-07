#!/bin/bash

set -e

# arguments
INTEL=${1:-"false"}
SIMPLE=${2:-"false"}
ZNUMBERS=${3:-"false"}

# options
MUMPS_VERSION="5.3.5"
PREFIX=/usr/local

# constants
MUMPS_GZ=mumps_$MUMPS_VERSION.orig.tar.gz
MUMPS_DIR=MUMPS_$MUMPS_VERSION
HERE=`pwd`
PDIR=$HERE/patch

# download and extract the source code into /tmp dir
curl http://deb.debian.org/debian/pool/main/m/mumps/$MUMPS_GZ -o /tmp/$MUMPS_GZ
rm -rf /tmp/$MUMPS_DIR
cd /tmp
tar xzf /tmp/$MUMPS_GZ

# patch Makefiles
cd $MUMPS_DIR
patch -u libseq/Makefile $PDIR/libseq/Makefile.diff
patch -u PORD/lib/Makefile $PDIR/PORD/lib/Makefile.diff
patch -u src/Makefile $PDIR/src/Makefile.diff
patch -u Makefile $PDIR/Makefile.diff

# select Makefile.inc
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

# compile double
make d

# compile complex
if [ "${ZNUMBERS}" = "true" ]; then
    make z
fi

# fake sudo function to be used by docker build
sudo () {
  [[ $EUID = 0 ]] || set -- command sudo "$@"
  "$@"
}

# copy include and lib files to the right places
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

# update ldconfig
echo "/usr/local/lib/mumps" | sudo tee /etc/ld.so.conf.d/mumps.conf
sudo ldconfig