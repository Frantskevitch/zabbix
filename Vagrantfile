# -*- mode: ruby -*-
# # vi: set ft=ruby :

 # All Vagrant configuration is done below. The "2" in Vagrant.configure
 # configures the configuration version (we support older styles for
 # backwards compatibility). Please don't change it unless you know what
 # you're doing.
Vagrant.configure("2") do |config|
  config.vm.synced_folder ".", "/vagrant", type: "virtualbox"
  config.vm.provision "shell", path: "./puppet.sh"

  config.vm.provision "puppet" do |puppet|
    puppet.module_path = "modules"
  end

  config.vm.define "ldap" do |zabbix|
  zabbix.vm.box = "centos/6"
  zabbix.vm.hostname = "ldap_auto"
  zabbix.vm.network "private_network", ip: "192.168.56.99"
  zabbix.vm.provider "virtualbox" do |vb|
    vb.name = "ldap_auto"
    vb.cpus = 1
    vb.memory = 2048
  end
end
end

