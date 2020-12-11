#!/bin/bash

set -e

# constants
MUMPS_VERSION="5.3.5"
MUMPS_GZ=mumps_$MUMPS_VERSION.orig.tar.gz
MUMPS_DIR=MUMPS_$MUMPS_VERSION
HERE=`pwd`
PDIR=$HERE/patch

# download and exctract the source code
curl http://deb.debian.org/debian/pool/main/m/mumps/$MUMPS_GZ -o /tmp/$MUMPS_GZ
rm -rf $MUMPS_DIR
tar xzf /tmp/$MUMPS_GZ

# patch and compile
cd $MUMPS_DIR
patch -u PORD/lib/Makefile $PDIR/PORD/lib/Makefile.diff
patch -u src/Makefile $PDIR/src/Makefile.diff
cp $PDIR/Makefile.inc .
make d
make z
chmod -x lib/*

# copy include and lib files to the right places
PREFIX=/usr/local
INCDIR=$PREFIX/include/mumps
LIBDIR=$PREFIX/lib/mumps
sudo mkdir -p $INCDIR/
sudo mkdir -p $LIBDIR/
sudo cp -av include/*.h $INCDIR/
sudo cp -av lib/libpord.so $LIBDIR/
sudo cp -av lib/libdmumps.so $LIBDIR/
sudo cp -av lib/libzmumps.so $LIBDIR/
sudo cp -av lib/libmumps_common.so $LIBDIR/
cd $HERE
sudo cp -av mumps.ld.so.conf /etc/ld.so.conf.d/
sudo ldconfig
