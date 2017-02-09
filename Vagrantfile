# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  # Set the base box to be Ubuntu 16.04 LTS
  config.vm.box = "ubuntu/xenial64"

  # Forward port mapping for ports to be exposed direclty on machine, as if
  # on the localhost...both are for ArcGIS Server communication
  config.vm.network "forwarded_port", guest: 6080, host: 6080
  config.vm.network "forwarded_port", guest: 6443, host: 6443

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network "private_network", ip: "192.168.33.10"

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

  # Provision using a shell script to install ArcGIS Server
  config.vm.provision "shell", path: "install_arcgis_server.sh"
end
