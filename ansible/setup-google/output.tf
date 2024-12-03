output "vm_external_ip" {
  value = google_compute_instance.demo[*].network_interface[0].access_config[0].nat_ip
}

output "cluster_name" {
  value = google_container_cluster.primary.name
}
