create table salary_level(
    grade int ,
    min int ,
    max int
);

insert into salary_level(grade, min, max) VALUES
    (1,0,3000),(2,3001,6000),(3,6001,9000),(4,9001,12000),(5,12001,999999);
select sector.name,sector.salary,salary_level.grade
from sector left join salary_level on max>sector.salary and min<sector.salary;

select sector.name, sector.salary,sector.job,sections.name, salary_level.grade
from sector,
     salary_level,
     sections
where max > sector.salary
  and min < sector.salary
  and section_id = sections.id
  and sections.name = '研发部';

select round(avg(sector.salary), 0) average
from sections,
     sector
where section_id = 2;
select distinct s1.*, (select round(avg(sector.salary), 0) average
from sector
where sector.section_id = s1.id) average
from sections s1 left join sector on s1.id = section_id;

-- search the count in every depart
select *,(select COUNT(*) from sector where s1.id = sector.section_id) count
from sections s1;

