# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

###############################################################################
# Base box                                                                    #
###############################################################################
  config.vm.box = "puppetlabs/centos-6.5-64-puppet"
 
###############################################################################
# Global provisioning settings                                                #
###############################################################################
  config.vm.synced_folder 'hiera/', '/var/lib/hiera'
  config.vm.provision :puppet do |puppet|
    default_env = 'development'
    ext_env = ENV['VAGRANT_PUPPET_ENV']
    env = ext_env ? ext_env : default_env
    puppet.options = "--environment #{env}"
    puppet.manifests_path = "puppet/environments/#{env}/manifests"
    puppet.manifest_file  = ""
    puppet.module_path = "puppet/modules"
    puppet.hiera_config_path = "puppet/hiera.yaml"
  end

###############################################################################
# Global VirtualBox settings                                                  #
###############################################################################
  config.vm.provider "virtualbox" do |v|
    v.customize [
      "modifyvm", :id,
      "--memory", "1024",
      "--cpus", "2",
      "--groups", "/Vagrant"
    ]
  end
 
###############################################################################
# VM definitions                                                              #
###############################################################################
  # Web server
  config.vm.define :web do |web|
    web.vm.hostname = "web.vagrant.local"
    web.vm.network :private_network, ip: "172.20.120.2"
    web.vm.provider("virtualbox") { |v| v.name = "web" }
  end
end
