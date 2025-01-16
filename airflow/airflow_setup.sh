#!/bin/bash

# Initialize the Airflow database (assuming default configuration is used)
airflow db migrate
airflow connections create-default-connections
# Start the Airflow webserver in the background
airflow scheduler -d
airflow webserver -p 8081 -d

# Optional: Wait for the webserver to start (adjust timeout as needed)
timeout 30 sh -c "until curl -s http://localhost:8081/health; do sleep 1; done" || exit 1

# Optionally run other commands after webserver startup
echo "Airflow webserver started"