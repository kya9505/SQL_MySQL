-- 77
create view view_상위3고객 as
select 고객.고객번호,고객회사명,담당자명,(단가*주문수량) 주문금액합
from 주문세부
join 주문 on 주문세부.주문번호 = 주문.주문번호
join 고객 on 주문.고객번호 = 고객.고객번호
order by 주문금액합 desc
limit 3 ;

select * from view_상위3고객;
select * from view_제품명별주문요약;
select * from view_제품명별주문1000개이상;
select * from 광역시고객;

-- 78
create view view_제품명별주문요약 as
select 제품.제품명, sum(주문세부.주문수량) 주문수량합, (주문세부.주문수량*주문세부.단가) 주문금액합
from 제품
join 주문세부 on 제품.제품번호 = 주문세부.제품번호
group by 주문세부.제품번호;

-- 79
create view view_제품명별주문1000개이상 as
select 제품명,sum(주문수량) 주문수량합
from 주문세부
join 제품 on 주문세부.제품번호 = 제품.제품번호
group by 주문세부.제품번호
having 주문수량합 >= 1000;

-- 80
create view 광역시고객 as
    select 고객번호, 고객회사명, 담당자명, 도시
    from 고객
    where 도시 like '%광역시%';