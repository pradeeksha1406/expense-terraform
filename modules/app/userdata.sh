#!/bin/bash

sudo yum install python3.11-pip ansible -y | tee -a /opt/userdata.log
Sudo pip3.11 install botocore boto3 | tee -a /opt/userdata.log
ansible-pull -i localhost, -U https://github.com/pradeeksha1406/infra-ansible.git main.yml -e roles_name=${roles_name} | tee -a /opt/userdata.log