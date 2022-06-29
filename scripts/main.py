import datetime
import os
from googleapiclient.discovery import build
from google.oauth2 import service_account

def firestoreExportDocuments(request):
    project_id = os.environ['project_id']
    collections = os.environ['collections'].split(",")
    backup_bucket = os.environ['backup_bucket']
    service = build('firestore', 'v1')
    timestamp = datetime.datetime.now().strftime('%Y%m%d-%H%M%S')
    for collection in collections:
        outputUriPrefix = "gs://"+ backup_bucket + "/" + collection + "/" + timestamp
        body = {
        'collectionIds': collection,
        'outputUriPrefix': outputUriPrefix,
        }
        print (body)
        database_name = 'projects/{}/databases/(default)'.format(project_id)
        service.projects().databases().exportDocuments(name=database_name, body=body).execute()
