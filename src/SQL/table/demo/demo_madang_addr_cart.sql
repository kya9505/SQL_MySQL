-- 이름: demo_madan_addr_cart.sql
-- 설명
drop table Cust_addr;
CREATE TABLE  Cust_addr (
  addrid 	  INTEGER PRIMARY KEY,  
  custid      INTEGER,  
  address     VARCHAR(50),
  phone       VARCHAR(20),
  changeday		DATE,
  FOREIGN KEY (custid) REFERENCES Customer(custid)  
);

INSERT INTO Cust_addr VALUES (1, '영국 에인트호번', '010-5000-0001', STR_TO_DATE('2003-07-01','%Y-%m-%d'));
INSERT INTO Cust_addr VALUES (1, '영국 맨체스터', '010-5000-0002', STR_TO_DATE('2005-07-01','%Y-%m-%d'));
INSERT INTO Cust_addr VALUES (1, '영국 에인트호번', '010-5000-0003', STR_TO_DATE('2013-07-01','%Y-%m-%d'));
INSERT INTO Cust_addr VALUES (1, '영국 퀸즈파크', '010-5000-0004', STR_TO_DATE('2021-07-01','%Y-%m-%d'));

commit;

CREATE TABLE Cart (
  cartid INTEGER PRIMARY KEY,
  custid  INTEGER,
  bookid  INTEGER,
  cartdate DATE,
  FOREIGN KEY (custid) REFERENCES Customer(custid),
  FOREIGN KEY (bookid) REFERENCES Book(bookid)
);

INSERT INTO Cart VALUES (1, 1, 1, STR_TO_DATE('2024-07-01','%Y-%m-%d')); 
INSERT INTO Cart VALUES (2, 1, 3, STR_TO_DATE('2024-07-03','%Y-%m-%d'));
INSERT INTO Cart VALUES (3, 1, 5, STR_TO_DATE('2024-07-03','%Y-%m-%d')); 
INSERT INTO Cart VALUES (4, 1, 6, STR_TO_DATE('2024-07-04','%Y-%m-%d')); 
commit;

ALTER TABLE Cust_addr CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
SHOW VARIABLES LIKE 'character_set%';
