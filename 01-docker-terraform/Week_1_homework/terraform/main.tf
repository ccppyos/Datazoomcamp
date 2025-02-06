terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.11.0"
    }
  }
}

provider "google" {
    credentials = var.credentials
    project = var.project
    region  = var.region
}

resource "google_storage_bucket" "taxi-bucket" {
  name          = var.gcs_bucket_name
  location      = var.gcp_storage_location
  force_destroy = true

  lifecycle_rule {
    condition {
      age = 1
    }
    action {
      type = "AbortIncompleteMultipartUpload"
    }
  }
}

resource "google_bigquery_dataset" "demo-dataset" {
  dataset_id = "demo_dataset"
  location      = var.gcp_storage_location
}