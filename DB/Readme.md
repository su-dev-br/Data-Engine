# postgres

0. connect to psql
psql -U admin -d airflow

1. List All Databases
\l

2. Connect to a Specific Database
\c airflow

3. List All Tables in the Database
\dt

4. Describe a Specific Table
\d table_name
\d dag_run

5. Show All Relationships
\di

6. View the Database Schema
SELECT * FROM information_schema.tables;