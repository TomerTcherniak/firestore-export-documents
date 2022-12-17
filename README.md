# firestore-export-documents

Cloud function to export Firestore collections

# author

Tomer Tcherniak

# info

```
Teleport backend are stored in backup bucket
Teleport cloud function script was set in a specific bucket
Backup is taken from Cloud Firestore
Backup is done using Cloud function
Cloud scheduler is trigger the action

```

# cloud function environment variables

```
project_id = gcp project id
collections = firestore collection name
backup_bucket = bucket backup name
```
# terraform version

Terraform v1.1.4

# terraform plan
```
terraform plan
google_storage_bucket.functions_store: Refreshing state...
google_cloud_scheduler_job.firestoreExportDocuments: Refreshing state...
google_storage_bucket_object.firestoreExportDocumentstion_code: Refreshing state...
google_cloudfunctions_function.firestoreExportDocuments: Refreshing state...

No changes. Your infrastructure matches the configuration.
```

# cloud scheduler

scheduler was set up on a weekly basis , each backup will cost and it counts the reads


