#!/bin/bash -x

# use the admin api to set up the server site using the default config-store and directories locations
curl -X POST \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -d 'username=admin&password=Esri380&f=json' \
  "https://$HOSTNAME:7443/arcgis/portaladmin/createNewSite"