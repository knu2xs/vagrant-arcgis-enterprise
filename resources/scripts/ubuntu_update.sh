#!/bin/bash -x

# ensure working with current repos and software
sudo apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get -y -o DPkg::options::="--force-confdef" -o DPkg::options::="--force-confold"  dist-upgrade
