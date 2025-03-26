grant all privileges on 신세계무역 to ssg@localhost;

use 신세계무역;

select *
from 제품
where 제품명 like '%주스%';

select *
from 제품
where 제품명 like '%주스%' and (단가 between 5000 and 10000);

select *
from 제품
where 제품번호 = 1 or 제품번호 = 2 or 제품번호 = 4 or 제품번호 = 7 or 제품번호 = 11 or 제품번호 = 20;

select 제품번호, 제품명, 단가, 재고, 단가*재고 재고금액
from 제품
order by 재고금액 desc
limit 10;




