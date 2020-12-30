#!/bin/bash

sudo rm -rf /usr/local/include/mumps
sudo rm -rf /usr/local/lib/mumps
sudo rm -f /etc/ld.so.conf.d/mumps.ld.so.conf
sudo ldconfig
