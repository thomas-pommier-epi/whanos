#!/bin/bash

ssh-keygen -t rsa -b 2048 -f "$(realpath .)/../keys/ansible_key" -N ""
