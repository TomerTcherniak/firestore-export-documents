# firestore-export-documents

Cloud function to export Firestore collections

# author

Tomer Tcherniak

# info

```
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

# cloud scheduler

scheduler was set up on a weekly basis , each backup will cost and it counts the reads


