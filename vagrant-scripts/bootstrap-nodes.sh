#!/usr/bin/env bash

# set locales to stop annoying shell messages:
# https://stackoverflow.com/questions/35621614/i-got-warning-setlocale-lc-ctype-when-i-ssh-connect-to-vagrant-centos-6
# echo ... | sudo tee ... to write to /etc/environment because redirects are not performed as root
echo -e "LANG=en_US.utf-8\nLC_ALL=en_US.utf-8" | sudo tee /etc/environment

# update the yum package repository cache
sudo yum makecache
# system updates
sudo yum update -y
sudo yum install java-11-openjdk-devel.x86_64 -y
sudo yum install vim -y

# temporary script to setup java environment variables
cat > /tmp/java11.sh <<EOF
export JAVA_HOME=\$(dirname \$(dirname \$(readlink \$(readlink \$(which javac)))))
export PATH=\$PATH:\$JAVA_HOME/bin
export CLASSPATH=.:\$JAVA_HOME/jre/lib:\$JAVA_HOME/lib:\$JAVA_HOME/lib/tools.jar
EOF

source /tmp/java11.sh

export EDITOR=VIM

# ansible is needed only on the provisioner node
if [ "$(hostname)" = "provisioner" ]; then
  sudo yum install epel-release -y
  sudo yum install ansible -y
else
  cat /vagrant/roles/ssh_config/files/id_rsa.pub >> ~/.ssh/authorized_keys # provisioners public key is needed on all other nodes
fi
