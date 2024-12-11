#!/bin/bash

if [ ! -f .env ]; then
    echo "Please create a .env file with the required environment variables."
    exit 1
fi

export $(grep -v '^#' .env | xargs)

if ! command -v terraform &> /dev/null
then
    echo "Terraform could not be found. Please install Terraform to proceed."
    exit 1
fi

terraform init

terraform plan

terraform apply

#######

if [[ $? -ne 0 ]]; then
    echo "Terraform apply failed. Please check the logs for more information."
    exit 1
fi

export HEAD_IP=$(terraform output vm_external_ip)
export CLUSTER_NAME=$(terraform output cluster_name)

echo "#!/bin/bash" > terraform_outputs.sh
echo "HEAD_IP=${HEAD_IP}" >> terraform_outputs.sh
echo "CLUSTER_NAME=${CLUSTER_NAME}" >> terraform_outputs.sh
echo "PROJECT_ID=${TF_VAR_gcp_project_id}" >> terraform_outputs.sh

chmod +x terraform_outputs.sh
