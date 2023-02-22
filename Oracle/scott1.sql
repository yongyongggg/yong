rem 사원정보를 저장하기 위한 salesman 테이블을 생성
create table salesman (
id char(6),
name varchar2(12),
age number(3),
address varchar2(60)
);
commit;
desc salesman;

desc emp;
rem 게시판 정보를 저장하기 위한 board 테이블을 생성
create table board (
num number(4),
title varchar2(30),
author varchar2(12),
content varchar2(600),
writeday date default sysdate
);
desc board;

rem salesman 테이블에 sal 컬럼을 추가
alter table salesman
add (sal number(7, 2));
desc salesman;

rem salesman 테이블에 sal 컬럼의 최대 자릿수를 10 자리로 수정
alter table salesman
modify (sal number(10, 2));
desc salesman;

rem salesman 테이블에 sal 컬럼을 삭제
alter table salesman
drop (sal);
desc salesman;

rem salesman 테이블을 삭제
drop table salesman;
select * from tab;

rem recyclebin 에서 삭제된 salesman 테이블의 정보를 확인
show recyclebin;

rem 삭제된 salesman 테이블을 복구
flashback table salesman to before drop;
select * from tab;

rem salesman 테이블을 완전히 삭제
drop table salesman;
purge recyclebin;
select * from tab;

rem board 테이블의 이름을 변경
rename board to copy_board;

rem copy_board 테이블의 저장 공간을 삭제
truncate table copy_board;

rem 컬럼 레벨 방식으로 제약조건을 지정하여 customer 테이블을 생성
create table customer (
num number(4) primary key,
name varchar2(12) not null,
address varchar2(60) unique,
age number(3) check(age >= 30)
);

rem emp 테이블에서 사원번호와 사원명을 조회
select empno, ename from emp;
rem emp 테이블에서 모든 사원의 컬럼 내용을 조회
select * from emp;
rem emp 테이블에서 사원의 직급이 중복되는 값이 없도록 조회
select distinct job from emp;

rem dept 테이블에서 컬럼명 대신에 별칭을 이용해서 조회
select dname as 부서명, loc as "부서 위치" from dept;

rem emp 테이블에서 사원의 연봉을 산술 연산자를 적용하여 조회
select ename, sal, sal*12 from emp;

rem emp 테이블에서 커미션을 추가한 연봉을 조회하고 null 이면 null 값을 조회한다.
select ename, sal, sal*12, comm, sal*12+comm from emp;

rem emp 테이블에서 특정 컬럼을 더블 버티컬바 연산자로 연결하여 조회
select empno||'-'||ename as 명단 from emp;

rem emp 테이블에서 급여가 2000 이상인 사원만 조회
select empno, ename, sal from emp
where sal >= 2000;

rem emp 테이블에서 직급이 CLERK 이고 부서번호가 10 인 사원의 정보를 조회
select empno, ename, job, deptno from emp
where deptno = 10 and job = 'CLERK';

rem emp 테이블에서 직급이 MANAGER 이거나 입사일이 1982 년 1 월 1 일 이후에 입사한사원의 정보를 조회
select empno, ename, job, hiredate from emp
where hiredate >= '1982/01/01' or job = 'MANAGER';

rem emp 테이블에서 입사일이 1981 년 5 월 5 일과 1981 년 12 월 31 일 사이의 사원정보를조회
select empno, ename, hiredate from emp
where hiredate between '1981/05/05' and '1981/12/31';

rem emp 테이블에서 급여가 1500 과 4000 사이가 아닌 사원정보를 조회
select empno, ename, sal from emp
where sal not between 1500 and 4000;

rem emp 테이블에서 job 이 MANAGER, SALESMAN, SALESOMAN 인 사원의 정보를 조회
select empno, ename, job from emp
where job in ('MANAGER','SALESMAN', 'SALESOMAN');

rem emp 테이블에서 사원번호가 7369, 7521, 7698 이 아닌 사원의 정보를 조회
select empno, ename, job from emp
where empno not in(7369, 7521, 7698);

rem emp 테이블에서 이름이 J 문자로 시작하는 사원의 정보를 조회
select empno, ename, hiredate, sal from emp
where ename like 'J%';

