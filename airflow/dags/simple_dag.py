# version 1

from datetime import datetime, timedelta
from airflow import DAG
from airflow.operators.python import PythonOperator

# Default arguments for the DAG
default_args = {
    'owner': 'airflow',
    'depends_on_past': False,
    'email_on_failure': False,
    'email_on_retry': False,
    'retries': 1,
    'retry_delay': timedelta(minutes=5),
}

# Define the DAG
with DAG(
    dag_id='simple_example_dag',
    default_args=default_args,
    description='A simple example DAG',
    schedule_interval="0 */1 * * *",
    start_date=datetime(2025, 1, 1),
    catchup=False,
    tags=['example'],
) as dag:

    # Task 1: Print "Hello, World!"
    def hello_world():
        print("Hello, World!")

    task_hello = PythonOperator(
        task_id='hello_task',
        python_callable=hello_world,
    )

    # Task 2: Print the current date
    def print_date():
        print(f"Current date is: {datetime.now()}")

    task_date = PythonOperator(
        task_id='print_date_task',
        python_callable=print_date,
    )

    # Task 3: Print a goodbye message
    def goodbye():
        print("Goodbye, Airflow!")

    task_goodbye = PythonOperator(
        task_id='goodbye_task',
        python_callable=goodbye,
    )

    # Set task dependencies
    task_hello >> task_date >> task_goodbye
