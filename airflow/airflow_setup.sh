#!/bin/bash

# Load environment variables from .env file if required
# source /scripts/.env
# python3 -m venv 'airflow'
CWD="/opt/airflow"
INIT_SQL="$CWD/db.sql"
# sudo -S chmod +X $INIT_SQL

DEFAULT_DB=defaultDB
# Airflow - postgres
DB_SU=admin
DB_HOST=postgres
DB_PORT=5432
DB_USER=airflow
DB_PASSWORD=airflow
DB_NAME=airflow

FIRSTNAME=Airflow
LASTNAME=Admin
EMAIL=contactmail.br@gmail.com
ROLE=Admin
USERNAME=airflow
PASSWORD=airflow


# Check if the Airflow user exists
echo "Waiting for PostgreSQL to be ready..."
until psql -h "$DB_HOST" -p "$DB_PORT" -U "$DB_SU" -d "$DEFAULT_DB" -c "\q" &>/dev/null; do
    sleep 1
done
echo "PostgreSQL is ready!"

# Query to check if the user exists in the database
psql -h "$DB_HOST" -p "$DB_PORT" -U "$DB_SU" -d "$DEFAULT_DB" -a -f db.sql


# Initialize the Airflow database 
airflow db migrate
airflow connections create-default-connections

# Function to check if the user already exists
user_exists() {
    airflow users list --output json | jq -e ".[] | select(.username == \"$USERNAME\")" > /dev/null
    return $?
}

# Check if the user exists
if user_exists; then
    echo "User '$USERNAME' already exists. Skipping creation."
else
    echo "User '$USERNAME' does not exist. Creating user..."
    airflow users create \
        --username "$USERNAME" \
        --firstname "$FIRSTNAME" \
        --lastname "$LASTNAME" \
        --email "$EMAIL" \
        --role "$ROLE" \
        --password "$PASSWORD"
    echo "User '$USERNAME' created successfully."
fi



# Start the Airflow webserver in the background

airflow webserver -p 8081 -d
# airflow scheduler --daemon
# airflow scheduler -d
# # systemctl enable airflow-scheduler
# echo "Airflow db check started"
# echo "Airflow scheduler" & airflow scheduler & airflow webserver -p 8081 & echo "Airflow webserver"
# airflow db check

# Optional: Wait for the webserver to start (adjust timeout as needed)
timeout 30 sh -c "until curl -s http://localhost:8081/health; do sleep 1; done" || exit 1

echo "Airflow webserver started"
