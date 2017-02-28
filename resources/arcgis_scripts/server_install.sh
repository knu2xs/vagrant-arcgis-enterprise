#!/bin/bash -x

### SETUP PREREQUISITES ###
# install arcgis server prerequsite package
sudo apt-get install -y gettext

# edit the limits.conf file per server prerequsite requirements
sudo sed -e 's/# End of file/* soft nofile 65535\n* hard nofile 65535\n* soft nproc 25059\n* hard nproc 25059\n\n# End of file/' -i /etc/security/limits.conf


### INSTALL ARCGIS SERVER ###
# extract the installation resources from the vagrant directory
tar -zxvf /vagrant/resources/proprietary/ArcGIS_Server*.tar.gz -C /tmp

# hack the limits check and the root installer files so the install does not hang up
sudo echo '#!/bin/bash' > /tmp/ArcGISServer/serverdiag/.diag/check_limits.sh
sudo echo 'exit $STATUS_PASSED' >> /tmp/ArcGISServer/serverdiag/.diag/check_limits.sh
sudo cp /tmp/ArcGISServer/serverdiag/.diag/check_limits.sh /tmp/ArcGISServer/serverdiag/.diag/check_root_installer.sh

# install ArcGIS Server as the arcgis user
sudo su -c "/tmp/ArcGISServer/Setup -m silent -l yes -a /vagrant/resources/proprietary/server.prvc -d /opt/arcgis -v" arcgis

# clean out the installation resources
rm -rf /tmp/ArcGISServer

# copy the startup file to the init.d directory so ArcGIS Server will know how to start with the instance boot
sudo cp /opt/arcgis/server/framework/etc/scripts/arcgisserver /etc/init.d/

# use sed to edit the arcgisserver init.d file so it knows where to find the installtion of server
sudo sed -e 's/\/arcgis\/server/\/opt\/arcgis\/server/' -i /etc/init.d/arcgisserver

# set ArcGIS Server to start with the instance boot
sudo /lib/systemd/systemd-sysv-install enable arcgisserver


### SERVER POST-INSTALL ###
# use the admin api to set up the server site using the default config-store and directories locations
curl -X POST \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -d 'username=admin&password=Esri3801&f=json' \
  "http://$HOSTNAME:6080/arcgis/admin/createNewSite"

# get rid of the default world cities service
sudo su -c "/opt/arcgis/server/tools/admin/manageservice -u admin -p Esri3801 -s http://$HOSTNAME:6080 -n SampleWorldCities -o delete" arcgis
