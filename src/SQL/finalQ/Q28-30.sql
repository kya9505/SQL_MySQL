-- 28
desc 사원;
desc 고객;
desc 주문;
select *
from 사원;

-- 28
select 담당자명
    from 고객
 where 담당자명 like '%정%';

-- 28
select *
from 주문
where 주문일 between '2020-04-01'and '2020-06-30';

-- 29
select 제품번호, 제품명, 재고,
case
when 재고 >= 100 then'과다재고'
when 재고 >= 10 then '적정'
else '재고부족'
end 재고구분
from 제품;


-- 30
select 이름, 부서번호, 직위 , 입사일, DATEDIFF(now(),입사일) 입사일수, round(DATEDIFF(now(),입사일)/30) 입사개월수
from 사원
where DATEDIFF(now(),입사일)/30 >= 40;
