#!/bin/bash -x


### CREATE ARCGIS USER AND GROUP ###
# create the group arcgis
sudo groupadd arcgis

# create the arcgis user with the home directory as /opt/arcgis
sudo useradd -m -s /bin/bash -g arcgis -d /opt/arcgis arcgis

# add arcgis user to sudo and users group
sudo usermod -a -G sudo arcgis
sudo usermod -a -G users arcgis


### USEFUL SOFTWARE ###
# ensure a few packages, not even arcgis specific, are isntalled
sudo apt-get install -y curl


### SET LIMITS FOR ARCGIS SOFTWARE ###
# edit the limits.conf file per server prerequsite requirements
sudo sed -e 's/# End of file/* soft nofile 65535\n* hard nofile 65535\n* soft nproc 25059\n* hard nproc 25059\n\n# End of file/' -i /etc/security/limits.conf


### SET HOSTNAME ###
# clean up the original hostname from the packer build in the hosts file
sudo sed -e "s/127\.0\.1\.1.*//g" -i /etc/hosts

# ensure all the ip addresses and corresponding hostnames being used are in hosts file
# reference: http://unix.stackexchange.com/questions/119269/how-to-get-ip-address-using-shell-script
# reference: http://stackoverflow.com/questions/23381416/how-to-concatenate-two-or-more-string-stored-in-a-variable-inside-awk-script
# DN=$(hostname)
# FQDN=$(hostname --fqdn)
# ifconfig | awk -v fqdn="$FQDN" -v dn="$DN" -v lh="localhost" -v OFS="  " '/inet addr/{print substr($2,6),fqdn,dn,lh}' >> sudo /etc/hosts