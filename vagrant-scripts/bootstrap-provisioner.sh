#!/usr/bin/env bash

# update the yum package repository cache
sudo yum makecache
# system updates
sudo yum update -y
sudo yum install epel-release -y
sudo yum install ansible -y
