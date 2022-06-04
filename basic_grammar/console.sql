select * from emp where age>20;

select *
from emp where name1 is not null;

-- 就是<>也可以表示为不等于
-- && 和 between and 等价 包含最大和最小值 还有and 的单独使用
-- or 等价于 IN(x,y,z);只要有其中的一个即可

select *
from emp where name1 like '___'; -- 匹配长度为3的类型

select age
from emp where age like '%2'; -- 无论2前面是什可

select count(*)
from emp;-- avg , max , min , sum :聚合函数

-- 分组查询
select count(*),gender
from emp group by gender;

select count(*),workaddress
from emp where id>1 group by workaddress having count(*)>1;

-- where > 聚合函数 >group > having > select > order by > limit

select *
from emp order by age; -- 升序

select *
from emp order by age desc; -- 降序


select *
from emp order by age asc , id desc;-- 相同的年龄按id降序

select *
from emp limit 2;

select *
from emp limit 2,4;

-- from > where > 聚合函数 >group > having > select > order by > limit

select e.id r
from emp as e;

use mysql;
select * from user;

-- 创建用户
# create user 'yonghuming'@'zhujiming' identified by 'mima';
#
# alter user 'yonghuming'@'zhujiming' identified with mysql_native_password by 'mima';
create user 'yonghuming'@'localhost' identified by 'mima';
alter user 'yonghuming'@'localhost' identified with mysql_native_password by '123456789';
drop user 'yonghuming'@'localhost';
-- 权限查询
show grants for 'mysql.sys'@'localhost';
-- 权限授予 grant on 数据库名.表名 to ‘用户名’@‘主机名’    要是写的是*那就是通配符（所有的用户 数据库 表名）
-- 撤销权限 revoke on 数据库名.表名 from ‘用户名’@‘主机名’
-- grant select,delete,update,insert on table.* to 'p'@'192.168.1.103'identified by '123';
-- 上面一条语句是给另一台电脑上授予权限
select rpad('ABC',6,'-');
select upper('abcdefg');

select trim('  hd   dow ewdjeow');-- 去除两边的空格

select substr('hello mysql',1,5); -- 不能为0开始

update emp set workno = lpad(workno,3,'0'); -- 记住要写字符串

select lpad(round(rand()*1000000,0),6,0);

select ceil(2.96);

select floor(3.6936);

select mod(3,9);

select curdate();

select curtime();

select now();
select year(now());
select concat(year(now()),'-',lpad(month(now()),2,0),'-',lpad(day(now()),2,0));

select date_add(now(),interval 70 year);

select datediff('2023-04-07',concat(year(now()),'-',lpad(month(now()),2,0),'-',lpad(day(now()),2,0)));

select name1,datediff(curdate(),entrydate)
from emp order by id;

select if(id>0,'OK','NO')
from emp where name1 = '万紫欣';

select ifnull('','default');

select
       name1,
        (case workaddress when '北京' then '一线城市' when '奥迪' then 'luxury' else '二线城市' end) as"工作地址"
from emp;

create table score (
id int comment 'ID',
name varchar(20) comment '姓名',
math int comment ' 数学',
english int comment ' 英语',
chinese int comment '语文')
comment '学员成绩表' ;

insert into score (id, name, math, english, chinese) values (1,'tom',96,98,99),(2,'tony',97,100,99),(3,'wzx',86,100,100);

select
    id,
       name,
       (case when math>=85 then 'A' when math >= 70 then 'B' when math >=60 then 'C' end) 'math',
       (case when chinese>=85 then 'A' when chinese >= 70 then 'B' when chinese >=60 then 'C' end) 'chinese',
       (case when english>=85 then 'A' when english >= 70 then 'B' when english >=60 then 'C' end) 'english'

from score;

-- 约束创表
create table user
(
    id int primary key auto_increment comment 'id主键',
    name varchar(10) not null unique comment '姓名',
    age int check ( age>0 and age<120) comment '年龄',
    status char(1) default '1' comment '状态',
    gender char(1) comment '性别'
) comment '用户名';
-- insert data into user;
insert into test.user(name, age, status, gender) VALUES ('tom',23,'0','男'),('anni',35,'1','女'),
                                                        ('stark',26,'0','男'),('Hathaway',23,'1','女');
insert into test.user(name, age, status, gender) VALUE ('juli',12,'0','女');
-- 当有重复的名字的时候sql会自动申请空间但是会阻止创建该信息 所以当下次创建信息的时候id的值就会出跳过一个数

 -- 外键约束:有关联的表
create tabLe sections(
id int auto_increment comment 'ID'primary key,
name varchar(50) not null comment '部门名称'
) comment '部门表';
INSERT INTO sections (id, name) VALUES (1,'研发部'),(2,'市场部'),(3,'财务部'),(4,'销售部'),(5,'总经办');

create table sector(
id int auto_increment comment 'ID' primary key,
name varchar(50) not null comment '姓名',
age int comment '年龄',
job varchar(20) comment '职位',
salary int comment'薪资',
entry_date date comment '入职时间' ,
manager_id int comment '直属领导ID',
section_id int comment '部门ID'
# constraint section_id1 foreign key(section_id) references sections(id)  add foreign key inside
)comment '员工表';
INSERT INTO sector (name, age, job, salary, entry_date, manager_id, section_id) VALUES
('jack',66, '总裁',20000, ' 2000-01-01', null,5),('tony',31, '项目经理',12500, '2005-12-05', 1,1),
( 'stack',33,'开发',8400, '2000-11-03', 2,1),( 'andy',48, '开发' ,11000, '2002-02-05', 2,1),
( 'anni',43,'开发' ,10500, ' 2004-09-07', 3,1),( 'rachel',19, '程序员鼓励师' , 6600, '2004-10-12', 2,1);
-- 添加外键
alter table sector add constraint fk foreign key (section_id) references sections(id);
alter table sector drop foreign key fk;-- delete fk

-- 外键更新
alter table sector add constraint fk foreign key (section_id) references sections(id) on update cascade on DELETE cascade;
alter table sector add constraint fk foreign key (section_id) references sections(id) on update set null on DELETE set null ;

insert into courses(course) values
('Java'),
('PHP'), ('MySQL'),
('Hadoop');
alter table student add id int auto_increment primary key ;
alter table transform add constraint fk1 foreign key (student_id) references  student(id);

alter table transform add constraint  fk2 foreign key (course) references  courses(id);