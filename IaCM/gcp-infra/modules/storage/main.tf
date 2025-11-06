terraform {
  backend "gcs" {}
  
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }
}

provider "google" {
  project = var.project
  region  = var.region
}

resource "google_storage_bucket" "bucket" {
  name          = "demo-storage-bucket-${random_id.bucket_suffix.hex}"
  location      = var.region
  force_destroy = true
}

resource "random_id" "bucket_suffix" {
  byte_length = 4
}

variable "project" {}
variable "region" {}
