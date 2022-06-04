show index from user;
create  index idx on user(money);
desc user;
explain select *
from (select * from user where id = 1)t;

show global status like 'com_______';
show variables like 'Query_time';
SET GLOBAL long_query_time=2;

show variables like 'slow_query_log';

select  @@have_profiling;
select @@PROFILING;

set profiling = 0;

show profiles ;

show profile cpu for query 65;

