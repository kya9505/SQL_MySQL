-- 94
create view view_단가별그룹 as
    select 제품명,
        case
            when 단가 <= 5000 then 'C'
            when 단가 <= 10000 then 'B'
            else 'A'
            end as 단가별등급
    from 제품;

drop view view_단가별그룹;

select * from view_단가별그룹;

-- 95

SELECT 고객회사명, 마일리지,
       (select MAX(마일리지) from 고객) AS 최고마일리지,
       (select MAX(마일리지) from 고객)- 마일리지 AS 마일리지차이
FROM 고객
GROUP BY 고객번호, 고객회사명;

-- 96
select *, RANK() over(order by (단가*주문수량) desc) as 순위
from 주문세부
group by 제품번호;

-- 97
select (단가*주문수량) 주문금액합 ,sum(단가*주문수량) 누적주문금액합
from 주문세부
join 주문 on 주문세부.주문번호 = 주문.주문번호
group by date_format(주문.주문일,'%Y-%m')
