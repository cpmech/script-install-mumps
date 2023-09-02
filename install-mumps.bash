#!/bin/bash

set -e

# fake sudo function to be used by docker build
sudo () {
  [[ $EUID = 0 ]] || set -- command sudo "$@"
  "$@"
}

# arguments
OMP=${1:-"OFF"}
DYN=${2:-"OFF"}
ZNUMBERS=${3:-"OFF"}

# options
VERSION="5.4.0"
PREFIX="/usr/local"
INCDIR=$PREFIX/include/mumps
LIBDIR=$PREFIX/lib/mumps
PDIR=`pwd`/patch
SOURCE_DIR=`pwd`/source

# selection
SELECTION=".open.seq"
if [ "${OMP}" = "ON" ]; then
    SELECTION="${SELECTION}.omp"
fi
if [ "${DYN}" = "ON" ]; then
    SELECTION="${SELECTION}.dyn"
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
    cp $SOURCE_DIR/$MUMPS_GZ $MUMPS_GZ
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
sudo cp -av lib/libmpiseq*.* $LIBDIR/
if [ "${ZNUMBERS}" = "ON" ]; then
    sudo cp -av lib/libzmumps*.* $LIBDIR/
fi
sudo cp -av lib/libmumps_common*.* $LIBDIR/

# update ldconfig
echo "${LIBDIR}" | sudo tee /etc/ld.so.conf.d/mumps.conf >/dev/null
sudo ldconfig
