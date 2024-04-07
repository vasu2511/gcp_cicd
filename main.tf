resource "google_storage_bucket" "my-bucket" {
  name                     = "gcp-tfm-my-bucket-vasu2511"
  project                  = "vasu-first-project-"
  location                 = "US"
  force_destroy            = true
  public_access_prevention = "enforced"
}