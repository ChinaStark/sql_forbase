alter table user add money int;

start transaction ;
update user set user.money = user.money-2000 where name = 'tom';

update user set user.money = user.money+2000 where name = 'anni';

commit ;
-- show the transaction isolation level
select @@transaction_isolation;

set transaction isolation level read committed ;
start transaction ;
select name,money
from user;


start transaction ;
update user set user.money = user.money-2000 where id = 1;

rollback ;