-- 86
delimiter //
create procedure 담당자(in 담당자명매개값 varchar(50))
    begin
        select 부서.부서명,count(주문.주문번호) as 주문건수, sum(주문세부.주문수량*주문세부.단가)주문금액합
            from 고객
                join 사원 on 고객.담당자명 = 사원.이름
                join 부서 on 사원.부서번호 = 부서.부서번호
                join 주문 on 사원.사원번호 = 주문.사원번호
                join 주문세부 on 주문.주문번호 = 주문세부.주문번호
            where 고객.담당자명 = 담당자명매개값;
end //
delimiter ;

drop procedure 담당자;
call 담당자('손창민');

-- 87
DELIMITER //
create procedure 주문금액상위10위(in 주문시작일 date,in 주문끝일 date )
    begin
        select 제품.제품명,(주문세부.단가* 주문세부.주문수량) 주문금액합
               from 제품
                   join 주문세부 on 제품.제품번호 = 주문세부.제품번호
                    join 주문 on 주문세부.주문번호 = 주문.주문번호
               where 주문.주문일 between 주문시작일 and 주문끝일
               group by 제품.제품번호
        order by 주문금액합 desc
        limit 10;
end //
delimiter ;

drop procedure 주문금액상위10위;
call 주문금액상위10위('2020-03-12','2020-04-08');

-- 88
delimiter //
create procedure 나이대(in 생년월일 date)
    begin
        declare 나이뒷자리 int;
        set 나이뒷자리 =datediff(생년월일,now())%10;
        select
            case
                when 나이뒷자리 <= 3 then '초반'
                when 나이뒷자리 <= 7 then '중반'
                else '후반'
                end as 나이대;
end //
delimiter ;

drop procedure 나이대;

call 나이대('1995-05-15');

-- 89
delimiter //
create trigger 주문제품수량조절
    after insert
    on 주문세부
    for each row

    begin
        update 제품
        set 제품.재고 = 제품.재고- new.주문수량
        where  제품.제품번호 = new.제품번호;
end//
 delimiter ;