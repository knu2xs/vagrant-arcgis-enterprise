#!/bin/bash -x

# get the fully qualified domain name
FQDN=$(hostname -fqdn)
USERNAME="admin"
PASSWORD="Esri3801"

# create the location to store the data
sudo mkdir /var/spatial/relational
sudo chown arcgis:arcgis /var/spatial/relational

# set up a relational data store to support feature layer publishing
sudo su -c "/opt/arcgis/datastore/tools/configuredatastore.sh https://$FQDN:6443/arcgis $USERNAME $PASSWORD /var/spatial/relational --stores relational" arcgis
