provider "google" {
  project = "vasu-first-project"
  region  = "us-central1"
}

data "google_storage_bucket" "bucket" {
  name = "my-bucket-vasu2511"
}

resource "google_storage_bucket_object" "object" {
  name         = "spark_job.py"
  source       = "code/spark_job.py"
  content_type = "text/plain"
  bucket       = data.google_storage_bucket.bucket.name
}