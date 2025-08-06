resource "google_storage_bucket" "demo_bucket" {
  name     = "${var.project_id}-demo-bucket"
  location = var.region
  force_destroy = true
}
