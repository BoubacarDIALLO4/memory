#!/usr/bin/env bash

set -e
set -u


wget http://mirror.centos.org/centos/7/os/x86_64/Packages/kernel-devel-3.10.0-1160.el7.x86_64.rpm
wget http://mirror.centos.org/centos/7/os/x86_64/Packages/kernel-3.10.0-1160.el7.x86_64.rpm

sudo rpm -ivh *.rpm

sudo yum -y install glibc-devel libpciaccess-devel gcc-c++


# Cmake
wget https://cmake.org/files/v3.12/cmake-3.12.3.tar.gz

tar zxvf cmake-3.*
cd cmake-3.*
./bootstrap --prefix=/usr/local
gmake
make -j$(nproc)
sudo make install

sudo ln -s /usr/local/bin/cmake /usr/bin/cmake

# Install git 2.34 in the Edge station
cd /tmp

wget  https://packages.endpointdev.com/rhel/7/os/x86_64/endpoint-repo.x86_64.rpm

sudo rpm -ivh *.rpm

sudo yum -y install git