#!/bin/bash

project_name=$1

if [[ ! -f Dockerfile ]]; then
    docker build -t $project_name .
    exit 0
fi
