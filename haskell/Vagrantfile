# -*- mode: ruby -*-
# vi: set ft=ruby :

$PROVISION = <<SCRIPT
VHOME=/home/vagrant

sudo apt-get update -y
sudo apt-get install -y vim git
cd $VHOME && git clone https://github.com/andrewberls/dotfiles.git
cd $VHOME/dotfiles && HOME=$VHOME sudo bash setup.sh
SCRIPT

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "ubuntu/trusty64"

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # config.vm.network "forwarded_port", guest: 80, host: 8080

  # If true, then any SSH connections made will enable agent forwarding.
  # Default value: false
  # config.ssh.forward_agent = true

  config.vm.synced_folder ".", "/home/vagrant/code"

  config.vm.provider "virtualbox" do |vb|
    vb.customize ["modifyvm", :id, "--memory", "2048"]
  end

  config.vm.provision "shell", inline: $PROVISION
end
