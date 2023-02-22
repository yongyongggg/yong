-- SQL developer에서 scott계정으로 table 생성
 create table test_table(
id varchar(50) primary key,
pass varchar(30) not null, 
name varchar(25) not null,
age number(2));

insert into test_table values('hong', '1234', '홍길동', 35);
insert into test_table values('kim', '5678', '김길동', 45);
select * from test_table;
commit;

CREATE TABLE PY_TABLE(
id varchar(50) primary key,
pass varchar(30) not null,
name varchar(25) not null,
age number(2));
insert into py_table values('hong', '1234', '홍길동', 35);
insert into py_table values('kim', '5678', '김길동', 45);
select * from py_table;
commit;