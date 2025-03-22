import json
import requests
from datetime import datetime, timedelta
import os
from airflow.decorators import dag, task
from airflow.operators.bash import BashOperator

from google.cloud import storage

#  define the default arguments
default_args = {
    'owner': 'airflow',
    'depends_on_past': False,
    'email_on_failure': False,
    'email_on_retry': False,
    'retries': 1,
    'retry_delay': timedelta(minutes=5),
}


def failure_callback(context):
    print(f"Task {context['task_instnce'].task_id} failed")


@dag(
    default_args=default_args,
    description='A simple DAG to pull data from an API',
    schedule_interval=timedelta(days=1),
    start_date=datetime(2025, 3, 21),
    catchup=False,
)


def simple_api_dag():

    @task(on_failure_callback=failure_callback)
    def pull_data_from_api():
        url = "https://data.cityofnewyork.us/resource/h9gi-nx95.json?crash_date=2014-01-21T00:00:00:000"
        response = requests.get(url)

        if response.status_code != 200:
            raise ValueError("Failed to pull data from API")
        data = response.json()

        json_path = '/tmp/api_data.json'
        with open(json_path, 'w') as f:
            json.dump(data, f)

        # upload to Google Cloud Storage
        client = storage.Client()
        bucket = client.bucket()
        blob = bucket.blob(f'data/api_data.json')
        blob.upload_from_filename(json_path)
        os.remove(json_path)

        print("Data pulled from API and saved to data/api_data.json")

    pull_data_from_api_task = pull_data_from_api()

    bash_task = BashOperator(
        task_id="task_hello_world", 
        bash_command='echo "Hello, World"'
    )

    # managing dependencies
    pull_data_from_api_task >> bash_task


# Instantiate the DAG
dag = simple_api_dag()