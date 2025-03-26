use 신세계무역;

desc 주문세부;
select *
from 사원;

-- 36
select 제품번호, 주문수량 주문수량합, 주문수량*단가 주문금액합
from 주문세부
group by 제품번호;

-- 37
select 주문번호, 제품번호, 주문수량*단가 주문금액합
from 주문세부
group by 주문번호;

-- 38
select * , count(*) 주문건수
from 주문
group by 고객번호
order by count(*) desc
limit 3;

-- 39
select 직위,count(*) 사원수, group_concat(이름) 이름
from 사원
group by 직위

