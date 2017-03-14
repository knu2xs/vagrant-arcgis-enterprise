#!/bin/bash -x

# extract the Web Adaptor installation resources to the temp directory
tar -zxf /vagrant/resources/proprietary/ArcGIS_Web_Adaptor*.tar.gz -C /tmp

# run the install
sudo su -c "/tmp/WebAdaptor/Setup -m silent -l yes -d /opt/arcgis" arcgis
