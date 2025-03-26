
create database normalization;
grant all privileges on normalization.* to ssg@localhost;

use normalization;
create database  if not exists normalization;

use normalization;

CREATE TABLE 동아리가입학생학과  -- 기본키 {동아리번호,학번} 인 정규화되지 않은 동아리 가입학생학과 테이블
(  동아리번호 	CHAR(2) NOT NULL,
   동아리명  	VARCHAR(30) NOT NULL,
   동아리개설일 	DATETIME NOT NULL,
   학번 	CHAR(6)  NOT NULL,
   이름     	VARCHAR(20)  NOT NULL,
   동아리가입일  DATETIME  NOT NULL,
   학과번호 CHAR(2) NOT NULL,
   학과명 VARCHAR(50) NOT NULL,
   CONSTRAINT pk_동아리번호_학번 PRIMARY KEY (동아리번호,학번)
  );
DESC 동아리가입학생학과;


create table 동아리(
    동아리번호 	CHAR(2) NOT NULL,
    동아리명  	VARCHAR(30) NOT NULL,
    동아리개설일 	DATETIME NOT NULL,
    학번 	CHAR(6)
);


INSERT INTO 동아리가입학생학과 VALUES
                             ('C1', '지구여행', '2000-02-01', '231001', '문지영', '2023-04-01', 'D1', '화학공학과'),
                             ('C1', '지구여행', '2000-02-01', '231002', '배경민', '2023-04-03', 'D4', '경영학과'),
                             ('C2', '클래식연구회', '2010-06-05', '232001', '김명희', '2023-03-22', 'D2', '통계학과'),
                             ('C3', '위조이골프', '2020-03-01', '232002', '전은정', '2023-03-07', 'D2', '통계학과'),
                             ('C3', '위조이골프', '2020-03-01', '231002', '배경민', '2023-04-02', 'D4', '경영학과'),
                             ('C4', '끼춤', '2021-02-01', '231001', '문지영', '2023-04-30', 'D1', '화학공학과'),
                             ('C4', '끼춤', '2021-02-01', '233001', '이현경', '2023-03-27', 'D3', '컴퓨터공학과');




