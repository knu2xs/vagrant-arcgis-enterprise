#!/bin/bash -x

# copy the Web Adaptor WAR to be used in Tomcat for portal at the ./portal url
sudo su -c "sudo cp /opt/arcgis/webadaptor10.5/java/arcgis.war /var/lib/tomcat7/webapps/portal.war" arcgis

# give tomcat a chance to recognize the new application...30 seconds
sleep 30

# configure the Web Adaptor with the local installation of ArcGIS Server
sudo su -c "/opt/arcgis/webadaptor10.5/java/tools/configurewebadaptor.sh -m portal -w http://$HOSTNAME/portal/webadaptor -g http://$HOSTNAME:7443 -u admin -p Esri3801 -a true" arcgis
