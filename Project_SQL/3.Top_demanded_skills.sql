SELECT skills,
    COUNT(job_postings_fact.job_id) as No_of_postings
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE job_title_short= 'Data Analyst' AND
    job_work_from_home = TRUE
GROUP BY skills
ORDER BY No_of_postings DESC
LIMIT 5