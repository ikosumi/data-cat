# data-cat
a datadog spin-off using the [ELK stack](https://www.elastic.co/what-is/elk-stack)

# Setup
1. Install [Vagrant](https://www.vagrantup.com/downloads) and [VirtualBox](https://www.virtualbox.org/wiki/Downloads) for your OS.
1. If you are on macOS, you will probably have some permission issues with VirtualBox. Check [this article](https://matthewpalmer.net/blog/2017/12/10/install-virtualbox-mac-high-sierra/index.html) if needed.
1. Run `vagrant status` to check current VMs. Their initial state should be `not created`.
1. Run `vagrant up provisioner` to spin-up the `provisioner` VM, which has ansible. This will take a while to finish.
1. Make sure that `provisioner` is running, and you are on the root directory of the project and run the following command:
    ```shell script
    vagrant ssh provisioner -c "ssh-keygen -y -f /vagrant/.vagrant/machines/provisioner/virtualbox/private_key" > roles/ssh_config/files/id_rsa.pub
    ```
    The script will generate the public key from the provisioners private key, which is used by ansible.
1. Fire-up the rest of the nodes by running `vagrant up` once again. 
At this point, you can go grab a ☕️ and come back later. 
1. Verify that all nodes are running via `vagrant status`. All VMs should have their state `running`.
1. You should now be able to ssh into `provisioner` (`vagrant ssh provisioner`).
1. `cd /vagrant` and run `ansible-playbook -i inventory/dev setup_privisioner.yml`
1. `ansible-playbook -i inventory/dev provision_dev.yml`

# TODOs
- [ ] Provision infrastructure (VMs using Vagrant)
    - [ ] bootstrap VMs via Vagrant & shell scripts to install necessary tools and updates
    - [ ] 5 VMs (1 which has ansible installed, 4 will be used as nodes with 1 being a master node):
        - [ ] provisioner (has ansible installed and is responsible for managing all other VMs)
        - [ ] master (elastic master node)
        - [ ] data (elastic data node)
        - [ ] shipper (elastic shippers - logstash/beats)
        - [ ] kibana (the UI)
- [x] Document how to set everything up.
- [ ] Provision software using a configuration management tool (ansible, elasticsearch, kibana)
    - [ ] create ansible playbooks and roles
- [ ] Create some basic micro-services that will create sample logs (nodejs)

# Some cool IntelliJ tools
- [Ruby IntelliJ plugin](https://www.jetbrains.com/help/idea/ruby-plugin.html#further-steps)
- [Vagrant IntelliJ plugin](https://plugins.jetbrains.com/plugin/7379-vagrant)
- [YAML/Ansible support for IntelliJ](https://plugins.jetbrains.com/plugin/7792-yaml-ansible-support)
- [.ini file support](https://plugins.jetbrains.com/plugin/6981-ini)
- [OrchidE](https://www.orchide.dev/) lang. support for ansible for IntelliJ (commercial, 30 day trial)
