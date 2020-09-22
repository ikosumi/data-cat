# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  vms = {
      'master' => {
          :ip => '10.0.11.11',
          :memory => 512,
          :ports => [],
          :bootstrap => false,
          :synced_folders => false
      },
      'data' => {
          :ip => '10.0.11.12',
          :memory => 512,
          :ports => [],
          :bootstrap => false,
          :synced_folders => false
      },
      'shipper' => {
          :ip => '10.0.11.13',
          :memory => 512,
          :ports => [],
          :bootstrap => false,
          :synced_folders => false
      },
      'kibana' => {
          :ip => '10.0.11.14',
          :memory => 512,
          :ports => [{
            :host => 5601,
            :guest => 5601
          }],
          :bootstrap => false,
          :synced_folders => false
      },
      'provisioner' => {
          :ip => '10.0.11.15',
          :memory => 512,
          :ports => [],
          :bootstrap => true,
          :synced_folders => true
      }
  }

  vms.each_key do |name|
    config.vm.define name, :autostart => true do |node|

      node.vm.box = 'centos/7'
      node.vm.box_version = "2004.01"
      node.vm.hostname = name

      vms[name][:ports].each do |port_mapping|
        node.vm.network :forwarded_port, guest: port_mapping[:guest], host: port_mapping[:host]
      end

      node.vm.network :private_network, ip: vms[name][:ip]

      node.vm.provider :virtualbox do |vb|
        vb.name = name
        vb.gui = false
        vb.memory = vms[name][:memory]
      end

      if vms[name][:bootstrap]
        # Enable provisioning with a shell script.
        node.vm.provision :shell, path: "vagrant-scripts/bootstrap-#{name}.sh"
      end

      if vms[name][:synced_folders]
        node.vm.synced_folder ".", "/vagrant", type: "virtualbox", nfs: true
      end
    end
  end
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://vagrantcloud.com/search.
  # config.vm.box = "centos/8"

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # NOTE: This will enable public access to the opened port
  # config.vm.network "forwarded_port", guest: 80, host: 8080

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine and only allow access
  # via 127.0.0.1 to disable public access
  # config.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network "private_network", ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

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

  # Enable provisioning with a shell script. Additional provisioners such as
  # Ansible, Chef, Docker, Puppet and Salt are also available. Please see the
  # documentation for more information about their specific syntax and use.
  # config.vm.provision "shell", inline: <<-SHELL
  #   apt-get update
  #   apt-get install -y apache2
  # SHELL
end
