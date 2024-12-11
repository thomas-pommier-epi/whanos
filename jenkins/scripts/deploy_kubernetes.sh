#!/bin/bash

if [[ ! -f whanos.yml ]]; then
    exit 0
fi

project_name=$1
project_id=$(cat /opt/auth/project_id)

declare -a exported=($(python3 /opt/k8s/deployer.py "$(realpath .)" $project_name $project_id))

if [[ ${#exported[@]} -eq 0 ]]; then
    exit 1
fi

will_restart_deploy=$(kubectl get pods | grep -q $project_name; echo $?)
will_restart_service=$(kubectl get services | grep -q $project_name; echo $?)

kubectl apply -f ${exported[0]}
kubectl apply -f ${exported[1]}

if [[ $will_restart_deploy -eq 0 ]]; then
    kubectl rollout restart deployment/$project_name
fi

external_ip=""
tries=0
max_tries=20

while [ -z "$external_ip" ] && [ $tries -lt $max_tries ]; do
    echo "Waiting for external IP... (try $((tries+1))/$max_tries)"
    external_ip=$(kubectl get svc $project_name --template="{{range .status.loadBalancer.ingress}}{{.ip}}{{end}}")
    [ -z "$external_ip" ] && sleep 5
    tries=$((tries+1))
done

if [ -z "$external_ip" ]; then
    echo "Failed to get external IP after $max_tries tries."
    exit 1
fi

echo "External IP: $external_ip"
