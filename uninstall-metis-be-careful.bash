#!/bin/bash

read -p "Are you sure [y/n]? " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
    echo "sudo rm -rf /usr/local/include/metis"
    sudo rm -rf /usr/local/include/metis

    echo "sudo rm -rf /usr/local/lib/metis"
    sudo rm -rf /usr/local/lib/metis

    echo "sudo rm -f /etc/ld.so.conf.d/metis.conf"
    sudo rm -f /etc/ld.so.conf.d/metis.conf

    echo "sudo ldconfig"
    sudo ldconfig

    echo "DONE"
else
    echo "..cancelled.."
fi
