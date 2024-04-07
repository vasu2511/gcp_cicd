provider "google" {
  project = "vasu-first-project"
  region  = "us-central1"
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