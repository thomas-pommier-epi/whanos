provider "google" {
  project = var.gcp_project_id
  region  = var.gcp_region
  credentials = file(var.gcp_auth)
}

# resource "google_container_cluster" "primary" {
#   name     = "whanos-deployment-cluster"
#   location = var.gcp_region
#   enable_autopilot         = false
#   # enable_l4_ilb_subsetting = true

#   # network    = google_compute_network.default.id
#   # subnetwork = google_compute_subnetwork.default.id

#   # remove_default_node_pool = true
#   initial_node_count       = 2

#   node_config {
#     machine_type = "e2-medium"
#     disk_size_gb = 10
#   }

#   deletion_protection = false
# }


resource "google_container_cluster" "primary" {
  name     = "whanos-gke-cluster"
  location = var.gcp_region

  # We can't create a cluster with no node pool defined, but we want to only use
  # separately managed node pools. So we create the smallest possible default
  # node pool and immediately delete it.
  remove_default_node_pool = true
  initial_node_count       = 1
  deletion_protection = false
}

resource "google_container_node_pool" "primary_preemptible_nodes" {
  name       = "whanos-node-pool"
  location   = var.gcp_region
  cluster    = google_container_cluster.primary.name
  node_count = 2

  node_config {
    preemptible  = true
    machine_type = "e2-small"

    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    service_account = google_service_account.default.email
    oauth_scopes    = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
    disk_size_gb = 12
  }
}

##### VPS Instance #####

resource "google_compute_instance" "default" {
  name         = "whanos-head"
  machine_type = "e2-medium"
  zone         = "${var.gcp_vm_region}-a"
  tags         = ["allow-ssh"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
      size  = 20
    }
  }

  network_interface {
    network = "default"

    access_config {
      nat_ip = google_compute_address.static_ip.address
    }
  }

  metadata = {
    ssh-keys = "ansible:${file("../keys/ansible_key.pub")}"
    startup-script = <<-EOT
      #!/bin/bash
      echo 'ansible ALL=(ALL) NOPASSWD:ALL' | sudo tee /etc/sudoers.d/ansible
    EOT
  }

  service_account {
    scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }
}

resource "google_compute_address" "static_ip" {
  name = "whanos-head-static-ip"
  region = var.gcp_vm_region
}
