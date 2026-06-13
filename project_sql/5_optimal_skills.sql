/*
Question: What are the most optimal skills to learn (aka skills in high demand and high-paying skills)?
- Identify skills in high demand and associated with high average salaries for Data Analyst roles.
- Concentrate on remote positions with specified salaries.
- Why? Targets skills that offer job security (high demand) and financial benefits (high salaries)
  offering strategic insights for career development in data analysis.
*/

WITH high_demand_skills AS (
    SELECT
        skills_dim.skill_id,
        COUNT (skills_dim.skill_id) AS demand_count,
        skills_dim.skills
    FROM 
        job_postings_fact
    INNER JOIN skills_job_dim
        ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim
        ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        job_title_short = 'Data Analyst' AND
        job_postings_fact.salary_year_avg IS NOT NULL
    GROUP BY
        skills_dim.skill_id
),
high_paying_skills AS (
    SELECT
        skills_dim.skill_id,
        skills_dim.skills,
        ROUND(AVG(job_postings_fact.salary_year_avg), 2) AS avg_salary
    FROM
        job_postings_fact
    INNER JOIN skills_job_dim
        ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim
        ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        job_postings_fact.job_title_short = 'Data Analyst' AND
        job_postings_fact.salary_year_avg IS NOT NULL
    GROUP BY
        skills_dim.skill_id
)

SELECT
    high_demand_skills.skill_id,
    high_demand_skills.skills,
    demand_count,
    avg_salary
FROM
    high_demand_skills
INNER JOIN high_paying_skills
    ON high_demand_skills.skill_id = high_paying_skills.skill_id
WHERE
    demand_count > 10
ORDER BY
    avg_salary DESC,
    demand_count DESC
LIMIT 25;

-- rewriting this same query more concisely

SELECT
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT (skills_dim.skill_id) AS demand_count,
    ROUND(AVG(job_postings_fact.salary_year_avg), 2) AS avg_salary
FROM
    job_postings_fact
INNER JOIN skills_job_dim
    ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim
    ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst' AND
    job_postings_fact.salary_year_avg IS NOT NULL
GROUP BY
    skills_dim.skill_id
HAVING
    COUNT (skills_dim.skill_id) > 10
ORDER BY
    avg_salary DESC,
    demand_count DESC
LIMIT 25;