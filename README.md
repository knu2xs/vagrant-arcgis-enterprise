# Vagrant ArcGIS Enterprise

As a Solution Engineer, frequently I have the need to have a demonstration environment to show clients. Increasingly, wso much functionality is moving toward being web based, with much of this functionality requiring a multi-step install and configuration on some sort of server environment. This process is time consuming and laborious at best. Fortunately Vagrant provides a way to dramatically streamline this process.

This is a project to get ArcGIS Enterprise up and running using a Vagrant file on Ununtu Linux. Using this project requires VirtualBox and Vagrant to be installed and set up on your host machine. Futher, you need to procure your own installation files and license files. Once fulfilling these two requirements, you have everything you need to quickly, in Vagrant parlance, provision an ArcGIS Enterprise environment.

## Current Status: 09 Feb 2017

Right now all I have been able to sucessfully do is get ArcGIS Server installed, and the initial default site set up with a username / password combination of *admin / Esri$tud*.

## Prerequsites - Vagrant + VirtualBox

The functionality of this repo can only be realized by using Vagrant with VirtualBox. Get these and get them installed on your host machine, and you will be good to go.

## Setup

No, everything you need to get up and running out of the box is not included in this repository. Fortunately, the rest is not hard to find. You need to download the Esri software installation resources along with a license file to be ready to head to the races.

You are going to need the ArcGIS Server tar.gz file, along with a prvc license file. Both of these need to be placed in the resources directory, inside a folder you will have to create named proprietary. Once finished, the directory structure should look like this.
```
- resources
  |- proprietary
     |- ArcGIS_Server_Linux_105_154052.tar.gz
     |- server.prvc
  |- config-files.tar.gz
- install_arcgis_server.sh
- LICENSE
- README.md
- Vagrantfile
```

## Use

While I have the best of intentions to write a much more complete explanation of how all this works, for the 99% of you who just want to get up and running, this likely will suffice. Still writing...