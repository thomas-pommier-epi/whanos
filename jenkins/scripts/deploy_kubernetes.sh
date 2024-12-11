#!/bin/bash

if [[ ! -f whanos.yml ]]; then
    exit 0
fi

project_name=$1
project_id=$(cat /opt/auth/project_id)

exported=$(python3 /opt/k8s/deployer.py "$(realpath .)" $project_name $project_id)

if [[ -z $exported ]]; then
    exit 1
fi

will_restart=$(! kubectl get pods | grep -q $project_name; echo $?)

kubectl apply -f $exported

if [[ $will_restart -eq 0 ]]; then
    kubectl rollout restart deployment/$project_name
fi
