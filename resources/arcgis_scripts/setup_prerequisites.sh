#!/bin/bash -x

### CREATE ARCGIS USER AND GROUP ###
# create the group arcgis
sudo groupadd arcgis

# create the arcgis user with the home directory as /opt/arcgis
sudo useradd -m -s /bin/bash -g arcgis -d /opt/arcgis arcgis

# add arcgis user to sudo and users group
sudo usermod -a -G sudo arcgis
sudo usermod -a -G users arcgis

### SET LIMITS FOR ARCGIS SOFTWARE ###
# edit the limits.conf file per server prerequsite requirements
sudo sed -e 's/# End of file/* soft nofile 65535\n* hard nofile 65535\n* soft nproc 25059\n* hard nproc 25059\n\n# End of file/' -i /etc/security/limits.conf
