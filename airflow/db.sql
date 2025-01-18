
CREATE ROLE airflow WITH LOGIN PASSWORD 'airflow';
CREATE DATABASE airflow;
COMMIT;


SELECT FROM pg_database WHERE datname = 'airflow';
GRANT ALL PRIVILEGES ON DATABASE airflow TO airflow;
COMMIT;

