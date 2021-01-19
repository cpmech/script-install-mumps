#!/bin/bash

set -e

# fake sudo function to be used by docker build
sudo () {
  [[ $EUID = 0 ]] || set -- command sudo "$@"
  "$@"
}

# arguments
INTEL=${1:-"OFF"}
MPI=${2:-"OFF"}
OMP=${3:-"OFF"}
ZNUMBERS=${4:-"OFF"}

# compile ParMetis
if [ "${INTEL}" = "ON" ] && [ "${MPI}" = "ON" ]; then
    bash ./install-parmetis ON
fi

# options
VERSION="5.3.5"
PREFIX="/usr/local"
INCDIR=$PREFIX/include/mumps
LIBDIR=$PREFIX/lib/mumps
PDIR=`pwd`/patch

# selection
SELECTION=".open"
if [ "${INTEL}" = "ON" ]; then
    SELECTION=".intel"
fi
if [ "${MPI}" = "ON" ]; then
    SELECTION="${SELECTION}.mpi"
else
    SELECTION="${SELECTION}.seq"
fi
if [ "${OMP}" = "ON" ]; then
    SELECTION="${SELECTION}.omp"
fi

# download and extract the source code into /tmp dir
MUMPS_GZ=mumps_$VERSION.orig.tar.gz
MUMPS_DIR=MUMPS_$VERSION
cd /tmp
if [ -d "$MUMPS_DIR" ]; then
    echo "... removing previous $MUMPS_DIR directory"
    rm -rf $MUMPS_DIR
fi
if [ -f "$MUMPS_GZ" ]; then
    echo "... using existing $MUMPS_GZ file"
else
    curl http://deb.debian.org/debian/pool/main/m/mumps/$MUMPS_GZ -o $MUMPS_GZ
fi
tar xzf $MUMPS_GZ
cd $MUMPS_DIR

# patch Makefiles
patch -u libseq/Makefile $PDIR/libseq/Makefile.diff
patch -u PORD/lib/Makefile $PDIR/PORD/lib/Makefile.diff
patch -u src/Makefile $PDIR/src/Makefile.diff
patch -u Makefile $PDIR/Makefile.diff
cp $PDIR/Makefile.inc$SELECTION.txt Makefile.inc

# compile double
make d

# compile complex
if [ "${ZNUMBERS}" = "ON" ]; then
    make z
fi

# copy include and lib files to the right places
sudo mkdir -p $INCDIR/
sudo mkdir -p $LIBDIR/
sudo cp -av include/*.h $INCDIR/
sudo cp -av lib/libpord*.* $LIBDIR/
sudo cp -av lib/libdmumps*.* $LIBDIR/
if [ "${ZNUMBERS}" = "ON" ]; then
  sudo cp -av lib/libzmumps*.* $LIBDIR/
fi
sudo cp -av lib/libmumps_common*.* $LIBDIR/

# update ldconfig
echo "${LIBDIR}" | sudo tee /etc/ld.so.conf.d/mumps.conf >/dev/null
sudo ldconfig
