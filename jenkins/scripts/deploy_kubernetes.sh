#!/bin/bash

if [[ ! -f whanos.yml ]] then;
    exit 0
fi

project_name=$1

exported=$(python3 /opt/k8s/deployer.py "$(realpath .)" $project_name)

if [[ -z $exported ]]; then
    exit 1
fi

kubectl apply -f $exported
