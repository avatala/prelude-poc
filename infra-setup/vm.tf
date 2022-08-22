# Reserve the External IP address for Instance

resource "google_compute_address" "ip-add" {
  name = "bastion-host-ext-ip"
}

resource "google_compute_address" "app-ip-add" {
  name = "app-server-ext-ip"
}


locals {
  service_account = "1067081160439-compute@developer.gserviceaccount.com"
}

# Bastion-server machine creation

resource "google_compute_instance" "bastion-server" {
  name         = "bastion-host"
  description  = "Windows Server 2019 Datacenter"
  machine_type = "g1-small"
  tags         = ["bastion-i-allow", "bastion-e-allow-smtp"]
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-10"
    }
  }
  network_interface {
    network    = google_compute_network.vpc_network.self_link
    subnetwork = google_compute_subnetwork.subnet.self_link
    access_config {
      nat_ip = google_compute_address.ip-add.address
    }
  }
  service_account {
    email  = local.service_account
    scopes = ["cloud-platform"]
  }
}

# App server machine creation

resource "google_compute_instance" "app-server" {
  name         = "app-server-prelude"
  description  = "Windows Server 2019 Datacenter"
  machine_type = "n1-standard-1"
  tags         = ["bastion-i-internal-allow", "app-e-allow-smtp"]
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-10"
    }
  }
  network_interface {
    network    = google_compute_network.vpc_network.self_link
    subnetwork = google_compute_subnetwork.subnet.self_link
    access_config {
      nat_ip = google_compute_address.app-ip-add.address
    }
  }
  attached_disk {
    source = google_compute_disk.app-disk.self_link
  }
  service_account {
    email  = local.service_account
    scopes = ["cloud-platform"]
  }
}

# SQL server machine creation

resource "google_compute_instance" "sql-server" {
  name         = "sql-server-prelude"
  description  = "SQL Server 2019 Standard on Windows Server 2019 Datacenter"
  machine_type = "n1-standard-1"
  tags         = ["sql-i-allow"]
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-10"
    }
  }
  network_interface {
    network    = google_compute_network.vpc_network.self_link
    subnetwork = google_compute_subnetwork.subnet.self_link
  }
  attached_disk {
    source = google_compute_disk.sql-disk.self_link
  }
  service_account {
    email  = local.service_account
    scopes = ["cloud-platform"]
  }
}

