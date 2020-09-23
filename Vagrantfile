# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

# For a complete reference, please see the online documentation at
# https://www.vagrantup.com/docs
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  vms = {
      'master' => {
          :ip => '10.0.11.11',
          :memory => 512,
          :ports => [],
          :bootstrap => true,
          :synced_folders => false
      },
      'data' => {
          :ip => '10.0.11.12',
          :memory => 512,
          :ports => [],
          :bootstrap => true,
          :synced_folders => false
      },
      'shipper' => {
          :ip => '10.0.11.13',
          :memory => 512,
          :ports => [],
          :bootstrap => true,
          :synced_folders => false
      },
      'kibana' => {
          :ip => '10.0.11.14',
          :memory => 512,
          :ports => [{
            :host => 5601,
            :guest => 5601
          }],
          :bootstrap => true,
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
        node.vm.provision :shell, path: "vagrant-scripts/bootstrap-nodes.sh", privileged: false
      end

      if vms[name][:synced_folders]
        node.vm.synced_folder ".", "/vagrant", type: "virtualbox", nfs: true
      end
    end
  end

end
