#!/bin/sh

set -e
set -u

cd /tmp

wget  https://packages.endpointdev.com/rhel/7/os/x86_64/endpoint-repo.x86_64.rpm

sudo rpm -ivh *.rpm

sudo yum -y install git