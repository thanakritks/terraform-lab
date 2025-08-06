resource "google_cloud_run_v2_service" "http_service" {
  name     = "hello-http"
  location = var.region

  template {
    containers {
      image = "gcr.io/${var.project_id}/hello-http"
    }
  }

  traffics {
    percent         = 100
    latest_revision = true
  }
}

resource "google_cloud_run_service_iam_member" "invoker" {
  location        = google_cloud_run_v2_service.http_service.location
  service         = google_cloud_run_v2_service.http_service.name
  role            = "roles/run.invoker"
  member          = "allUsers"
}
