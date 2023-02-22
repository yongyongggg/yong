rem emp 테이블에서 사원번호로 그룹화하여 월급의 평균
select deptno,avg(sal) from emp
group by deptno;

rem emp 테이블에서 급여가 500 이상인 사원번호와 급여
select max(sal) from emp
group by deptno
having max(sal) >500;

rem myboard 테이블에 데이터를 입력
create table myboard (
num number(4) primary key,
author varchar2(12),
title varchar2(30),
content varchar2(60)
);
create sequence myboard_seq;

rem myboard 테이블에 데이터를 입력
insert into myboard(num, author, title, content)
values(myboard_seq.nextval, '전우치', '제목','내용이다.');

insert into myboard(num, author, title, content)
values(myboard_seq.nextval, '전우치', '제목','내용이다.');

drop sequence myboard_seq;
select * from myboard;

rem emp 테이블과 dept 테이블을 크로스 조인
select * from emp, dept;

rem 사원들의 사원번호를 조회
select empno, ename, sal, dept.deptno
from emp, dept
where emp.deptno = dept.deptno;

rem 사원들의 사원번호와 소속 부서를 조회
select e.empno, e.ename, e.sal, d.deptno, d.dname
from emp e, dept d
where e.deptno = d.deptno;

rem 부서 번호가 30번인 사원번호, 이름, 급여, 부서명을 조회
select e.empno, e.ename, e.sal, d.deptno, d.dname
from emp e, dept d
where e.deptno = d.deptno and d.deptno =30;

rem 직급이 SALESMAN 사원의 사원번호, 이름, 급여, 부서명을 조회
select e.empno, e.ename, e.sal, d.deptno, d.dname
from emp e, dept d
where e.deptno = d.deptno and e.job ='SALESMAN';

rem 커미션을 받는 사원의 이름, 직급, 부서 위치를 조회
select e.empno, e.ename, e.sal, d.deptno, d.dname
from emp e, dept d
where e.deptno = d.deptno and e.comm is not null;

rem 이름에 ‘A’ 문자가 들어있는 사원의 이름, 직급, 부서 위치를 조회
select e.ename, e.job, d.loc
from emp e, dept d
where e.deptno = d.deptno and e.ename like '%A%';

rem 부서번호가 10번인 부서에 대하여 사원번호, 이름, 업무, 급여, 급여의 등급을 조회
select e.empno, e.ename, e.job, e.sal, s.grade
from salgrade s, emp e
where e.sal between s.losal and s.hisal and e.deptno =10;

rem 사원명과 사원을 담당하는 관리자명을 조회
select employee.ename as 사원명, manager.ename as 관리자명
from emp employee, emp manager
where employee.mgr = manager.empno;

rem 사원명과 사원을 담당하는 관리자명을 조회하고 조인 조건에 만족하지 않는 행도 모두 조회
select employee.ename as 사원명, manager.ename as 관리자명
from emp employee, emp manager
where employee.mgr = manager.empno(+);

rem emp 테이블에서 SMITH 의 부서명을 호출
select dname from dept
where deptno = (select deptno from emp where ename = 'SMITH');

rem emp 테이블에서 사원번호가 7698 인 사원의 급여보다 많은 사원의 사원번호, 사원명, 직급, 급여 순으로 조회
select empno, ename, job, sal from emp
where sal > (select sal from emp where empno = 7698);

rem emp 테이블에서 사원번호가 7698 인 사원의 급여보다 적은 사원의 사원번호, 사원명, 직급, 급여 순으로 조회
select empno, ename, job, sal from emp
where sal < (select sal from emp where empno = 7698);

rem emp 테이블에서 부서번호가 20 번인 부서의 최소 급여보다 많은 부서를 조회
select deptno, min(sal) from emp
group by deptno
having min(sal) > (select min(sal) from emp where deptno = 20);

rem emp 테이블에서 rownum 슈도 컬럼으로 ename 컬럼을 10 개까지만 조회
select rownum, ename from (select * from emp order by empno)
where rownum <= 10;

rem emp 테이블에서 rownum 슈도 컬럼의 별칭으로 ename 컬럼을 10 개까지만 조회
select * from (select rownum num, ename from emp order by empno)
where num <= 10;

rem emp 테이블에서 row_number( ) over(order by column…) 문으로 ename 컬럼을 10 개까지만 조회
select * from (select row_number( ) over(order by empno) as num, ename from emp)
where num <= 10;

rem emp 테이블에서 20 번을 초과한 부서번호의 사원 급여를 조회
select ename, sal, deptno from emp
where sal in (select sal from emp where deptno > 20);

rem emp 테이블에서 30 번인 부서번호의 사원 중에 최소 급여보다 많은 급여를 받는 사원을 조회
select ename, sal, deptno from emp
where sal > any (select sal from emp where deptno = 30);

rem emp 테이블에서 30 번인 부서번호의 사원 중에 최대 급여보다 많은 급여를 받는 사원을 조회
select ename, sal, deptno from emp
where sal > all (select sal from emp where deptno = 30);

rem emp 테이블의 부서번호가 30 인 조건에 의해서 dept 테이블을 조회
select * from dept
where exists (select * from emp where deptno = 30);

rem emp 테이블과 dept 테이블에서 월급에 관련된 내용만 조회할 수 있는 뷰를 생성한다.
rem scott 계정에는 뷰 생성 권한이 없으므로 최고관리자 SYS 계정으로 접속하여 scott 계정에
rem  grant create view to scott 문으로 뷰 생성 권한을 부여한다.
-- 뷰를 생성한다.
create or replace view son_emp
as;
-- 월급의 총합, 최대값, 최소값을 함수로 구한다.
select e.deptno, d.dname, sum(sal) totsal, max(sal) maxsal, min(sal) minsal
from emp e, dept d
where e.deptno = d.deptno
group by e.deptno, d.dname;
-- 뷰를 조회한다.
select * from son_emp;

rem 생성한 뷰를 삭제
drop view son_emp;

rem 자동 인덱스로 인덱스를 생성한 테이블의 인덱스와 인덱스 컬럼을 확인
select table_name, index_name, column_name from user_ind_columns
where table_name in('EMP');

rem 행에 대한 액세스 속도를 빠르게 하려고 컬럼에 non_unique 인덱스를 생성
-- emp 테이블을 복사한다.
create table emp_index
as
select * from emp;
-- 시간 체크를 설정한다.
set timing on;
-- 사원명을 조회한다.
select empno, ename from emp_index
where ename='SMITH';
-- 인덱스를 생성한다.
create index idx_emp on emp_index(ename);
-- 인덱스를 통해서 사원명을 조회한다.
select empno, ename from emp_index
where ename='SMITH';

rem 생성한 인덱스를 삭제
drop index idx_emp;

