# Backend for Terraform state file

terraform {
  backend "gcs" {
    bucket = "prelude-solution-provider-bucket"
    prefix = "terraform-state"
  }
}
