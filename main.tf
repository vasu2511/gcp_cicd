resource "google_storage_bucket" "bucket" {
  name                     = "gcp-tfm-my-bucket-vasu1929"
  project                  = "vasu-first-project"
  location                 = "US"
  force_destroy            = true
  public_access_prevention = "enforced"
}

resource "google_storage_bucket_object" "default" {
  name         = "abc.txt"
  source       = "/abc.txt"
  content_type = "text/plain"
  bucket       = google_storage_bucket.bucket.id
}