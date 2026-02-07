COPY company_dim
FROM 'D:\LEARNING_PROGRESS\DATA_LOVE\SQL\SQL_PROJECT_Data_Job_Analysis\csv_files\company_dim.csv'
DELIMITER ',' CSV HEADER;

COPY job_postings_fact
FROM 'D:\LEARNING_PROGRESS\DATA_LOVE\SQL\SQL_PROJECT_Data_Job_Analysis\csv_files\job_postings_fact.csv'
DELIMITER ',' CSV HEADER;

COPY skills_dim
FROM 'D:\LEARNING_PROGRESS\DATA_LOVE\SQL\SQL_PROJECT_Data_Job_Analysis\csv_files\skills_dim.csv'
DELIMITER ',' CSV HEADER;

COPY skills_job_dim
FROM 'D:\LEARNING_PROGRESS\DATA_LOVE\SQL\SQL_PROJECT_Data_Job_Analysis\csv_files\skills_job_dim.csv'
DELIMITER ',' CSV HEADER;

SELECT *
FROM company_dim
LIMIT 100;