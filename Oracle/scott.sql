desc emp ;
SELECT * from tab;
select username from all_users;

select empno, ename, hiredate from emp
where lower(ename) = 'ford';

select empno, ename, hiredate from emp
where ename = upper('ford');

select deptno, initcap(dname), initcap(loc) from dept
where deptno = 10 ;

select deptno, dname, concat(deptno, dname) from dept
where deptno = 10;


select substr(ename,1,2) from emp;

select deptno, dname, length(dname) from dept
where deptno = 10;

select deptno, dname, instr(dname, 'G') from dept
where deptno = 10;

select deptno, dname, loc from dept
where instr(loc, 'DALLAS') > 0;

select deptno, dname, loc from dept
where instr(loc, 'DALLAS') <1 ;

select deptno, dname, lpad(dname,15,'*') from dept
where deptno = 10;

select deptno, dname, rpad(dname,15,'*') from dept
where deptno = 10;

select deptno, dname, trim(both ' ' from dname) from dept
where deptno =10;

select deptno, dname, trim(leading' 'from dname) from dept 
where deptno =10;

select deptno, dname, translate(dname, 'NG', 'SO') from dept
where deptno =10;

select deptno, dname, replace(dname,' ','') from dept
where deptno = 10; 

select round(45.926,2) from dual ;

select trunc(45.926, 2) from dual;

select mod(1600, 300) from dual;

select sysdate from dual;

select ename, hiredate, sysdate, months_between(sysdate, hiredate) from emp
where deptno = 10 ;

select ename, hiredate, add_months(hiredate, 5) from emp
where deptno = 10;

select ename, hiredate, next_day(hiredate, '금') as 월 from emp
where deptno = 10;

select ename, hiredate, last_day(hiredate) as 월 from emp
where deptno =10;

select ename, hiredate, sysdate, round(months_between(sysdate, hiredate)) 월수 from emp
where deptno =10;

select ename, hiredate, sysdate, trunc(months_between(sysdate, hiredate)) 월수 from emp
where deptno = 10;

select sysdate, to_char(sysdate, 'YYYY "년" MM "월" DD "일" ') from dual;

select sysdate, to_char(sysdate, 'hh24:mi:SS') from dual;

select empno, ename, to_char(hiredate, 'yyyy') as 년도 from emp;

select empno, ename, to_char(sal, '$999,999') as 급여 from emp;

select to_number('1234', '9999') from dual;

select ename, sal, sal*12, comm, sal*12+nvl(comm, 0) from emp;

select count(*), count(comm) from emp;

select max(sal) from emp;

select max(hiredate) from emp;

select min(sal) from emp;

select min(hiredate) from emp;

select sum(sal) from emp;
select avg(sal) from emp;
select avg(sal)from emp;
select variance(sal) from emp;
select stddev(sal) from emp;










