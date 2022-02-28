# Backend for Terraform state file

terraform {
  backend "gcs" {
    bucket = "prelude-poc-bucket"
    prefix = "terraform-state"
  }
}
