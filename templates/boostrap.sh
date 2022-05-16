#!/usr/bin/env bash

set -e
set -u

sudo yum clean all
sudo yum -y install epel-release

sudo yum -y install glibc-devel libpciaccess-devel gcc-c++
