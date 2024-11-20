#!/bin/bash

python3 -m venv .venv
source .venv/bin/activate

pip3 install -r requirements.txt

echo Creating hosts file.
touch hosts.ini

echo "Creating vault file, paste the necessary informations to connect to the hosts. Press enter to continue."
read

ansible-vault create vault.yml
