#!/bin/bash -x

#### STEP 1: INSTALL TOMCAT
# install tomcat
sudo apt install -y tomcat7 tomcat7-docs tomcat7-admin authbind

# stop the tomcat7 service
sudo /etc/init.d/tomcat7 stop

# add a user with the same credentials as ArcGIS to have access to the tomcat administration applications
# manager application: ./manager/html
# host manager application: ./host-manager/html
sudo sed -e 's/<\/tomcat-users>/<role rolename="manager-gui"\/>\n<role rolename="admin-gui"\/>\n<user username="admin" password="Esri380" roles="manager-gui, admin-gui"\/>\n<\/tomcat-users>/' -i /etc/tomcat7/tomcat-users.xml

#### STEP 2: RUN TOMCAT AS ARCGIS USER
# reference: http://askubuntu.com/questions/371809/run-tomcat7-as-tomcat7-or-any-other-user
# run tomcat under arcgis user to avoid permissions issues when registering sites wit the web adaptor
sudo sed -e 's/TOMCAT7_USER=tomcat7/TOMCAT7_USER=arcgis/' -i /etc/default/tomcat7

# change the owner of the relevant resources for the new user
sudo chown -R arcgis:adm /var/log/tomcat7
sudo chown -R arcgis:tomcat7 /var/lib/tomcat7/webapps
sudo chown arcgis:adm /var/cache/tomcat7
sudo chown -R arcgis:tomcat7 /var/cache/tomcat7/Catalina
sudo chown arcgis /etc/authbind/byport/80
sudo chown arcgis /etc/authbind/byport/443

# add vagrant and arcgis to useful groups for accessing resources
sudo usermod -a -G adm arcgis      # so arcgis user can view log files
sudo usermod -a -G adm vagrant     # so vagrant user can view log files
sudo usermod -a -G tomcat7 arcgis  # required for running tomcat7 as arcgis
sudo usermod -a -G tomcat7 vagrant

#### STEP 3: MAKE TOMCAT LISTEN ON PORTS 80 & 443
# reference: http://stackoverflow.com/questions/4756039/how-to-change-the-port-of-tomcat-from-8080-to-80
# edit Tomcat settings to run on port 80 and 443 instead of 8080 and 8443
sudo sed -e 's/port="8080"/port="80"/' -i /var/lib/tomcat7/conf/server.xml
sudo sed -e 's/port="8443"/port="443"/' -i /var/lib/tomcat7/conf/server.xml

# edit the tomcat7 config to use authbind
sudo sed -e 's/#AUTHBIND=no/AUTHBIND=yes/' -i /etc/default/tomcat7

# create the authbind files for the requsite ports
sudo touch /etc/authbind/byport/80
sudo touch /etc/authbind/byport/443
sudo chmod 540 /etc/authbind/byport/80
sudo chmod 540 /etc/authbind/byport/443
sudo chown arcgis:tomcat7 /etc/authbind/byport/80
sudo chown arcgis:tomcat7 /etc/authbind/byport/443

# start tomcat7
sudo /etc/init.d/tomcat7 start
