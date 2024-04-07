provider "google" {
  project = "vasu-first-project"
  region  = "us-central1"
}


# Check if the cluster already exists
data "google_dataproc_cluster" "existing_cluster" {
  name   = "my-first-cluster"
  region = "us-central1"
}

# Create or start the cluster based on existence
resource "google_dataproc_cluster" "example_cluster" {
  count   = length(data.google_dataproc_cluster.existing_cluster)
  name    = "my-first-cluster"
  region  = "us-central1"
  # Add other cluster configuration options as needed
  
  # Only create the cluster if it doesn't exist
  lifecycle {
    ignore_changes = [name, config]
  }
}

# Only start the existing cluster if it exists
resource "google_dataproc_cluster" "start_cluster" {
  count   = length(data.google_dataproc_cluster.existing_cluster)
  name    = "my-first-cluster"
  region  = "us-central1"
  # Add other cluster configuration options as needed
  
  # Only start the cluster if it exists
  lifecycle {
    ignore_changes = [name, config]
  }
}

# Run this block if the cluster doesn't exist
resource "google_dataproc_cluster" "create_cluster" {
  count   = var.create_cluster ? 1 : 0
  name    = "cluster-terraform"
  region  = "us-central1"
  # Add other cluster configuration options as needed
}

resource "google_storage_bucket_object" "object" {
  name         = "abc.txt"
  source       = "code/abc.txt"
  content_type = "text/plain"
  bucket       = google_storage_bucket.bucket.name
}