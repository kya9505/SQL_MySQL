use 신세계무역;

-- 45
select 등급명, count(*) 고객수
from 고객
join 마일리지등급 on 고객.마일리지 >= 마일리지등급.하한마일리지 and 고객.마일리지 <= 마일리지등급.상한마일리지
group by 등급명;

-- 46
select *
from 고객
join 주문 on  주문.고객번호 = 고객.고객번호
where 주문.주문번호 ='H0249';

-- 47
select *
from 고객
         join 주문 on  주문.고객번호 = 고객.고객번호
where 주문.주문일 = '2020-04-09';


-- 48
select 고객.도시,sum(주문세부.단가*주문세부.주문수량) 주문금액합
from 주문세부
join 주문 on 주문세부.주문번호 = 주문.주문번호
join 고객 on 주문.고객번호 = 고객.고객번호
group by 고객.도시
order by 주문금액합 desc
limit 5;


-- 54
select sum(주문세부.주문수량) 주문수량합
    from 주문세부
join 제품 on 주문세부.제품번호 = 제품.제품번호
where 제품.제품명 like '%아이스크림%';
-- 55
select count(*)
from 주문
join 고객 on 주문.고객번호 = 고객.고객번호
where 고객.도시 = '서울특별시';

