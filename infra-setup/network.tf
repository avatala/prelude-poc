# Add a vpc network

resource "google_compute_network" "vpc_network" {
  name                    = var.vpc_network
  auto_create_subnetworks = false
  routing_mode            = "GLOBAL"
  description             = "prelude infrastructure VPC network"
}

# Add a subnet to the vpc network

resource "google_compute_subnetwork" "subnet" {
  name                     = "us-central1"
  network                  = google_compute_network.vpc_network.self_link
  ip_cidr_range            = "10.148.10.0/24"
  private_ip_google_access = true
}

