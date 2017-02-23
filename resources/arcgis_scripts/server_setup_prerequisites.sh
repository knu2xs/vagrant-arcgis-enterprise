#!/bin/bash -x

# install arcgis server prerequsite package
sudo apt-get install -y gettext

# edit the limits.conf file per server prerequsite requirements
sudo sed -e 's/# End of file/* soft nofile 65535\n* hard nofile 65535\n* soft nproc 25059\n* hard nproc 25059\n\n# End of file/' -i /etc/security/limits.conf

# create the arcgis user
sudo useradd arcgis -m -s /bin/bash

# add arcgis user to sudo and users group
sudo usermod -a -G sudo arcgis
sudo usermod -a -G users arcgis

# create the install location
sudo mkdir /opt/arcgis

# change ownerhsip of the install location
sudo chown -R arcgis:users /opt/arcgis

# set permissions of the install location
sudo chmod -R 744 /opt/arcgis