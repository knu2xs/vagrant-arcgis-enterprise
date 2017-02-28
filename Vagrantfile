# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  # Set the base box to be Ubuntu 16.04 LTS
  config.vm.box = "bento/ubuntu-16.04"
  # config.vm.box = "ubuntu/xenial64"

  # Forward port mapping for ports to be exposed direclty on machine, as if
  # on the localhost...both are for ArcGIS Server communication
  # config.vm.network "forwarded_port", guest: 6080, host: 6080
  # config.vm.network "forwarded_port", guest: 6443, host: 6443

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  config.vm.network "private_network", ip: "192.168.33.10"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  # Increase the hardware capacity
  # https://www.vagrantup.com/docs/virtualbox/configuration.html
  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--memory", 8192]
    vb.customize ["modifyvm", :id, "--cpus", 4]
  end

  # run scripts to setup arcgis server
  config.vm.provision "shell", path: "resources/arcgis_scripts/ubuntu_update.sh"
  config.vm.provision :reload
  config.vm.provision "shell", path: "resources/arcgis_scripts/add_user_arcgis_and_create_install_location.sh"
  config.vm.provision "shell", path: "resources/arcgis_scripts/tomcat_install.sh"
  config.vm.provision "shell", path: "resources/arcgis_scripts/web_adaptor_install.sh"
  config.vm.provision "shell", path: "resources/arcgis_scripts/server_install.sh"
  config.vm.provision "shell", path: "resources/arcgis_scripts/server_config_web_adaptor.sh"
  config.vm.provision "shell", path: "resources/arcgis_scripts/portal_install.sh"
  # config.vm.provision "shell", path: "resources/arcgis_scripts/portal_config_web_adaptor.sh"
end
