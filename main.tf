resource "google_storage_bucket" "MY-BUCKET" {
  name                     = "terraform-bucket"
  location                 = "US"
  force_destroy            = true
  public_access_prevention = "enforced"
}