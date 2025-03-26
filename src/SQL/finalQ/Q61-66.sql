-- 61.
use 신세계무역;

select *
from 고객
where 고객번호 = 'ZZZAA';
-- 61
insert into 고객(고객번호,담당자명,고객회사명,도시) values ('ZZZAA','한동욱','자유트레이닝','서울특별시');
-- 62
update 고객 set 도시 = '부산광역시',마일리지 = 100, 담당자직위 = '대표이사' where 고객번호 = 'ZZZAA';
-- 63
update 고객 join(select avg(마일리지) as avg from 고객 where 담당자직위 = '대표이사') as sub set 고객.마일리지 = sub.avg where 고객번호 = 'ZZZAA';
-- 64
insert into 사원(사원번호,이름,직위) values ('E15','이석진','수습사원') on duplicate key update 사원번호 = 'E15',이름 = '이석진',직위='수습사원'
-- 65
delete from 고객 where 고객번호 = 'ZZZAA';
-- 66
delete from 사원 where 사원번호 = 'E15';

