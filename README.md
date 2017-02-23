# Vagrant ArcGIS Enterprise

As a Solution Engineer, frequently I have the need to have a demonstration environment to show clients. Increasingly, much of the functionality I am demonstrating is moving toward being web based. This functionality requires a multi-step install, and configuration on some sort of server environment. This process is time consuming and laborious at best. Fortunately Vagrant provides a way to dramatically streamline this process.

This is a project to get ArcGIS Enterprise up and running using a Vagrant file on Ununtu Linux. Using this project requires VirtualBox and Vagrant to be installed and set up on your host machine. Futher, you need to procure your own installation files and license files. Once fulfilling these two requirements, you have everything you need to quickly, in Vagrant parlance, provision a basic ArcGIS Enterprise environment.

## Current Status: 20 Feb 2017

The Vagrantfile calls a number of bash scripts to install ArcGIS Server, set up the ArcGIS Server site, install the Web Adapter, configre ArcGIS Server with the Web Adaptor, and install Portal. All the username / password credentials are *admin / Esri3801*. Next up, I still need to create a self-signed certificate, configure Portal with the Web Adaptor, and federate Portal and Server. This is proving to be increasingly vexing...

## Prerequsites - Vagrant + VirtualBox

The functionality of this repo can only be realized by using Vagrant with VirtualBox. Get these and get them installed on your host machine, and you will be good to go.

## Setup

No, everything you need to get up and running out of the box is not included in this repository. Fortunately, the rest is not hard to find if you have access to the right resources. You need to download the Esri software installation resources along with a license file to be ready to head to the races.

You are going to need the tar.gz install resources, along with a prvc license files for Portal and Server. Both of these need to be renamed and placed in the resources directory, inside a folder you will have to create named proprietary. Once finished, the directory structure should look like this.
```
- resources
  |- arcgis_scripts
    |- portal_config_web_adaptor.sh
    |- portal_install.sh
    |- portal_post_install.sh
    |- portal_setup_prerequisites.sh
    |- server_config_web_adaptor.sh
    |- server_install.sh
    |- server_post_install.sh
    |- server_setup_prerequisites.sh
    |- ubuntu_update.sh
    |- web_adaptor_install.sh
    |- web_adaptor_setup_prerequisites.sh
  |- proprietary
    |- ArcGIS_Portal_Linux.tar.gz
    |- ArcGIS_Server_Linux.tar.gz
    |- ArcGIS_Web_Adaptor_Java_Linux.tar.gz
    |- portal.prvc
    |- server.prvc
- LICENSE
- README.md
- Vagrantfile
```

## Use

While I have the best of intentions to write a much more complete explanation of how all this works, for the 98.3% of you who just want to get up and running, this likely will suffice. Still writing...