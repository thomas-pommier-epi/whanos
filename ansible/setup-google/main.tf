provider "google" {
  project = var.gcp_project_id
  region  = var.gcp_region
  credentials = file(var.gcp_auth)
}

resource "google_container_cluster" "primary" {
  name     = "whanos-gke-cluster"
  location = var.gcp_region
  project = var.gcp_project_id

  deletion_protection = false
  node_locations = ["${var.gcp_region}-a"]

  node_pool {
    name       = "default-pool"
    node_count = 2

    node_config {
      machine_type = "e2-small"
      disk_size_gb = 12

      oauth_scopes = [
        "https://www.googleapis.com/auth/cloud-platform",
      ]
    }
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
