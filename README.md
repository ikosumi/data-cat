# data-cat
a datadog spinoff using something like elasticsearch and kibana

# setup
- Provision infrastructure (VMs using Vagrant)
    - bootstrap VMs via Vagrant & shell scripts to install necessary tools and updates
    - 5 VMs (1 which has ansible installed, 4 will be used as nodes with 1 being a master node):
        - provisioner (responsible for managing all other VMs)
        - master (elastic master node)
        - data (elastic data node)
        - shipper (elastic shippers - logstash/beats)
        - kibana (the UI)
- Provision software using a configuration management tool (ansible, elasticsearch, kibana)
    - create ansible playbooks and roles
- Create some basic micro-services that will create sample logs (nodejs)

# IDE tools
- Ruby IntelliJ plugin
- Vagrant IntelliJ plugin
- YAML/Ansible support for IntelliJ
