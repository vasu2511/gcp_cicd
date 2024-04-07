provider "google" {
  project = "vasu-first-project"
  region  = "us-central1"
}

# Start an existing Dataproc cluster
resource "google_dataproc_cluster" "existing_cluster" {
  name   = "my-first-cluster"
  region = "us-central1"

  # Omitted other cluster configuration options since it's an existing cluster
}

resource "google_storage_bucket" "bucket" {
  name                     = "gcp-tfm-my-bucket-vasu1923"
  location                 = "US"
  force_destroy            = true
  public_access_prevention = "enforced"
}

resource "google_storage_bucket_object" "object" {
  name         = "abc.txt"
  source       = "code/abc.txt"
  content_type = "text/plain"
  bucket       = google_storage_bucket.bucket.name
}