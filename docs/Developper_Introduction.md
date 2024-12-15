# Developer informations

## Technologies used

Whanos use multiple devops technologies, this is a presentation of their purpose on the project, not a definition
- Ansible: Install Jenkins, Docker and kubectl to the head server
- Docker: Images for the applications
- Terraform: create the infrastructure in Google Cloud
- Jenkins: Build, Register and deploy the applications from the git repository (peridacally check if any updates happen via CRON)
- Docker Refistry: Store the applications images (gcr.io)
- Kubernetes: Handle and deploy the applications with a Deployment and a Load Balancer configuration file

```bash
.
├── ansible
│   ├── keys
│   └── setup-google
├── docs
│   └── images
├── gitea
├── images
│   ├── befunge
│   ├── c
│   ├── java
│   ├── javascript
│   └── python
├── jenkins
│   └── scripts
└── kubernetes
```

- `ansible` : Folder with all scripts and playbooks to instlal head VPS
  - `deploy_docker_registry.yml`: install docker on Head vps
  - `deploy_jenkins.yml`: install jenkins via JCasC and give permissions to user `jenkins`
  - `deploy_kubernetes_client.yml`: install kubernetes and google cloud and give permissions to the user `jenkins`  to push images.
  - `create_configs.yml`: create the necessary config files for ansible to function
  - `deploy.yml`: load environements variables and generated configs to deploy each ansible playbooks
  - `setup-google` : Folder with terraform scripts to init the infastructure with terraform
    - `main.tf`: main terraform file for the IaC
    - `crate_ansible_keys.sh`: create SSH key for ansible
    - `give_sau_privileges.sh`: give to the service account for the project the necessayr permissions to create and deploy applications.
    - `apply_terraform.sh`: script to load environements and apply the terraform application.
  - `keys` : Folder to store ansible SSH keys for Ansible
- `docs` : All the documentation
  - `images`: Documentation images
- `gitea` : Example instance of private repository, not using github or gitlab
- `images`: Docker Images to build from, specified by language with their `Dockerfile.base` and `Dockerfile.standalone`.
- `jenkins`: Configuration files for jenkins installation
  - `scripts`: Scripts for worflows
    - `build_images.sh`: Build image script, find the correct image based on the files of the repository if no `Dockerfile` is located.
    - `deploy_kubernetes.sh`: Deploy the script to kubernetes by generating 2 templates and applying them
    - `push_registry.sh`: Push the compiled image to gcr.io registry
  - `jenkins.yml.j2`: Template for the JCasC
  - `job_link_project.yml`: Worflow to create another worflows which links github projects and pull them every minute to see if anything changes
  - `job_base_images.groovy`: Workflow to generate docker images for the applications
  - `plugins.yml`: Plugins list necessary for jenkins to function for Whanos
- `kubernetes`: All the necessary config and scripts for GKE
  - `deployer.py`: Python script that generate the templates based on the `whanos.yml` file, the project name and the Google Cloud project ID
  - `template.deployment.yml.j2`: Jinja2 template for the deployment script for jenkins
  - `template.service.yml.j2`: Jinja2 template for the Load baalncer service
