#!/bin/bash

read -p "Are you sure? " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
    # do dangerous stuff
    sudo rm -rf /usr/local/include/mumps
    sudo rm -rf /usr/local/lib/mumps
    sudo rm -f /etc/ld.so.conf.d/mumps.conf
    sudo ldconfig
fi