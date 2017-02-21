#!/bin/bash -x

# extract installation resources
tar -xvzf ArcGIS_Portal_Linux.tar.gz -C /tmp

# run the setup script
sudo su -c "/tmp/PortalForArcGIS/Setup -m silent -l yes -a /vagrant/resources/proprietary/portal.prvc -d /opt -v" arcgis

# copy the startup file to the init.d directory so ArcGIS Portal will know how to start with the instance boot
sudo cp /opt/arcgis/portal/framework/etc/arcgisportal /etc/init.d/

# use sed to edit the arcgisportal init.d file so it knows where to find the installtion of server
sudo sed -e 's/\/arcgis\/portal/\/opt\/arcgis\/portal/' -i /etc/init.d/arcgisportal

# set ArcGIS Portal to start with the instance boot
sudo /lib/systemd/systemd-sysv-install enable arcgisportal