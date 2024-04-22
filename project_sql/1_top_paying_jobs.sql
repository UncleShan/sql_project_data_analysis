/**
 Question: what are the top-paying data analyst jobs?
 - identify the top 10 highest-paying data analyst roles that are available remotely
 - focuses on job postings with specified salaries (remove nulles)
 - highlight the top-paying opportunities for data analysts, offering insight into employment 
 */
SELECT job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date,
    b.name as company_name
from job_postings_fact a
    left join company_dim b on a.company_id = b.company_id
where job_title_short = 'Data Analyst'
    and job_location = 'Anywhere'
    and salary_year_avg is not null
order by salary_year_avg desc
limit 10;