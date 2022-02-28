
# Create the java web server disk

resource "google_compute_disk" "app-disk" {
  name                      = "app-server-prelude-disk"
  type                      = "pd-ssd"
  size                      = 50
  physical_block_size_bytes = 4096
}

# attach snapshot schedule policy for java web server disk

resource "google_compute_disk_resource_policy_attachment" "attachment" {
  name = google_compute_resource_policy.app-policy.name
  disk = google_compute_disk.app-disk.name
  zone = var.zone
}
# Create a snapshot schedule policy for java web server disk

resource "google_compute_resource_policy" "app-policy" {
  name   = "app-server-prelude-disk-snapshot-schedule"
  region = var.snapshot_region
  snapshot_schedule_policy {
    schedule {
      daily_schedule {
        days_in_cycle = 1
        start_time    = "04:00"
      }
    }
    retention_policy {
      max_retention_days    = 10
      on_source_disk_delete = "KEEP_AUTO_SNAPSHOTS"
    }
  }
}


# Create a sql server disk

resource "google_compute_disk" "sql-disk" {
  name                      = "sql-server-prelude-disk"
  type                      = "pd-ssd"
  size                      = 50
  physical_block_size_bytes = 4096
}

# attach snapshot schedule policy for java web server disk
resource "google_compute_disk_resource_policy_attachment" "resource-attachment" {
  name = google_compute_resource_policy.sql-policy.name
  disk = google_compute_disk.sql-disk.name
  zone = var.zone
}

# Create a snapshot schedule policy for java web server disk

resource "google_compute_resource_policy" "sql-policy" {
  name   = "sql-server-prelude-disk-snapshot-schedule"
  region = var.snapshot_region
  snapshot_schedule_policy {
    schedule {
      daily_schedule {
        days_in_cycle = 1
        start_time    = "04:00"
      }
    }
    retention_policy {
      max_retention_days    = 10
      on_source_disk_delete = "KEEP_AUTO_SNAPSHOTS"
    }
  }
}
