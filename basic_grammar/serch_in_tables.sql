select *
from sections,sector;

select *
from sector,sections where sector.section_id = sections.id;-- obviously inner connection

select sector.name as name,sections.name section_name
from sector,sections where sector.section_id = sections.id;

select s.name, sections.name
from sections inner join sector s on sections.id = s.section_id;-- obscure inner connection

-- left and right out connection is just decide which table will show full information:left is represent
-- the table which was after join.
select sector.*,sections.name
from sections left join sector   on sections.id = sector.section_id;
-- self-connection
select  s1.name,s2.name manage
from sector s2 right join sector s1 on s1.manager_id = s2.id ;
-- union connection(add all will not deduplication)
select *
from sector where sector.age<30 union all select * from sector where salary>15000;
-- nested query:search the people whose salary more than everyone in finance apart
select *
from sector where salary > all(select salary from sector where section_id in (select id from sections where name = '研发部'));
-- all(compare all) and any or some(compare with the small)

select *
from sector where (job,salary) in (select job,salary from sector where job = '项目经理' or name = 'stack');
select *
from (select * from sector where entry_date > '2002-02-05') t left join sections on section_id = sections.id;
