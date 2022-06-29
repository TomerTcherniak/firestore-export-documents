resource "google_storage_bucket" "functions_store" {
  name     = "${var.bucketname}"
  project  = "${var.project}"
  location = "${var.region}"
}

data "archive_file" "function_firestoreExportDocuments" {
  type        = "zip"
  source_dir  = "./scripts"
  output_path = "firestoreExportDocuments.zip"
}

resource "google_storage_bucket_object" "firestoreExportDocumentstion_code" {
  name   = "firestoreExportDocuments.zip"
  bucket = "${google_storage_bucket.functions_store.name}"
  source = "${data.archive_file.function_firestoreExportDocuments.output_path}"
}

# google_cloudfunctions_function.firestoreExportDocuments:
resource "google_cloudfunctions_function" "firestoreExportDocuments" {
    available_memory_mb          = 256
    docker_registry              = "CONTAINER_REGISTRY"
    entry_point                  = "firestoreExportDocuments"
    https_trigger_security_level = "SECURE_OPTIONAL"
    https_trigger_url            = "https://${var.region}-${var.project}.cloudfunctions.net/firestoreExportDocuments"
    ingress_settings             = "ALLOW_ALL"
    labels                       = {
        "deployment-tool" = "console-cloud"
    }
    environment_variables = {
      "project_id" = "${var.project}"
      "collections"="${var.collections}"
      "backup_bucket"="${var.backup_bucket}"
    }
    max_instances                = 3000
    min_instances                = 0
    name                         = "firestoreExportDocuments"
    project                      = "${var.project}"
    region                       = "${var.region}"
    runtime                      = "${var.runtime}"
    service_account_email        = "${var.service_account}"
    timeout                      = 60
    trigger_http                 = true

    timeouts {}
    source_archive_bucket = google_storage_bucket.functions_store.name
    source_archive_object = google_storage_bucket_object.firestoreExportDocumentstion_code.name

}

# google_cloud_scheduler_job.firestoreExportDocuments:
resource "google_cloud_scheduler_job" "firestoreExportDocuments" {
    attempt_deadline = "180s"
    name             = "firestoreExportDocuments"
    project          = "${var.project}"
    region           = "${var.region}"
    schedule         = "0 0 * * 6"
    time_zone        = "Asia/Jerusalem"

    http_target {
        headers     = {}
        http_method = "POST"
        uri         = "https://${var.region}-${var.project}.cloudfunctions.net/firestoreExportDocuments"

        oidc_token {
            audience              = "https://${var.region}-${var.project}.cloudfunctions.net/firestoreExportDocuments"
            service_account_email = "${var.project}@appspot.gserviceaccount.com"
        }
    }

    retry_config {
        max_backoff_duration = "3600s"
        max_doublings        = 5
        max_retry_duration   = "0s"
        min_backoff_duration = "5s"
        retry_count          = 0
    }

    timeouts {}
}
