#!/bin/bash -x

# get the fully qualified domain name
FQDN="$(hostname --fqdn)"

# copy the Web Adaptor WAR to be used in Tomcat for server at the ./server and ./portal urls
sudo su -c "sudo cp /opt/arcgis/webadaptor*/java/arcgis.war /opt/tomcat/webapps/server.war" arcgis

# give tomcat a chance to recognize the new application...30 seconds
sleep 30

# configure the Web Adaptor with the local installation of ArcGIS Server
sudo /opt/arcgis/webadaptor*/java/tools/configurewebadaptor.sh \
  -m server \
  -w http://$FQDN/server/webadaptor \
  -g http://$FQDN:6080 \
  -u admin \
  -p Esri3801 \
  -a true
