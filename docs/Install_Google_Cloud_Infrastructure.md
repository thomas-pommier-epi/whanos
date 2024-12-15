# Install Google Cloud Infrastucture

## Prerequisites

- Terraform
- Google Terraform Plugin
- Google Cloud CLI
- A Shell (bash)

Open the terminal and go to the github repo directory via `cd`.

## Environement Setup

In the `ansible/setup-google` folder. (`cd ansible/setup-google`)
Copy the `.env.example` to `.env`

Edit all the necessary variables, here all the necessary decriptions:

| Variable Name           | Description                                   |
|-------------------------|-----------------------------------------------|
| TF_VAR_gcp_project_id   | Google Cloud project ID                       |
| TF_VAR_gcp_region       | Google Cloud region of the kubernetes cluster |
| TF_VAR_gcp_vm_region    | Google Cloud Head server location             |
| TF_VAR_gcp_auth         | Path (relative of `ansible/setup-google`) of the .json key of service account      |
| TF_VAR_gcp_vm_disk_size | Size of disk of the Whanos Head Server        |
| TF_VAR_gcp_email        | Email of the service account                  |

Once fully edited, continue to the next step.

## Ansible credentials creation

run the script `./create_ansible_keys.sh`:

```bash
./create_ansible_keys.sh
```

## Service account permissions

run the script `./give_sau_privileges.sh`:

```bash
./give_sau_privileges.sh
```

**Wait a few minutes for Google to update the privileges**

## Apply IaC

Once done, run the script `./apply_terraform.sh` to init the infrastructure: :

```bash
./apply_terraform.sh
```

If no error is detected, there should be a file named `terraform_outputs.sh`. And you can go to the next step.

Note the external IP of the Head of Whanos, where you can connect to jenkins.
