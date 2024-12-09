#!/bin/bash

if [ ! -f hosts.ini ]; then
    echo "Please create a hosts file with the necessary IP addresses."
    exit 1
fi

if [ ! -f keys/whanos_gke.json ]; then
    echo "Please create a keys/whanos_gke.json file with the necessary GKE credentials."
    exit 1
fi

if [ ! -f ./setup-google/.env ]; then
    echo "Please run the setup-google/apply_terraform.sh script first."
    exit 1
fi

source .venv/bin/activate

export $(grep -v '^#' setup-google/.env | xargs)
export $(grep -v '^#' .env | xargs)
export ANSIBLE_HOST_KEY_CHECKING=False

ansible-playbook -i hosts.ini deploy_docker_registry.yml
ansible-playbook -i hosts.ini deploy_kubernetes_client.yml
ansible-playbook -i hosts.ini deploy_jenkins.yml
