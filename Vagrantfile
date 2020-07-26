# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  config.ssh.forward_agent = true

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://vagrantcloud.com/search.
  config.vm.box = "ubuntu/bionic64"

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  config.vm.network "private_network", ip: "192.168.33.30"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"
  config.vm.synced_folder ".", "/vagrant", disabled: false

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  # config.vm.provider "virtualbox" do |vb|
  #   # Display the VirtualBox GUI when booting the machine
  #   vb.gui = true
  #
  #   # Customize the amount of memory on the VM:
  #   vb.memory = "1024"
  # end
  #
  # View the documentation for the provider you are using for more
  # information on available options.
  config.vm.provider "virtualbox" do |vb|
    vb.customize [
      "modifyvm", :id,
      "--cpus", "2",
      "--memory", "2048",
      "--paravirtprovider", "kvm",
      "--nicpromisc2", "allow-all"
    ]
  end
  #
  # Before running vagrant, install vagrant-disksize plugin
  # $ vagrant plugin install vagrant-disksize
  # See https://github.com/sprotheroe/vagrant-disksize for details.
  config.disksize.size = '20GB'

  config.vm.define :bionic do |bionic|
    bionic.vm.box = "ubuntu/bionic64"
    bionic.vm.hostname = "bionic"
  end

  # Enable provisioning with a shell script. Additional provisioners such as
  # Ansible, Chef, Docker, Puppet and Salt are also available. Please see the
  # documentation for more information about their specific syntax and use.
  config.vm.provision "shell", inline: <<-SHELL
    apt-get update
    apt-get install -y git python3
    echo "sudo useradd -s /bin/bash -d /opt/stack -m stack"
    sudo useradd -s /bin/bash -d /opt/stack -m stack
    echo "stack ALL=(ALL) NOPASSWD: ALL" | sudo tee -a /etc/sudoers
    echo "sudo chmod 755 /opt/stack"
    sudo chmod 755 /opt/stack
    sudo -u stack cp /vagrant/*.sh /opt/stack
  SHELL
end
