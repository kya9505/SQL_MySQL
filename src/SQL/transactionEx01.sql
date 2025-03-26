create table acount(name varchar(30), balance int);

insert into acount values ('박지성',100000);
insert into acount values ('김연아',100000);

start transaction ;
update acount set balance = balance - 10000 where name = '박지성';
update acount set balance = balance + 10000 where name = '김연아';
commit;

select *from acount

