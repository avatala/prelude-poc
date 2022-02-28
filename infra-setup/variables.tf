variable "project" {
  type        = string
  default     = "iac-mgmt"
  description = "Enter the project ID, in which resources are provisioned"
}

variable "subnet_region" {
  type        = string
  default     = "us-central1"
  description = "Enter the region of the subnet"
}

variable "zone" {
  type        = string
  default     = "us-central1-a"
  description = "Enter the zone name"
}

variable "vpc_network" {
  type        = string
  description = "Enter the name of the VPC that need to provision"
  default     = "prelude-network"
}

variable "snapshot_region" {
  type        = string
  description = "Enter the region to store snapshot schedule"
  default     = "us-central1"
}