#!/bin/bash

python3 -m venv .venv
source .venv/bin/activate

pip3 install -r requirements.txt

ansible-galaxy collection install community.general
ansible-galaxy install -r requirements.yml

. setup-google/terraform_outputs.sh

echo Creating hosts file.

echo "[vps]" > hosts.ini
echo "${HEAD_IP}" >> hosts.ini
echo "[vps:vars]" >> hosts.ini
echo "ansible_user=ansible" >> hosts.ini
echo "ansible_ssh_private_key_file=./keys/ansible_key" >> hosts.ini
