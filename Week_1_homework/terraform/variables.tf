variable "credentials"  {
  description = "Credentials for GCP"
  default     = "./keys/my-creds.json"
}  

variable "gcp_storage_location" {
  description = "Location for GCP bucket"
  default     = "US"
}

variable project {
  description = "Project"
  default     = "mesmerizing-app-448304-t5"
}

variable "region" {
  description = "Region"
  default     = "us-central1"
  
}

variable "bq_dataset_name" {
  description = "My BigQuery dataset"
  default     = "taxi_dataset"
}

variable "gcp_storage_class" {
  description = "Storage class for GCP bucket"
  default     = "STANDARD"
}

variable "gcs_bucket_name" {
  description = "Name for GCP bucket"
  default     = "mesmerizing-app-448304-t5-taxi-bucket"
}

