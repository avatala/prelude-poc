# Required providers block

terraform {
  required_version = ">= 0.13.0"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.7.0"
    }
  }
}



# Provider block

provider "google" {
  project = var.project
  region  = var.subnet_region
  zone    = var.zone
}