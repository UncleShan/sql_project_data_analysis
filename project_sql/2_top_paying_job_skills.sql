/**
 Question: what are the top-paying data analyst jobs?
 - identify the top 10 highest-paying data analyst roles that are available remotely
 - focuses on job postings with specified salaries (remove nulles)
 - highlight the top-paying opportunities for data analysts, offering insight into employment 
 - help job seekers understand which skills to develop that align with top salaries
 */
with top_paying_jobs as (
    SELECT job_id,
        job_title,
        salary_year_avg,
        b.name as company_name
    from job_postings_fact a
        left join company_dim b on a.company_id = b.company_id
    where job_title_short = 'Data Analyst'
        and job_location = 'Anywhere'
        and salary_year_avg is not null
    order by salary_year_avg desc
    limit 10
)
select top_paying_jobs.*,
    skills
from top_paying_jobs
    INNER JOIN skills_job_dim on top_paying_jobs.job_id = skills_job_dim.job_id
    inner JOIN skills_dim on skills_dim.skill_id = skills_job_dim.skill_id
order by salary_year_avg desc