#!/bin/bash -x

# use the admin api to set up the server site using the default config-store and directories locations
curl -X POST -k \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -d 'username=admin&password=Esri3801&fullname=Administrator&email=nobody@esri.com&description=The initial admin account&securityQuestionIdx=1&securityQuestionAns=Mumbai&contentStore={"type":"fileStore","provider":"FileSystem","connectionString":"/opt/arcgis/portal/usr/arcgisportal/content"}&f=json' \
  "https://$HOSTNAME:7443/arcgis/portaladmin/createNewSite"
