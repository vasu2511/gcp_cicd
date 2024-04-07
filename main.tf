provider "google" {
  project = "vasu-first-project"
  region  = "us-central1"
}


# Start the existing Dataproc cluster
resource "null_resource" "start_cluster" {
  # Use a local-exec provisioner to execute gcloud command to start the cluster
  provisioner "local-exec" {
    command = "gcloud dataproc clusters start my-first-cluster --region us-central1 --project vasu-first-project"
  }
}

data "google_storage_bucket" "bucket" {
  name = "gcp-tfm-my-bucket-vasu1923"
}

resource "google_storage_bucket_object" "object" {
  name         = "abc.txt"
  source       = "code/abc.txt"
  content_type = "text/plain"
  bucket       = data.google_storage_bucket.bucket.name
}