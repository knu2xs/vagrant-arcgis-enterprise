#!/bin/bash -x

# get fully qualified domain name
FQDN="$(hostname --fqdn)"

# install required packages
sudo apt-get install -y dos2unix fontconfig gettext libice6 libsm6 libxtst6 libxrender1

# extract installation resources
tar -xvzf /vagrant/resources/proprietary/ArcGIS_Portal_Linux.tar.gz -C /tmp

# determine if prvc or ecp license is being used and save the path
if [ -f "/vagrant/resources/proprietary/server.prvc" ]; then
   LICENSE_FILE="/vagrant/resources/proprietary/server.prvc"
elif [ -f "/vagrant/resources/proprietary/server.ecp" ]; then
   LICENSE_FILE="/vagrant/resources/proprietary/server.ecp"
fi

# run the setup script
sudo su -c "/tmp/PortalForArcGIS/Setup -m silent -l yes -a /vagrant/resources/proprietary/portal.prvc -d /opt -v" arcgis

# clean out the installation resources
rm -rf /tmp/PortalForArcGIS

# copy the startup file to the init.d directory so ArcGIS Portal will know how to start with the instance boot
sudo cp /opt/arcgis/portal/framework/etc/arcgisportal /etc/init.d/

# use sed to edit the arcgisportal init.d file so it knows where to find the installtion of server
sudo sed -e 's/\/arcgis\/portal/\/opt\/arcgis\/portal/' -i /etc/init.d/arcgisportal

# set ArcGIS Portal to start with the instance boot
sudo /lib/systemd/systemd-sysv-install enable arcgisportal

# use the admin api to set up the server site using the default config-store and directories locations
curl -X POST -k \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -d 'username=admin&password=Esri3801&fullname=Administrator&email=nobody@esri.com&description=The initial admin account&securityQuestionIdx=1&securityQuestionAns=Mumbai&contentStore={"type":"fileStore","provider":"FileSystem","connectionString":"/opt/arcgis/portal/usr/arcgisportal/content"}&f=json' \
  "https://$FQDN:7443/arcgis/portaladmin/createNewSite"
