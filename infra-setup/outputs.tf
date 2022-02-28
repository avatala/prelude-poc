output "sql-server-int-ip" {
  value       = google_compute_instance.sql-server.network_interface.0.network_ip
  description = "Internal IP address of the sql server"
}

output "app-server-int-ip" {
  value       = google_compute_instance.app-server.network_interface.0.network_ip
  description = "Internal IP address of the java web server"
}

output "bastion-host-ext-ip" {
  value       = google_compute_address.ip-add.address
  description = "External IP address of the Bastion host"
}
output "app-server-ext-ip" {
  value       = google_compute_address.app-ip-add.address
  description = "External IP address of the app server"
}
