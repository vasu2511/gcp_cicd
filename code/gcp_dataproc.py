
# import datetime
# from airflow.providers.google.cloud.operators.dataproc import DataprocCreateClusterOperator, DataprocSubmitJobOperator
# from airflow.contrib.operators import dataproc_operator
# from airflow import DAG
# from airflow.utils.dates import days_ago
# from datetime import timedelta

import datetime
import os

from airflow import models
from airflow.contrib.operators import dataproc_operator
from airflow.utils import trigger_rule

PROJECT_ID = "qwiklabs-gcp-02-d00e76509e5c"
CLUSTER_NAME = "example-cluster"
JOB_FILE_URI = "gs://my-bucket-vasu2511/scripts/spark_job.py"
REGION = "us-east4"


yesterday = datetime.datetime.combine(
    datetime.datetime.today() - datetime.timedelta(1),
    datetime.datetime.min.time())

# CLUSTER_CONFIG = {
#     "master_config": {
#         "num_instances": 1,
#         "machine_type_uri": "e2-standard-2",
#         "disk_config": {"boot_disk_type": "pd-standard", "boot_disk_size_gb": 32},
#     },
#     "worker_config": {
#         "num_instances": 2,
#         "machine_type_uri": "e2-standard-2",
#         "disk_config": {"boot_disk_type": "pd-standard", "boot_disk_size_gb": 32},
#     },
#     "software_config": {
#         "image_version": "2.0",
#     },
# }

# PYSPARK_JOB = {
#     "reference": {"project_id": PROJECT_ID},
#     "placement": {"cluster_name": CLUSTER_NAME},
#     "pyspark_job": {"main_python_file_uri": JOB_FILE_URI},
# }


# Define DAG arguments
# default_args = {
#     'owner': 'airflow',
#     'depends_on_past': False,
#     'email_on_failure': False,
#     'email_on_retry': False,
#     'retries': 1,
#     'retry_delay': timedelta(minutes=5),
# }

default_dag_args = {
    # Setting start date as yesterday starts the DAG immediately when it is
    # detected in the Cloud Storage bucket.
    'start_date': yesterday,
    # To email on failure or retry set 'email' arg to your email and enable
    # emailing here.
    'email_on_failure': False,
    'email_on_retry': False,
    # If a task fails, retry it once after waiting at least 5 minutes
    'retries': 1,
    'retry_delay': datetime.timedelta(minutes=5),
    'project_id': 'vasu-first-project'
}
# Define DAG
with models.DAG(
        'composer_pyspark_tutorial',
        # Continue to run DAG once per day
        schedule_interval=datetime.timedelta(days=1),
        default_args=default_dag_args) as dag:
    # create_cluster = DataprocCreateClusterOperator(
    #     task_id="create_cluster",
    #     project_id=PROJECT_ID,
    #     cluster_config=CLUSTER_CONFIG,
    #     region=REGION,
    #     cluster_name=CLUSTER_NAME,
    # )

    # pyspark_task = DataprocSubmitJobOperator(
    #     task_id="pyspark_task", job=PYSPARK_JOB, region=REGION, project_id=PROJECT_ID
    # )

    # create_cluster >> pyspark_task

    # create_dataproc_cluster = dataproc_operator.DataprocClusterCreateOperator(
    #     task_id='create_dataproc_cluster',
    #     # Give the cluster a unique name by appending the date scheduled.
    #     # See https://airflow.apache.org/code.html#default-variables
    #     cluster_name='composer-pyspark-tutorial-cluster',
    #     num_workers=2,
    #     region="us-east4",
    #     zone="us-east4-a",
    #     image_version='2.0',
    #     master_machine_type='e2-standard-2',
    #     worker_machine_type='e2-standard-2')
    
    run_dataproc_hadoop = dataproc_operator.DataProcPySparkOperator(
        task_id='run_dataproc_pyspark',
        region="us-central1",
        cluster_name='my-first-cluster',
        main=JOB_FILE_URI)
    
    
    run_dataproc_hadoop

