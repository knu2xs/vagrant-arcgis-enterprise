#!/bin/bash -x

# get the fully qualified domain name
FQDN="$(hostname --fqdn)"

# copy the Web Adaptor WAR to be used in Tomcat for portal at the ./portal url
sudo su -c "sudo cp /opt/arcgis/webadaptor*/java/arcgis.war /opt/tomcat/webapps/portal.war" arcgis

# give tomcat a chance to recognize the new application...30 seconds
sleep 30

# configure the Web Adaptor with the local installation of ArcGIS Server
sudo /opt/arcgis/webadaptor*/java/tools/configurewebadaptor.sh \
  -m portal \
  -w https://$FQDN/portal/webadaptor \
  -g https://$FQDN:7443 \
  -u admin \
  -p Esri3801
