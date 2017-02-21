#!/bin/bash -x

# use the admin api to set up the server site using the default config-store and directories locations
curl -X POST \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -d 'username=admin&password=Esri380&f=json' \
  "http://$HOSTNAME:6080/arcgis/admin/createNewSite"

# get rid of the default world cities service
sudo su -c "/opt/arcgis/server/tools/admin/manageservice -u admin -p Esri380 -s http://$HOSTNAME:6080 -n SampleWorldCities -o delete" arcgis
