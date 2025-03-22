import json
import requests
from datetime import datetime, timedelta
import os
from airflow.decorators import dag, task
from airflow.operators.bash import BashOperator

from google.cloud import storage


default_args = {}


@dag()
def simple_api_dag():

    @task
    def pull_data_from_api():
        url = ""
        response = requests.get(url)
        data = response.json()

    t1 = pull_data_from_api()

    t2 = BashOperator(task_id="task_hello_world", bash_command='echo "Hello, World"')

    t1 >> t2


# Instantiate the DAG
dag = simple_api_dag()