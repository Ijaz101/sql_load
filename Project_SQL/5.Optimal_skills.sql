WITH skills_demand AS(SELECT
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT(job_postings_fact.job_id) as No_of_postings
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE job_title_short= 'Data Analyst' AND
    salary_year_avg is NOT NULL AND
    job_work_from_home = TRUE
GROUP BY skills_dim.skill_id
),
average_salary AS
(SELECT 
    skills_job_dim.skill_id,
    ROUND(AVG(salary_year_avg),0) AS Avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE 
    job_title_short= 'Data Analyst' AND
    salary_year_avg IS NOT NULL AND
    job_work_from_home = TRUE
GROUP BY skills_job_dim.skill_id
)
SELECT
    skills_demand.skill_id,
    skills_demand.skills,
    No_of_postings,
    Avg_salary
FROM skills_demand
INNER JOIN average_salary 
ON skills_demand.skill_id = average_salary.skill_id 
ORDER BY No_of_postings DESC,
    Avg_salary DESC
    LIMIT 25