#!/bin/bash

# ensure working with current repos and software
sudo apt-get update
sudo apt-get -y upgrade
sudo apt-get clean

# install prerequsites
sudo apt-get install -y gettext

# extract the config files
tar -xvzf /vagrant/resources/config-files.tar.gz -C /tmp/

# set file handles and process limits
sudo cp /tmp/config_files/limits.conf /etc/security/limits.conf

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

# extract the installation resources
tar -zxvf /vagrant/resources/proprietary/ArcGIS_Server*.tar.gz -C /tmp

# copy hacked diagnostic files so installation does not hang up - not exactly elegant, but it is working so far...
sudo cp /tmp/config_files/check_limits.sh /tmp/ArcGISServer/serverdiag/.diag/
sudo cp /tmp/config_files/check_root_installer.sh /tmp/ArcGISServer/serverdiag/.diag/

# install ArcGIS Server as the arcgis user
sudo su -c "/tmp/ArcGISServer/Setup -m silent -l yes -a /vagrant/resources/proprietary/server.prvc -d /opt/arcgis" arcgis

# copy the startup file to the init.d directory so ArcGIS Server will know how to start with the instance boot
sudo cp /tmp/config_files/arcgisserver /etc/init.d/

# set ArcGIS Server to start with the instance boot
sudo /lib/systemd/systemd-sysv-install enable arcgisserver
