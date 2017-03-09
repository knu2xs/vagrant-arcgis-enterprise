#!/bin/bash -x

# set a few variables for later
USERNAME="admin"
PASSWORD="Esri3801"
FQDN=$(hostname --fqdn)

# configure /etc/sysctl.conf file
sudo sysctl -w vm.max_map_count=262144
sudo sysctl -w vm.swappiness=1

# extract the data store install archive to the temp directory
tar xvzf /vagrant/resources/proprietary/ArcGIS_DataStore_Linux.tar.gz -C /tmp

# run the data store install script
sudo su -c "/tmp/ArcGISDataStore_Linux/Setup -m silent -l yes -d /opt/arcgis" arcgis

# copy the startup file to the init.d directory so ArcGIS Server will know how to start with the instance boot
sudo cp /opt/arcgis/datastore/framework/etc/scripts/arcgisdatastore.service /etc/systemd/system

# set ArcGIS Server to start with the instance boot
sudo systemctl enable arcgisdatastore

# create a location to store data, set permissions, and make arcgis the owner
sudo mkdir /var/spatial
sudo chown arcgis:arcgis /var/spatial
sudo chmod 754 /var/spatial
