#!/bin/bash

# ensure working with current repos and software
sudo apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get -y -o DPkg::options::="--force-confdef" -o DPkg::options::="--force-confold"  upgrade

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

# hack the limits check and the root installer files so the install does not hang up
sudo echo '#!/bin/bash' > /tmp/ArcGISServer/serverdiag/.diag/check_limits.sh
sudo echo 'exit $STATUS_PASSED' >> /vagrant/resources/config_files/check_limits.sh
sudo cp /tmp/ArcGISServer/serverdiag/.diag/check_limits.sh /tmp/ArcGISServer/serverdiag/.diag/check_root_installer.sh

# install ArcGIS Server as the arcgis user
sudo su -c "/tmp/ArcGISServer/Setup -m silent -l yes -a /vagrant/resources/proprietary/server.prvc -d /opt/arcgis" arcgis

# copy the startup file to the init.d directory so ArcGIS Server will know how to start with the instance boot
sudo cp /opt/arcgis/server/framework/etc/scripts/arcgisserver /etc/init.d/

# use sed to edit the arcgisserver init.d file so it knows where to find the installtion of server
sudo sed -e 's/\/arcgis\/server/\/opt\/arcgis\/server/' -i /etc/init.d/arcgisserver

# set ArcGIS Server to start with the instance boot
sudo /lib/systemd/systemd-sysv-install enable arcgisserver

# use the admin api to set up the server site using the default config-store and directories locations
curl -X POST \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -d 'username=admin&password=Esri380&f=json' \
  "http://localhost:6080/arcgis/admin/createNewSite"

###### Start Web Adaptor Section
# Install Tomcat
sudo apt-get install -y tomcat7 tomcat7-docs tomcat7-admin
sudo apt-get clean

# extract the Web Adaptor installation resources to the temp directory
tar -zxvf /vagrant/resources/proprietary/Web_Adaptor*.tar.gz -C /tmp

# run the install
sudo su -c "/tmp/WebAdaptor/Setup -m silent -l yes -d /opt/arcgis" arcgis

# copy the Web Adaptor WAR to be used in Tomcat for server at the ./server url
sudo cp /opt/arcgis/webadaptor10.5/java/arcgis.war /var/lib/tomcat7/webapps/server.war

# configure the Web Adaptor with the local installation of ArcGIS Server
sudo su -c "/opt/arcgis/webadaptor10.5/java/tools/configurewebadaptor.sh -m server -w http://vagrant:8080/server/webadaptor -g http://vagrant:6080 -u admin -p Esri380 -a true" arcgis

