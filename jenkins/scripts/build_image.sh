#!/bin/bash

project_name=$1
base_image_folder="/opt/docker-base-images/"

if [[ $project_name == whanos-* ]]; then
    echo "Invalid project name, do not use the 'whanos-' prefix"
    exit 1
fi

if [[ -f Dockerfile ]]; then
    docker build -t $project_name .
    exit 0
fi

## Base Functions ##

build_docker() {
    docker build -t $project_name -f $1 .
    return 0
}

create_standalone_path() {
    echo "$base_image_folder/$1/Dockerfile.standalone"
}

####################

build_c() {
    if [[ ! -f Makefile ]]; then
        return 1
    fi

    local path=$(create_standalone_path "c")
    build_docker $path
    return 0
}

build_java() {
    if [[ ! -f app/pom.xml ]]; then
        return 1
    fi

    local path=$(create_standalone_path "java")
    build_docker $path
    return 0
}

build_python() {
    if [[ ! -f requirements.txt ]]; then
        return 1
    fi

    local path=$(create_standalone_path "python")
    build_docker $path
    return 0
}

build_javascript() {
    if [[ ! -f package.json ]]; then
        return 1
    fi

    local path=$(create_standalone_path "javascript")
    build_docker $path
    return 0
}

build_befunge() {
    if [[ ! -f app/main.bf ]]; then
        return 1
    fi

    local path=$(create_standalone_path "befunge")
    build_docker $path
    return 0
}

####################

build_c || build_java || build_python || build_javascript || build_befunge

if [[ $? -ne 0 ]]; then
    echo "No valid project found"
    exit 1
fi
