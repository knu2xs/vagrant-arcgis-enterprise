#!/bin/bash -x

# create the group arcgis
sudo groupadd arcgis

# create the arcgis user with the home directory as /opt/arcgis
sudo useradd -m -s /bin/bash -g arcgis -d /opt/arcgis arcgis

# add arcgis user to sudo and users group
sudo usermod -a -G sudo arcgis
sudo usermod -a -G users arcgis
