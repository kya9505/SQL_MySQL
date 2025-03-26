use ssgdb;

CREATE TABLE IF NOT EXISTS testTBL (id int, txt varchar(20));
insert into testTBL(id,txt) values (1, '레드벨벳'),(2, '잇지'),(3,'블랙핑크');

set global log_bin_trust_function_creators  = 1;

delimiter //
create trigger testTrg
    AFTER DELETE
    ON testTBL
    FOR EACH ROW
BEGIN
    SET @msg = '가수 그룹이 삭제됨';
end //
delimiter ;


set @msg = '';
insert into testTBL values (4,'마마무');
set @msg = '';
update testTBL set txt = '블핑' where id = 3;

set @msg = '';

delete from testTBL WHERE ID = 4;
SELECT @msg;

CREATE TABLE backup_userTbl
( userID  CHAR(8) NOT NULL PRIMARY KEY,
  name    VARCHAR(10) NOT NULL,
  birthYear   INT NOT NULL,
  addr	  CHAR(2) NOT NULL,
  mobile1	CHAR(3),
  mobile2   CHAR(8),
  height    SMALLINT,
  mDate    DATE,
  modType  CHAR(2), -- 변경된 타입. '수정' 또는 '삭제' 를 저장한다. 
  modDate  DATE, -- 변경된 날짜
  modUser  VARCHAR(256) -- 변경한 사용자
);

DROP TRIGGER IF EXISTS backUserTbl_UpdateTrg;
DELIMITER //
CREATE TRIGGER backUserTbl_UpdateTrg  -- 트리거 이름
    AFTER UPDATE -- 변경 후에 작동하도록 지정
    ON userTBL -- 트리거를 부착할 테이블
    FOR EACH ROW
BEGIN
    INSERT INTO backup_userTbl VALUES( OLD.userID, OLD.name, OLD.birthYear,
                                       OLD.addr, OLD.mobile1, OLD.mobile2, OLD.height, OLD.mDate,
                                       '수정', CURDATE(), CURRENT_USER() );
END //
DELIMITER ;


DELIMITER //
CREATE TRIGGER backUserTbl_DeleteTrg  -- 트리거 이름
    AFTER DELETE -- 삭제 후에 작동하도록 지정
    ON userTBL -- 트리거를 부착할 테이블
    FOR EACH ROW
BEGIN
    INSERT INTO backup_userTbl VALUES( OLD.userID, OLD.name, OLD.birthYear,
                                       OLD.addr, OLD.mobile1, OLD.mobile2, OLD.height, OLD.mDate,
                                       '삭제', CURDATE(), CURRENT_USER() );
END //
DELIMITER ;


SELECT * FROM backup_userTbl;

UPDATE userTbl SET addr = '몽고' WHERE userID = 'JKW';
DELETE FROM userTbl WHERE height >= 177;

SELECT * FROM backup_userTbl;


DROP TRIGGER IF EXISTS userTbl_InsertTrg;
DELIMITER //
CREATE TRIGGER userTbl_InsertTrg  -- 트리거 이름
    AFTER INSERT -- 입력 후에 작동하도록 지정
    ON userTBL -- 트리거를 부착할 테이블
    FOR EACH ROW
BEGIN
    SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = '데이터의 입력을 시도했습니다. 귀하의 정보가 서버에 기록되었습니다.';
END //
DELIMITER ;

INSERT INTO userTbl VALUES('ABC', '에비씨', 1977, '서울', '011', '1111111', 181, '2019-12-25');

DROP TRIGGER IF EXISTS userTbl_BeforeInsertTrg;
DELIMITER //
CREATE TRIGGER userTbl_BeforeInsertTrg  -- 트리거 이름
    BEFORE INSERT -- 입력 전에 작동하도록 지정
    ON userTBL -- 트리거를 부착할 테이블
    FOR EACH ROW
BEGIN
    IF NEW.birthYear < 1900 THEN
        SET NEW.birthYear = 0;
    ELSEIF NEW.birthYear > YEAR(CURDATE()) THEN
        SET NEW.birthYear = YEAR(CURDATE());
    END IF;
END //
DELIMITER ;


INSERT INTO userTbl VALUES
    ('AAA', '에이', 1877, '서울', '011', '1112222', 181, '2022-12-25');
INSERT INTO userTbl VALUES
    ('BBB', '비이', 2977, '경기', '011', '1113333', 171, '2019-3-25');

SHOW TRIGGERS FROM ssgdb;

DROP TRIGGER userTbl_BeforeInsertTrg;


CREATE TABLE orderTbl -- 구매 테이블
(orderNo INT AUTO_INCREMENT PRIMARY KEY, -- 구매 일련번호
 userID VARCHAR(5), -- 구매한 회원아이디
 prodName VARCHAR(5), -- 구매한 물건
 orderamount INT );  -- 구매한 개수
CREATE TABLE prodTbl -- 물품 테이블
( prodName VARCHAR(5), -- 물건 이름
  account INT ); -- 남은 물건수량
CREATE TABLE deliverTbl -- 배송 테이블
( deliverNo  INT AUTO_INCREMENT PRIMARY KEY, -- 배송 일련번호
  prodName VARCHAR(5), -- 배송할 물건
  account INT UNIQUE); -- 배송할 물건개수

INSERT INTO prodTbl VALUES('사과', 100);
INSERT INTO prodTbl VALUES('배', 100);
INSERT INTO prodTbl VALUES('귤', 100);

-- 물품 테이블에서 개수를 감소시키는 트리거
DROP TRIGGER IF EXISTS orderTrg;
DELIMITER //
CREATE TRIGGER orderTrg  -- 트리거 이름
    AFTER  INSERT
    ON orderTBL -- 트리거를 부착할 테이블
    FOR EACH ROW
BEGIN
    UPDATE prodTbl SET account = account - NEW.orderamount
    WHERE prodName = NEW.prodName ;
END //
DELIMITER ;

-- 배송테이블에 새 배송 건을 입력하는 트리거
DROP TRIGGER IF EXISTS prodTrg;
DELIMITER //
CREATE TRIGGER prodTrg  -- 트리거 이름
    AFTER  UPDATE
    ON prodTBL -- 트리거를 부착할 테이블
    FOR EACH ROW
BEGIN
    DECLARE orderAmount INT;
    -- 주문 개수 = (변경 전의 개수 - 변경 후의 개수)
    SET orderAmount = OLD.account - NEW.account;
    INSERT INTO deliverTbl(prodName, account)
    VALUES(NEW.prodName, orderAmount);
END //
DELIMITER ;

INSERT INTO orderTbl VALUES (NULL,'JOHN', '배', 5);

SELECT * FROM orderTbl;
SELECT * FROM prodTbl;
SELECT * FROM deliverTbl;

SELECT * FROM orderTbl;
SELECT * FROM prodTbl;
SELECT * FROM deliverTbl;ALTER TABLE deliverTBL CHANGE prodName productName VARCHAR(5);

ALTER TABLE deliverTBL CHANGE prodName productName VARCHAR(5);

INSERT INTO orderTbl VALUES (NULL, 'DANG', '사과', 9);

SELECT * FROM orderTbl;
SELECT * FROM prodTbl;
SELECT * FROM deliverTbl;