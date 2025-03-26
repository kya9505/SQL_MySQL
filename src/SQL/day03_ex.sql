-- 1-1 
-- 1-2
-- 1-3
-- 1-4
-- 2-1 
-- 2-2 
-- 2-3
-- 2-4
-- 2-5
-- 2-6
-- 2-7
 
   -- 3시 50분까지 문제 풀어 슬랙으로 제출해 주세요. 
  select name, address
  from customer
  -- where name like '김%아';
  where name like '김__' and name like '__아';
  
select custid,sum(saleprice)
from orders
group by custid
having custid = 1; 



