resource "google_compute_firewall" "rules" {
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
