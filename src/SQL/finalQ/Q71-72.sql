create table 영화(
    영화번호 char(5) primary key ,
    타이틀 varchar(100) not null ,
    장르 varchar(20),
    constraint genre_CK check ('장르' in('코미디','드라마','다큐','SF','액션','역사','기타')),
    배우 varchar(100) not null ,
    감독 varchar(50)not null ,
    제작사 varchar(50)not null,
    개봉일 date,
    등록일 datetime default now()
);

desc 영화;
create table 평점관리(
    번호 int auto_increment primary key ,
    평가자닉네임 varchar(50) not null ,
    영화번호 char(5) not null ,
    평점 int check ( 평점>0 and 평점<6) not null ,
    평가 varchar(2000) not null ,
    등록일 datetime default now()
);
alter table 평점관리 add constraint 영화번호_fk foreign key(영화번호) references 영화(영화번호);
;