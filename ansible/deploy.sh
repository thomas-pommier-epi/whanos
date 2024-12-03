#!/bin/bash

if [ ! -f hosts.ini ]; then
    echo "Please create a hosts file with the necessary IP addresses."
    exit 1
fi

ansible-playbook -i hosts.ini deploy_docker_registry.yml
