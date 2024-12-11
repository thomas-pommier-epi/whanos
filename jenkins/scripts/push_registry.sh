#!/bin/bash

project_name=$1

gc_project=$(cat /opt/auth/project_id)
docker_image_name="gcr.io/$gc_project/$project_name:latest"

docker tag $project_name $docker_image_name
docker push $docker_image_name
