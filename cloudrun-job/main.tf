resource "google_cloud_run_v2_job" "hello_job" {
  name     = "hello-job"
  location = var.region

  template {
    task_count = 1
    template {
      containers {
        image = "gcr.io/${var.project_id}/hello-job"
      }
    }
  }
}

resource "google_cloud_scheduler_job" "daily_job" {
  name        = "run-hello-job"
  description = "Runs hello-job daily"
  schedule    = "0 0 * * *"
  time_zone   = "Asia/Bangkok"

  http_target {
    http_method = "POST"
    uri         = "https://${var.region}-run.googleapis.com/apis/run.googleapis.com/v1/namespaces/${var.project_id}/jobs/${google_cloud_run_v2_job.hello_job.name}:run"
    oidc_token {
      service_account_email = var.scheduler_service_account
    }
  }
}
