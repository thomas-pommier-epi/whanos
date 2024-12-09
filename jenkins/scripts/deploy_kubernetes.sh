#!/bin/bash

if [[ ! -f whanos.yml ]] then;
    exit 0
fi

exported=$(python3 /opt/k8s/deployer.py "$(realpath .)" "$(basename $(realpath .))")

kubectl apply -f $exported
