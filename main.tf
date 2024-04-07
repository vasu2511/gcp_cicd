resource "google_storage_bucket" "my-bucket-vasu2511" {
  name                     = "terraform-bucket"
  project                  = "vasu-first-project"
  location                 = "US"
  force_destroy            = true
  public_access_prevention = "enforced"
}