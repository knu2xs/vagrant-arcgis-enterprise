#!/bin/bash -x

# get the fully qualified domain name
FQDN="$(hostname --fqdn)"

# copy the Web Adaptor WAR to be used in Tomcat for server at the ./server and ./portal urls
sudo cp /opt/arcgis/webadaptor10.5/java/arcgis.war /opt/tomcat/webapps/server.war

# give tomcat a chance to recognize the new application
sleep 30

# configure the Web Adaptor with the local installation of ArcGIS Server
sudo /opt/arcgis/webadaptor10.5/java/tools/configurewebadaptor.sh \
  -m server \
  -w https://$FQDN/server/webadaptor \
  -g https://$FQDN:6443 \
  -u admin \
  -p Esri3801 \
  -a true
