# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  # Set the base box to be Ubuntu 16.04 LTS
  #config.vm.box = "bento/ubuntu-16.04"
  config.vm.box = "cbednarski/ubuntu-1604-large"

  # set the hostname
  config.vm.hostname="arcgis.vm"

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  config.vm.network "private_network", ip: "192.168.33.10"

  # Increase the hardware capacity
  # https://www.vagrantup.com/docs/virtualbox/configuration.html
  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--memory", 12288]
    vb.customize ["modifyvm", :id, "--cpus", 4]
  end

  # run scripts to setup arcgis server
  config.vm.provision "shell", path: "resources/scripts/ubuntu_update.sh"
  config.vm.provision :reload
  config.vm.provision "shell", path: "resources/scripts/setup_prerequisites.sh"
  config.vm.provision "shell", path: "resources/scripts/portal_install.sh"
  config.vm.provision "shell", path: "resources/scripts/server_install.sh"
  config.vm.provision "shell", path: "resources/scripts/tomcat_install.sh"
  config.vm.provision "shell", path: "resources/scripts/web_adaptor_install.sh"
  config.vm.provision "shell", path: "resources/scripts/server_config_web_adaptor.sh"
  config.vm.provision "shell", path: "resources/scripts/portal_config_web_adaptor.sh"
  # config.vm.provision "shell", path: "resources/scripts/federate.sh"
end
