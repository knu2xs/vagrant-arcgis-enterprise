# Vagrant ArcGIS Enterprise

As a Solution Engineer, frequently I have the need to have a demonstration environment to show clients. Increasingly, much of the functionality I am demonstrating is moving toward being web based. This functionality requires a multi-step install, and configuration on some sort of server environment. This process is time consuming and laborious at best. Fortunately Vagrant provides a way to dramatically streamline this process.

This is a project to get ArcGIS Enterprise up and running using a Vagrant file on Ununtu Linux. Using this project requires VirtualBox and Vagrant to be installed and set up on your host machine. Futher, you need to procure your own installation files and license files. Once fulfilling these two requirements, you have everything you need to quickly, in Vagrant parlance, provision a basic ArcGIS Enterprise environment.

## For the Impatient (most of you)

* Read the Setup Section. Get the install and license files, and put them in the right place with the right names.
* `vagrant up`
* It's not done yet, so check the current status to see how far I've made it.

## Current Status: 03 Mar 2017

All the username / password credentials are *admin / Esri3801*. Server and Portal are registering with the Web Adaptor running on ports 80 and 443 with a self-signed certificate generated on the fly as part of the build. A relational Data Store is set up. and registered with Server to host feature services. Server and Portal can be manually federated, but the script does not seem to be working for some reason. Hence, it is getting very close, but not quite there yet - close, _so very close!_

# Prerequsites - VirtualBox + Vagrant + Vagrant Reload

The functionality of this repo can only be realized by using [VirtualBox](https://www.virtualbox.org/), [Vagrant](https://www.vagrantup.com/), and the [Vagrant Reload](https://github.com/aidanns/vagrant-reload) plugin. Make your life easier by using a package manager. If you have not used a package manager before, now is the time to figure it out. Package managers make the process of installing and keeping software current much easier. If on a Mac, use Homebrew. If Winodws, use Chocolatey.

## Mac - Homebrew

On the Mac side of the house, getting up and running is relatively straightforward with [Homebrew](https://brew.sh/). First, you need to get Homebrew. Next, install Vagrant and Virtualbox. Optionally, and _highly recommended_, also install Vagrant Manager, a GUI Vagrant manager. Finally, install the Vagrant Reload plugin. All of this is done in Terminal using the following commands.
```
# install Homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# install Vagrant and VirtualBox
brew install 

# install Vagrant, VirtualBox and Vagrant Manager
brew cask install virtualbox
brew cask install vagrant
brew cask install vagrant-manager

# install Vagrant Reload plugin
vagrant plugin install vagrant-reload
```

## Windows - Chocolatey

If you are back on the Windows side of the house, fortunately you are not left out. You have [Chocolatey](https://chocolatey.org/) While getting chocolate is nowhere near as cool as a nice homebrew, thankfully a package manager is avaialble for Windows as well (I'm a dad, so I am allowed to make bad jokes). The steps are not dramatically different; install Chocolately, then VirtualBox, Vagrant, and Vagrant Manager, and finally install Vagrant Reload. Fire up either Command Prompt, or my preference, PowerShell, and use the following commands to get started. Incidentally, you may have to follow the [directions referenced on the Chocolatey install page](https://chocolatey.org/install) to ensure the Get-ExecutionPolicy is not restricted to get Chocolatey installed.
```
# install Chocolatey
iwr https://chocolatey.org/install.ps1 -UseBasicParsing | iex

# install Vagrant, VirtualBox and Vagrant Manager
choco install virtualbox
choco install vagrant
choco install vagrant-manager

# install Vagrant Reload plugin
vagrant plugin install vagrant-reload
```

# Setup - Proprietary Resources

No, everything you need to get up and running out of the box is not included in this repository. Fortunately, the rest is not hard to find if you have access to the right resources. You need to download the Esri software installation resources along with a license file to be ready to head to the races.

You are going to need the tar.gz install resources for Portal, Server, Web Adaptor, and the Data Store, along with prvc or ecp license files for Portal and Server. All of these resources need to be renamed and placed in the resources directory as detailed in the tree below. Once finished, the directory structure should look like this.
```
- resources
  |- proprietary
    |- ArcGIS_DataStore_Linux.tar.gz
    |- ArcGIS_Portal_Linux.tar.gz
    |- ArcGIS_Server_Linux.tar.gz
    |- ArcGIS_Web_Adaptor_Java_Linux.tar.gz
    |- portal.prvc
    |- server.prvc
    |- favicon.ico (optional)
  |- scripts
    |- data_store_install.sh
    |- federate.sh
    |- portal_config_web_adaptor.sh
    |- portal_install.sh
    |- server_config_web_adaptor.sh
    |- server_install.sh
    |- setup_prerequisites.sh
    |- tomcat_install.sh
    |- ubuntu_update.sh
    |- web_adaptor_install.sh
-.gitignore
- LICENSE
- README.md
- Vagrantfile
```

# Use

While I have the best of intentions to write a much more complete explanation of how all this works, for the 98.3% of you who just want to get up and running, this likely will suffice. Still writing...
