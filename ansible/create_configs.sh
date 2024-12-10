#!/bin/bash

python3 -m venv .venv
source .venv/bin/activate

pip3 install -r requirements.txt

echo Creating hosts file.

ansible-galaxy collection install community.general
ansible-galaxy install -r requirements.yml

. setup-google/terraform_outputs.sh

# Creating the hosts file
echo "[vps]" > hosts.ini
echo "${HEAD_IP}" >> hosts.ini
echo "[vps:vars]" >> hosts.ini
echo "ansible_user=ansible" >> hosts.ini
echo "ansible_ssh_private_key_file=./keys/ansible_key" >> hosts.ini

# Creating a password
echo "whanos:$(openssl rand -base64 32 | tr -dc 'a-zA-Z0-9')" > registry/registry_pwd.txt
