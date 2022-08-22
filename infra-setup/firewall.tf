# Ingress rule to bastion host

resource "google_compute_firewall" "bastion" {
  name          = "bastion-ingress"
  network       = google_compute_network.vpc_network.name
  source_ranges = ["0.0.0.0/0"]

  allow {
    protocol = "tcp"
    ports    = ["3389"]
  }

  target_tags = ["bastion-i-allow"]
}


# Ingress rule from bastion host to internal server

resource "google_compute_firewall" "internal-app" {
  name    = "bastion-internal-ingress"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "tcp"
    ports    = ["3389", "8080", "443", "8443"]
  }
  source_ranges = [google_compute_subnetwork.subnet.ip_cidr_range]
  target_tags   = ["bastion-i-internal-allow"]
}
# Ingress allow SSh to clarion app server instance 

resource "google_compute_firewall" "app-ssh" {
  name    = "app-i-ssh"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["bastion-i-internal-allow"]
}


# Ingress rule from app server to sql server

resource "google_compute_firewall" "internal-sql" {
  name    = "sql-internal-ingress"
  network = google_compute_network.vpc_network.name
  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["3389", "1433"]
  }
  source_ranges = [google_compute_subnetwork.subnet.ip_cidr_range, "35.226.130.118"]
  target_tags   = ["sql-i-allow"]
}

# SMTP allow Egress rule

resource "google_compute_firewall" "smtp" {
  name      = "smtp-external-egress"
  network   = google_compute_network.vpc_network.name
  direction = "EGRESS"

  allow {
    protocol = "tcp"
    ports    = ["587"]
  }

  destination_ranges = ["0.0.0.0/0"]
  target_tags        = ["bastion-e-allow-smtp", "app-e-allow-smtp"]

}

#Allow IMAP and POP to network

resource "google_compute_firewall" "imap" {
  name    = "imap-pop-ingress-allow"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "icmp"
  }
  allow {
    protocol = "tcp"
    ports    = ["993", "995"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["bastion-i-internal-allow", "bastion-i-allow"]

}




