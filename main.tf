provider "google" {
  project = "vasu-first-project"
  region  = "us-central1"
}


# Define the existing Dataproc cluster
resource "google_dataproc_cluster" "example_cluster" {
  name   = "my-first-cluster"
  region = "us-central1"

  # Omitted other cluster configuration options for brevity

  # Use lifecycle to prevent changes to the cluster's configuration
  lifecycle {
    ignore_changes = [config]
  }
}

# Start the existing Dataproc cluster
resource "null_resource" "start_cluster" {
  depends_on = [google_dataproc_cluster.example_cluster]

  # Use a local-exec provisioner to execute gcloud command to start the cluster
  provisioner "local-exec" {
    command = "gcloud dataproc clusters start my-first-cluster --region your-region --project vasu-first-project"
  }
}

resource "google_storage_bucket_object" "object" {
  name         = "abc.txt"
  source       = "code/abc.txt"
  content_type = "text/plain"
  bucket       = google_storage_bucket.bucket.name
}