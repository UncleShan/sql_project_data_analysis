/**
 Question: what are the top-paying data analyst jobs?
 - identify the top 10 highest-paying data analyst roles that are available remotely
 - focuses on job postings with specified salaries (remove nulles)
 - highlight the top-paying opportunities for data analysts, offering insight into employment 
 - help job seekers understand which skills to develop that align with top salaries
 */
SELECT skills,
    count(skills_job_dim.job_id) as demand_count
from job_postings_fact
    INNER JOIN skills_job_dim on job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim on skills_dim.skill_id = skills_job_dim.skill_id
where job_title_short = 'Data Analyst'
    and job_work_from_home is TRUE
group BY skills
order by demand_count desc
limit 5