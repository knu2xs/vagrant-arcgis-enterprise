#!/bin/bash -x

# save a few things in variables
USERNAME="admin"
PASSWORD="Esri3801"
FQDN=$(hostname --fqdn)

# post to the sharing REST API to get the token in a JSON response
RESPONSE=$(curl -k -X POST "https://$FQDN/portal/sharing/generateToken" \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -d "username=$USERNAME&password=$PASSWORD&client=requestip&expiration=60&f=json")

# use a little Python to extract the token out of the JSON response
TOKEN=$(echo $RESPONSE | python3 -c "import sys, json; print(json.load(sys.stdin)['token'])")

# now use the token to federate the server and portal
curl -k -X POST "https://$FQDN/portal/portaladmin/federation/servers/federate" \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -d "token=$TOKEN&url=https://$FQDN/server&adminUrl=https://$FQDN:6443/arcgis&username=$USERNAME&password=$PASSWORD&f=json"
  