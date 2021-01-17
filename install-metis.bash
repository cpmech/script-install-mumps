#!/bin/bash

set -e

# fake sudo function to be used by docker build
sudo () {
  [[ $EUID = 0 ]] || set -- command sudo "$@"
  "$@"
}

# arguments
INTEL=${1:-"OFF"}

# options
VERSION="4.0.3"
PREFIX="/usr/local"
PREFIX_TMP="/tmp/metis"
INCDIR=$PREFIX/include/metis
LIBDIR=$PREFIX/lib/metis
PDIR=`pwd`/patch/pmetis

# compilers
PLAT=""
if [ "${INTEL}" = "ON" ]; then
    PLAT="_intel"
    CC="mpiicc"
    CXX="mpiicpc"
else
    CC="mpicc"
    CXX="mpicxx"
fi

# prepare installation directory
echo "${LIBDIR}" | sudo tee /etc/ld.so.conf.d/metis.conf >/dev/null
sudo mkdir -p $INCDIR
sudo mkdir -p $LIBDIR

# download and extract the source code into /tmp dir
METIS_GZ=parmetis-$VERSION.tar.gz
METIS_DIR=parmetis-$VERSION
cd /tmp
if [ -d "$METIS_DIR" ]; then
    echo "... removing previous $METIS_DIR directory"
    rm -rf $METIS_DIR
fi
if [ -f "$METIS_GZ" ]; then
    echo "... using existing $METIS_GZ file"
else
    # curl http://glaros.dtc.umn.edu/gkhome/fetch/sw/parmetis/parmetis-$VERSION.tar.gz -o $METIS_GZ
    curl http://deb.debian.org/debian/pool/non-free/p/parmetis/parmetis_$VERSION.orig.tar.gz -o $METIS_GZ
fi

tar xzf $METIS_GZ
cd $METIS_DIR

# compile metis
cd metis
patch -u libmetis/CMakeLists.txt $PDIR/metis/libmetis/CMakeLists.txt.diff
patch -u CMakeLists.txt $PDIR/metis/CMakeLists.txt.diff
rm -rf build
CC=$CC CXX=$CXX cmake \
    -DPLAT=$PLAT \
    -DSHARED=ON \
    -DGKLIB_PATH=GKlib \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=$PREFIX_TMP \
    -B build
cd build && make && make install
cd ../../

# move .h and .so files
sudo mv $PREFIX_TMP/include/*.h $INCDIR/
sudo mv $PREFIX_TMP/lib/*.so $LIBDIR/
sudo ldconfig

# compile parmetis
patch -u libparmetis/CMakeLists.txt $PDIR/libparmetis/CMakeLists.txt.diff
patch -u CMakeLists.txt $PDIR/CMakeLists.txt.diff
rm -rf build
CC=$CC CXX=$CXX cmake \
    -DPLAT=$PLAT \
    -DLIBMETIS_DIR=$LIBDIR \
    -DSHARED=ON \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=$PREFIX_TMP \
    -B build
cd build && make && make install
cd ../../

# move .h and .so files
sudo mv $PREFIX_TMP/include/*.h $INCDIR/
sudo mv $PREFIX_TMP/lib/*.so $LIBDIR/
sudo ldconfig
