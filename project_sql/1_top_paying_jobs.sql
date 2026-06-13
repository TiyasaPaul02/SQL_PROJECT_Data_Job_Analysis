/*
Question: What are the top high-paying data analyst jobs?
- Identify the top 10 highest paying data analyst roles that are available remotely.
- Focus on job postings with specified salaries (Remove nulls).
- Why? Highlight the top-paying opportunities for data analysts.
*/

SELECT
    job_postings_fact.job_id,
    company_dim.name AS coompany_name,
    job_postings_fact.job_title,
    job_postings_fact.job_location,
    job_postings_fact.job_schedule_type,
    job_postings_fact.salary_year_avg,
    job_postings_fact.job_posted_date
FROM
    job_postings_fact
LEFT JOIN company_dim
       ON job_postings_fact.company_id = company_dim.company_id
WHERE
    job_title_short = 'Data Analyst' AND
    job_location = 'Anywhere' AND
    salary_year_avg IS NOT NULL 
ORDER BY
    salary_year_avg DESC
LIMIT
    10