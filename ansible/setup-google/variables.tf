variable "gcp_project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "gcp_region" {
  description = "The GCP region"
  type        = string
}

variable "gcp_vm_region" {
    description = "The GCP VM region"
    type        = string
}

variable "gcp_auth" {
  description = "The path to the GCP auth token file"
  type        = string
}
