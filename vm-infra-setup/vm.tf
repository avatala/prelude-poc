resource "google_service_account" "default" {
  account_id   = "my-custom-sa"
  display_name = "Service Account"
}

resource "google_compute_instance" "instance" {
  name         = "test"
  machine_type = "n1-standard-1"
  zone         = "europe-north1-a"

  tags = ["foo", "bar"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-10"
    }
  }

  // Local SSD disk
  scratch_disk {
    interface = "SCSI"
  }
/*resource "google_compute_firewall" "rules" {
  project     = "my-project-name"
  name        = "my-firewall-rule"
  network     = "default"
  description = "Creates firewall rule targeting tagged instances"

  allow {
    protocol  = "tcp"
    ports     = ["80", "8080", "443"]
  }

  source_tags = ["foo"]
  target_tags = ["web"]
}
*/
    access_config {
      // Ephemeral public IP
    }
  }

  metadata = {
    foo = "bar"
  }

  metadata_startup_script = "echo hi > /test.txt"

  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = google_service_account.default.email
    scopes = ["cloud-platform"]
  }
}