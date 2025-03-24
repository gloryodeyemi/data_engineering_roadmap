import os
import requests
import zipfile

from datetime import datetime
from airflow import DAG
from airflow.operators.python import PythonOperator

# BigQuery operators are imported in your screenshots; if you plan to use them,
# leave these imports. If not, you can remove them.
from airflow.providers.google.cloud.operators.gcs_to_bigquery import GCSToBigQueryOperator
from airflow.providers.google.cloud.operators.bigquery import (
    BigQueryExecuteQueryOperator,
)
from google.cloud import storage


default_args = {
    'owner': 'airflow',
    'start_date': datetime(2025, 3, 24),
    'retries': 1,
}

# define the DAG
dag = DAG(
    'download_and_load_data_to_snowflake_with_gcs',
    default_args=default_args,
    description='Download a zip file to GCS, unzip it, and load data into Snowflake',
    schedule_interval='@daily',
)

GCS_BUCKET_NAME = 'healthcare_data_01'
# FOLDER = 'zipped_data'
ZIP_FOLDER = 'zipped_data'
CSV_FOLDER = 'csv_data'
BIGQUERY_DATASET = 'airflow_example'
BIGQUERY_TABLE = 'inpatient_claims'
JOINED_TABLE = 'claims_beneficiary_plus'
TBL_NAME = ""
TBL_NAME2 = ""
ZIP_FILENAME_LOCAL = "/tmp/inpatient_claims.zip"
ZIP_FILENAME_GCS = f"{ZIP_FOLDER}/{ZIP_FILENAME_LOCAL}"
DOWNLOAD_URL = ("https://www.cms.gov/research-statistics-data-and-systems/downloadable-public-use-files/synpufs/downloads/de1_0_2008_to_2010_inpatient_claims_sample_1.zip")


def download_zip_file_to_gcs():
    response = requests.get(DOWNLOAD_URL)
    with open(ZIP_FILENAME_LOCAL, "wb") as f:
        f.write(response.content)
    print(f"Downloaded ZIP file from {DOWNLOAD_URL} to {ZIP_FILENAME_LOCAL}.")

    # Step 2: Upload to GCS
    client = storage.Client()
    bucket = client.bucket(GCS_BUCKET_NAME)
    blob = bucket.blob(ZIP_FILENAME_GCS)
    blob.upload_from_filename(ZIP_FILENAME_LOCAL)
    print(
        f"Uploaded {ZIP_FILENAME_LOCAL} to gs://{GCS_BUCKET_NAME}/{ZIP_FILENAME_GCS}."
    )
    os.remove(ZIP_FILENAME_LOCAL)


# define the tasks
def unzip_file_in_gcs():
    client = storage.Client()
    bucket = client.bucket(GCS_BUCKET_NAME)
    blob = bucket.blob(ZIP_FILENAME_GCS)
    blob.download_to_filename(ZIP_FILENAME_LOCAL)

    with zipfile.ZipFile(ZIP_FILENAME_LOCAL, 'r') as zip_ref:
        zip_ref.extractall('/tmp/inpatient_claims')

    for filename in os.listdir('/tmp/inpatient_claims'):
        local_path = os.path.join('/tmp/inpatient_claims', filename)
        blob = bucket.blob(f'{CSV_FOLDER}/{filename}')
        blob.upload_from_filename(local_path)
        os.remove(local_path)

    os.remove('/tmp/inpatient_claims.zip')


# define the task to check data quality in BigQuery
def check_data_quality(**kwargs):
    from google.cloud import bigquery

    client = bigquery.Client()
    query = f"""

    """


download_zip_task = PythonOperator(
    task_id="download_zip_file_to_gcs",
    python_callable=download_zip_file_to_gcs,
    dag=dag,
)

unzip_file_task = PythonOperator(
    task_id="unzip_file_in_gcs",
    python_callable=unzip_file_in_gcs,
    dag=dag,
)


download_zip_task >> unzip_file_task