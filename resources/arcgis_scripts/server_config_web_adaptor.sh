#!/bin/bash -x

# copy the Web Adaptor WAR to be used in Tomcat for server at the ./server and ./portal urls
sudo su -c "sudo cp /opt/arcgis/webadaptor10.5/java/arcgis.war /var/lib/tomcat7/webapps/server.war" arcgis

# give tomcat a chance to recognize the new application...30 seconds
sleep 30

# configure the Web Adaptor with the local installation of ArcGIS Server
sudo su -c "/opt/arcgis/webadaptor10.5/java/tools/configurewebadaptor.sh -m server -w http://$HOSTNAME/server/webadaptor -g http://$HOSTNAME:6080 -u admin -p Esri3801 -a true" arcgis
