#!/bin/bash

# TODO : add things

gcloud projects add-iam-policy-binding $TF_VAR_gcp_project_id \
    --member "serviceAccount:$TF_VAR_gcp_email" \
    --role "roles/storage.objectViewer"
gcloud projects add-iam-policy-binding $TF_VAR_gcp_project_id \
    --member "serviceAccount:$TF_VAR_gcp_email" \
    --role "roles/artifactregistry.writer"