rem emp 테이블에서 이름이 N 문자로 끝나는 사원의 정보를 조회한다.
select empno, ename, hiredate, sal from emp
where ename like '%N';

rem emp 테이블에서 이름에서 두 번째 문자가 A 문자인 사원의 정보를 조회한다.
select empno, ename, hiredate, sal from emp
where ename like '_A%';

rem emp 테이블에서 이름에 N 문자를 포함하는 사원의 정보를 조회한다.
select empno, ename, hiredate, sal from emp
where ename like '%N%';

rem emp 테이블에서 이름에 N 문자를 포함하지 않는 사원의 정보를 조회한다.
select empno, ename, hiredate, sal from emp
where ename not like '%N%';

rem emp 테이블에서 이름이 FORD 인 사원의 정보를 조회한다.
select empno, ename from emp
where ename = 'FORD';

rem emp 테이블에서 입사일이 1982 년 1 월 1 일 이후에 입사한 사원의 정보를 조회한다.
select empno, ename, hiredate from emp
where hiredate >= '1982/01/01';

rem emp 테이블에서 커미션이 null 인 사원의 정보를 조회한다.
select empno, ename, job, comm from emp
where comm is null;

rem emp 테이블에서 커미션이 null 이 아닌 사원의 정보를 조회한다.
select empno, ename, job, comm from emp
where comm is not null;

rem 테이블의 구조와 데이터를 모두 복사하여 새로운 테이블을 생성한다.
create table sonboard
as
select * from copy_board;

rem 테이블의 데이터는 복사하지 않고 테이블의 구조만 복사한 새로운 테이블을 생성
create table board
as
select * from sonboard
where 2=1;

rem emp 테이블에서 급여가 낮은 순으로 사원 정보를 조회한다.
select empno, ename, sal from emp
order by sal asc;

rem emp 테이블에서 입사일이 가장 최근인 순서로 사원정보를 조회한다.
select empno, ename, hiredate from emp
order by hiredate desc;

rem emp 테이블에서 급여 순으로 정렬하고 급여가 같으면 다시 이름순으로 조회한다.
select empno, ename, sal from emp
order by sal desc, ename;

rem board 테이블에 새로운 컬럼값을 저장한다.
insert into board(num, title, author, content)
values(1, '테스트', '홍길동', '테스트입니다.');
select * from board;

rem dept 테이블에 새로운 부서 정보를 저장한다.
insert into dept(deptno, dname, loc)
values(50, '개발부', '서울');
select * from dept;

rem 부모 키가 존재하지 않는 데이터를 입력하면 오류가 발생한다.
insert into emp(empno, ename, deptno)
values(6789, '홍길동', 70);

rem dept 테이블의 부서번호가 50 인 부서명을 기획실로 변경한다.
update dept
set dname = '기획실'
where deptno = 50;
select * from dept;

rem dept 테이블의 사원번호가 50 인 컬럼값을 삭제한다.
delete from dept
where deptno = 50;
select * from dept;

rem 외래키가 존재하는 부모 테이블을 삭제하면 오류가 발생한다.
delete from dept
where deptno = 30;

rem commit 문으로 트랜잭션 작업을 완료 시키면 실제적인 물리적 디스크에 저장한다.
rem 외부 응용 프로그램에서 데이터를 입력할 때 commit 문으로 저장하지 않으면 실제 데이터가저장되지 않는다.
insert into dept(deptno, dname, loc)
values(50, '인사과', '부산');
commit;
select * from dept;

rem rollback 문은 트랜잭션을 취소한다.
rem rollback 문으로 트랜잭션 작업을 취소시키면 실제적인 물리적 디스크에서 정보를 취소한다.
delete from emp;
select * from emp;
rollback;
select * from emp;

rem savepoint 문은 트랜잭션 내의 책갈피 기능을 하고 ;(세미콜론)으로 종료한다.
rem savepoint 문으로 현재 트랜잭션 내에 저장 지점을 만든다.
insert into dept(deptno, dname, loc) values(60, '총무과', '광주');
savepoint a;
insert into dept(deptno, dname, loc) values(70, '개발과', '대구');
savepoint b;
select * from dept;
delete from dept where deptno = 60 or deptno = 70;
select * from dept;
rollback to savepoint a;
select * from dept;