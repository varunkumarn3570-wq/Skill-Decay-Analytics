create database Synthetic_Skill_Decay;
use synthetic_skill_decay;

-- creating a table of Synthetic_skill_data..

   create table Synthetic_skill_data(
   Employee_Id varchar(40) primary key,
   Department varchar(40) not null,
   Skill_Name varchar(40) not null,
   Skill_usage_frequency smallint not null,
   Training_Hours smallint not null,
   Performance_score int not null,
   Last_Used_days int not null,
   Skill_Decay_Score float4 not null);
   desc synthetic_skill_data;

-- creating a view to view the tables..

   create view viewing as
   select*from synthetic_skill_data;
   select*from viewing;
   select*from viewing limit 10;
   select skill_name from synthetic_skill_data group by skill_name;

-- samples Queries performing..
   select department, count(*)  as Total_count from synthetic_skill_data group by department;
   select skill_name,count(*) as Total_count from synthetic_skill_data group by skill_name;
   
-- Advanced  Queries..
-- 1.Which department has the highest average skill decay compared to training hours invested?
   SELECT department, AVG(skill_decay_score) AS Average_Decay
   FROM synthetic_skill_data
   GROUP BY department
   ORDER BY Average_Decay DESC;
   
-- 2.What are the top 5 skills most at risk of decay across all employees?
   Select Skill_Name, AVG(skill_decay_score) as Average_Decay
   FROM synthetic_skill_data
   GROUP BY Skill_Name
   ORDER BY Average_Decay desc limit 5;
   
-- 3. Which employees show high performance scores despite high skill decay (outliers)?
   SELECT employee_id, performance_score FROM Synthetic_skill_data
   WHERE Performance_score >95 and skill_Decay_score>4
   ORDER BY performance_score desc;
   
-- 4.How does skill usage frequency correlate with performance score?
   select Skill_usage_frequency , AVG(performance_score) as Average_Score from synthetic_skill_data
   Group by Skill_usage_frequency
   order by Skill_usage_frequency;

-- 5.Which department has the lowest training efficiency (high training hours but still high skill decay) ?
   select*from viewing;
   SELECT department, AVG(skill_usage_frequency) as Training_efficiency from synthetic_skill_data
   group by Department 
   order by training_efficiency desc;
   
-- 6.Which employees show the highest skill decay risk (top 5)?
   select employee_id,skill_decay_score from synthetic_skill_data
   order by skill_decay_score desc limit 5;
   
-- 7.Which employees show the lowest skill decay risk (bottom 5)?
   select employee_id, skill_decay_score from synthetic_skill_data
   order by skill_decay_score asc limit 5;
   
-- 8.which employees have not used a skill for the longest time (highest Last_Used_Days)?
   select*from viewing;
   select Employee_id from synthetic_skill_data where last_used_days=0;
   
-- 9.Compare average skill decay between technical vs nontechnical departments.
   select department from synthetic_skill_data group by department;
   select 
     case 
       when Department iN( "IT","HR")
       then "technical"
       else "non-technical"
       end as dept_type,
    avg(skill_decay_score) as Average_skill_decay
    from synthetic_skill_data
    group by dept_type;
    
-- 10.identify employees who need urgent training (decay score above threshold + low training hours). 
   select*from viewing;
   select employee_id, skill_decay_score from synthetic_skill_data
   where skill_decay_score > 7 and
   training_hours<10
   order by skill_decay_score desc;
   
-- 11.: Find skills that consistently decay faster regardless of department. 
   select Skill_name,AVG(skill_decay_score) as avg_score from synthetic_skill_data
   where skill_decay_score >7
   group by skill_name 
   order by avg_score desc;
   