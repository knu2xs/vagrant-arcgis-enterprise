#!/bin/bash -x

### CONFIGURE SYSTEM FOR INSTALL ###
# install prerequsite
sudo apt-get install -y default-jdk-headless

# also make the directory for the tomcat installation and make arcgis the owner
sudo mkdir {/opt/tomcat,/opt/arcgis}
sudo chown arcgis:arcgis /opt/tomcat /opt/arcgis
sudo chmod 740 /opt/tomcat /opt/arcgis

### INSTALL SPECIFIC SUPPORTED TOMCAT VERSION ###
# download Tomcat 8.0.32 to the temp directory and install to /opt
curl -O -o /tmp https://archive.apache.org/dist/tomcat/tomcat-8/v8.0.32/bin/apache-tomcat-8.0.32.tar.gz
mv apache* /tmp
sudo tar xzvf /tmp/apache-tomcat-*tar.gz -C /opt/tomcat --strip-components=1

# change the ownerhip of all tomcat resources to arcgis
sudo chown -R arcgis:arcgis /opt/tomcat

# change the permissions on the contents and the conf directory
sudo chmod -R 750 /opt/tomcat/conf
sudo chmod 740 /opt/tomcat/conf

# remove the examples
sudo rm -rf /opt/tomcat/webapps/examples

# reference: https://learn.adafruit.com/running-programs-automatically-on-your-tiny-computer/systemd-writing-and-enabling-a-service
# copy the systemctl file to the instance
sudo cp /vagrant/resources/files/tomcat.service /etc/systemd/system/tomcat.service

# reference: http://stackoverflow.com/questions/20579203/export-result-from-find-command-to-variable-value-in-linux-shell-script
# get the path to the JAVA home
JAVA_HOME="$(find /usr/lib/jvm -iname 'java-1*openjdk*' -print -quit)"

# find the JAVA_HOME_REPLACEME and put the java home value in there
sudo sed -e "s|JAVA_HOME_REPLACEME|$JAVA_HOME|g" -i /etc/systemd/system/tomcat.service

# add a user with the same credentials as ArcGIS to have access to the tomcat administration applications
# manager application: ./manager/html
# host manager application: ./host-manager/html
sudo sed -e 's/<\/tomcat-users>/<role rolename="manager-gui"\/>\n<role rolename="admin-gui"\/>\n<user username="admin" password="Esri3801" roles="manager-gui, admin-gui"\/>\n<\/tomcat-users>/' -i /opt/tomcat/conf/tomcat-users.xml

# register tomcat with systemctl so it will start with instance initialization
sudo systemctl daemon-reload
sudo systemctl enable tomcat.service


### SETUP SECURITY CERTIFICATE ###
# variable where we are going to store the keystore
KEYSTORE="/opt/tomcat/conf/keystore.ks"

# get the fully qualified domain name
CN="$(hostname --fqdn)"

# generate the security certificate
sudo keytool \
  -genkey \
  -keyalg RSA \
  -alias tomcat \
  -keystore $KEYSTORE \
  -storepass Esri3801 \
  -keypass Esri3801 \
  -validity 365 \
  -keysize 4096 \
  -dname "cn=$CN, ou=Demonstration, o=Esri, l=Olympia, s=Washington, c=US"

# change the ownerhsip and permissions on the security certificate
sudo chown arcgis:arcgis $KEYSTORE
sudo chmod 750 $KEYSTORE

# copy a modified server.xml file to enable ssl and reference the newly created keystore file
sudo cp -rf /vagrant/resources/files/server.xml /opt/tomcat/conf/

### REDIRECT PORTS TO 80 AND 443 USING AUTHBIND ###
# reference: http://azurvii.blogspot.com/2016/06/tomcat-8-authbind-on-port-80443-systemd.html
# reference: https://debian-administration.org/article/386/Running_network_services_as_a_non-root_user
# install and configure authbind
sudo apt-get install -y authbind
sudo touch /etc/authbind/byport/{443,80}
sudo chmod 550 /etc/authbind/byport/{443,80}
sudo chown arcgis:arcgis /etc/authbind/byport/{443,80}

# # configure tomcat to use ports 80 and 443 instead of the default ports 8080 and 8443
sudo sed -i 's/8080/80/g' /opt/tomcat/conf/server.xml
sudo sed -i 's/8443/443/g' /opt/tomcat/conf/server.xml

# reference: http://www.2ality.com/2010/07/running-tomcat-on-port-80-in-user.html
# modify the tomcat startup to use authbind
sudo sed -i 's/exec "$PRGDIR"\/"$EXECUTABLE" start "$@"/exec authbind --deep "$PRGDIR"\/"$EXECUTABLE" start "$@"/g' /opt/tomcat/bin/startup.sh

# restart tomcat to read changes
sudo systemctl daemon-reload
sudo systemctl restart tomcat.service
