with skills_demand as (
    SELECT skills_dim.skill_id,
        skills_dim.skills,
        count(skills_job_dim.job_id) as demand_count
    from job_postings_fact
        INNER JOIN skills_job_dim on job_postings_fact.job_id = skills_job_dim.job_id
        INNER JOIN skills_dim on skills_dim.skill_id = skills_job_dim.skill_id
    where job_title_short = 'Data Analyst'
        and job_work_from_home is TRUE
        and salary_year_avg is not null
    group BY skills_dim.skill_id
),
average_salary as (
    SELECT skills_dim.skill_id,
        skills_dim.skills,
        round(avg(salary_year_avg), 0) as avg_salary
    from job_postings_fact
        INNER JOIN skills_job_dim on job_postings_fact.job_id = skills_job_dim.job_id
        INNER JOIN skills_dim on skills_dim.skill_id = skills_job_dim.skill_id
    where job_title_short = 'Data Analyst'
        and job_work_from_home is TRUE
        and salary_year_avg is not null
    group BY skills_dim.skill_id
)
select skills_demand.skills,
    skills_demand.demand_count,
    average_salary.avg_salary
from skills_demand
    INNER JOIN average_salary on skills_demand.skill_id = average_salary.skill_id
WHERE skills_demand.demand_count > 10
order by average_salary.avg_salary desc,
    skills_demand.demand_count desc
limit 25;