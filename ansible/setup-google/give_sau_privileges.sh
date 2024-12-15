#!/bin/bash

export $(grep -v '^#' .env | xargs)

gcloud config set project $TF_VAR_gcp_project_id

# create storage bucket
gcloud projects add-iam-policy-binding $TF_VAR_gcp_project_id \
    --member "serviceAccount:$TF_VAR_gcp_email" \
    --role "roles/storage.objectViewer"

# create artifact registry
gcloud projects add-iam-policy-binding $TF_VAR_gcp_project_id \
    --member "serviceAccount:$TF_VAR_gcp_email" \
    --role "roles/artifactregistry.writer"

# create k8s cluster
gcloud projects add-iam-policy-binding $TF_VAR_gcp_project_id \
    --member "serviceAccount:$TF_VAR_gcp_email" \
    --role "roles/container.clusterAdmin"

# add artifact registry admin role
gcloud projects add-iam-policy-binding $TF_VAR_gcp_project_id \
    --member "serviceAccount:$TF_VAR_gcp_email" \
    --role "roles/artifactregistry.admin"

# add artifact registry create on push writer role
gcloud projects add-iam-policy-binding $TF_VAR_gcp_project_id \
    --member "serviceAccount:$TF_VAR_gcp_email" \
    --role "roles/artifactregistry.createOnPushWriter"

# create vm
gcloud projects add-iam-policy-binding $TF_VAR_gcp_project_id \
    --member "serviceAccount:$TF_VAR_gcp_email" \
    --role "roles/compute.instanceAdmin.v1"

# add firewall rule
gcloud projects add-iam-policy-binding $TF_VAR_gcp_project_id \
    --member "serviceAccount:$TF_VAR_gcp_email" \
    --role "roles/compute.securityAdmin"

# add static ip
gcloud projects add-iam-policy-binding $TF_VAR_gcp_project_id \
    --member "serviceAccount:$TF_VAR_gcp_email" \
    --role "roles/compute.addressAdmin"

# add service account user role
gcloud projects add-iam-policy-binding $TF_VAR_gcp_project_id \
    --member "serviceAccount:$TF_VAR_gcp_email" \
    --role "roles/iam.serviceAccountUser"


# add cluster admin role
gcloud projects add-iam-policy-binding $TF_VAR_gcp_project_id \
    --member "serviceAccount:$TF_VAR_gcp_email" \
    --role "roles/container.admin"

##########

gcloud services enable \
    cloudresourcemanager.googleapis.com \
    artifactregistry.googleapis.com

