--저장 프로시저에 사용할 테이블을 emp 테이블에서 복사
create table empcopy
as
select * from emp;
/

--생성한 테이블의 정보를 조회
select * from empcopy;
/

--저장 프로시저 생성
create or replace procedure del_all
is
begin
    --empcopy 테이블의 저장된 데이터를 삭제
    delete from empcopy;
    -- 트랙잭션 작업이 성공하여 완료한다.
    commit;
end;
/

--저장 프로시저 실행하여 empcopy 테이블에 저장된 데이터 삭제
execute del_all;
/

--저장 프로시저 실행 확인
select * from empcopy;
/

--저장 프로시저의 구조 확인
--user_source 시스템의 테이블 구조 확인
desc user_source;
/
--저장 프로시저의 코드를 확인
select name, type, line, text from user_source

/
--저장 프로시저 생성을 위한 테스트를 테이블에 복사
create table empcopy2
as
select * from emp;
/

--생성한 테이블 조회
select * from empcopy2;
/

--매개변수가 존재하는 프로시저 생성
create or replace procedure del_ename(sonename empcopy2.ename%type)
is
begin
    --empcopy 테이블의 저장된 데이터를 조건에 맞게 삭제
    delete from empcopy2 where ename like sonename;
    --트랙잭션 작업이 성공하여 완료
    commit;
end;
/

--저장 프로시저를 실행하여 empcopy 테이블에 s로 시작하는 사원의 데이터 삭제
execute del_ename('S%');
/

--부서 정보를 조회하는 저장 프로시저를 생성
--매개변수가 존재하는 저장 프로시저 생성
create or replace procedure dept_select (
--in 모드로 dept 테이블의 deptno 컬럼에 입력한 값을 vdeptno 매개변수에 전달
vdeptno in dept.deptno%type,
--out 모드로 dept 테이블의 dname 컬럼을 받아와서 vdname 매개변수에서 호출
vdname out dept.dname%type,
--out 모드로 dept 테이블의 loc 컬럼값을 받아와서 vloc 매개변수에서 호출
vloc out dept.loc%type)
is
begin
    --select 문으로 수행한 결과값을 into 문 뒤에 선언한 변수에 저장
    select dname, loc into vdname, vloc from dept
    where deptno=vdeptno;
end;
/

--바인드 변수로 데이터를 저장하고 부서번호로 부서정보를 조회
/*
컬럼에 저장된 값을 호스트 환경에서 생성하여 데이터를 저장하기 위해 바인드 변수를 선언한다.
variable 명령어를 사용하여 PL/SQL 블록에서도 사용할 수 있다.
저장 프로시저의 매개변수와 바인드 변수의 이름은 같을 필요는 없지만, 데이터 타입은 반드시 같아야 한다.
*/
variable vdname varchar2(30);
variable vloc varchar2(30);
--바인드 변수를 호출하는 저장 프로시저를 실행하고 바인드 변수는 :을 덧붙여 사용
execute dept_select(40, :vdname, :vloc);
--바인드 변수는 print 명령어로 출력할 수 있으므로 print 명령어로 출력
print vdname;
print vloc;
/

--사원정보를 조히하는 저장 프로시저 생성
--매개변수가 존재하는 저장 프로시저를 생성
create or replace procedure sel_empno (
sonempno in emp.empno%type,
sonename out emp.ename%type,
sonsal out emp.sal%type,
sonjob out emp.job%type)
is
begin
    select ename, sal, job into sonename, sonsal, sonjob
    from emp
    where empno = sonempno;
end;
/

--바인드 변수로 데이터를 저장하고 사원 번호로 사원정보를 조회
--컬럼에 저장된 값을 호스트 환경에서 생성하여 데이터를 저장하기 위해 바인드 변수를 선언
variable var_ename varchar2(15);
variable var_sal number;
variable var_job varchar2(9);
--바인드 변수를 호출하는 저장 프로시저를 실행하고 바인드 변수는 :을 덧붙여 사용
execute sel_empno(7369, :var_ename, :var_sal, :var_job);
--바인드 변수는 print 명령어로 출력할 수 있으므로 print 명령어로 출력
print var_ename;
print var_sal;
print var_job;
/

--dept 테이블에 데이터를 입력할 저장 프로시저를 생성
create or replace procedure dept_insert(
--in 모드로 dept 테이블의 deptno 컬럼을 입력한 값을 vdeptno 매개변수에 전달
vdeptno in dept.deptno%type,
--in 모드로 dept 테이블의 dname 컬럼에 입력한 값을 vdname 매개변수에 전달
vdname in dept.dname%type,
--in 모드로 dept 테이블의 loc 컬럼에 입력한 값을 vloc 매개변수에 전달
vloc in dept.loc%type)
is
begin
    insert into dept values(vdeptno, vdname, vloc);
end;
/

--dept 테이블에 데이터를 입력할 저장 프로시저 실행
--저장 프로시저로 데이터를 입력
execute dept_insert(41,'기획실','서울');
/

--dept 테이블에서 입력한 저장 프로시저 실행을 확인
select * from dept;
/

--dept 테이블에 테이터를 수정할 저장 프로시저를 생성
create or replace procedure dept_update(
-- in 모드로 dept 테이블의 deptno 컬럼에 입력한 값을 vdeptno 매개변수에 전달
vdeptno in dept.deptno%type,
-- in 모드로 dept 테이블의 dname 컬럼에 입력한 값을 vdname 매개변수에 전달
vdname in dept.dname%type,
-- in 모드로 dept 테이블의 loc 컬럼에 입력한 값을 vloc 매개변수에 전달
vloc in dept.loc%type)
is
begin 
    update dept set deptno = vdeptno, dname= vdname, loc= vloc
    where deptno = vdeptno;
end;
/

-- 저장 프로시저로 데이터를 수정한다.
execute dept_update(50, '기획실','부산');
/

--dept 테이블에서 수정한 저장 프로시저 실행 확인
select * from dept;
/

--dept 테이블에 데이터를 삭제할 저장 프로시저를 생성
create or replace procedure dept_delete(
-- in 모드로 dept 테이블의 deptno 컬럼에 입력한 값을 vdeptno 매개변수에 전달
vdeptno in dept.deptno%type)
is
begin
    delete from dept where deptno = vdeptno;
end;
/

--dept 테이블에 저장 프로시저로 데이터를 삭제
execute dept_delete(50);
/

--dept 테이블에서 삭제한 저장 프로시저 실행 확인
select * from dept;
/

--------------------------p.42
--사원의 급여에 200% 보너스를 지급하는 저장 함수를 생성
--매개변수가 존재하는 저장 함수를 생성
create or replace function cal_bonus(
--in 모드로 emp 테이블의 empno 컬럼에 입력한 값을 sonempno 매개변수에 전달
sonempno in emp.empno%type)
--number 데이터 타입의 값을 반환한다.
return number
is
    sonsal number(7,2);
begin
    select sal into sonsal
    from emp
    where empno = sonempno;
    -- 조회 결과로 얻어진 급여로 200% 보너스를 구해서 함수의 결과값으로 반환
    return(sonsal * 200);
end;
/

--바인드 변수로 데이터를 저장하고 급여를 조회
--컬럼에 저장된 값을 호스트 환경에서 생성하여 데이터를 저장하기 위한 바인드 변수를 선언
variable var_res number;
--바인드 변수를 호출하는 저장 함수를 실행하고 바인드 변수는 :을 덧붙여 사용
execute : var_res := cal_bonus(7369);
-- 바인드 변수는 print 명령어로 출력
print var_res;
/

--p.48
--dept 테이블의 모든 데이터를 조회할 프로시저 생성
create or replace procedure cursor_call
is 
-- %rowtype 속성으로 dept 테이블의 모든 컬럼을 참조하는 레퍼런스 sonemp 변수를 선언한다.
    sondept dept%rowtype;
    --soncursor 커서를 생성
    cursor soncursor
is
    select * from dept;
begin
    dbms_output.put_line('부서번호 부서명 지역명');
    dbms_output.put_line('--------------------------------------');
    -- 생성한 soncursor 커서를 연다.
    open soncursor;
    loop
        --soncursor 커서에서 행 정보를 획등하고 저장하고 다음행으로 이동
        fetch soncursor into sondept.deptno, sondept.dname, sondept.loc;
        --해당 커서안에 수행해야 할 데이터가 없을 떄 루프를 종료한다
        exit when soncursor%notfound;
        dbms_output.put_line(sondept.deptno||' '||sondept.dname||' '||sondept.loc);
        -- 제어권을 loop 문으로 전달한다.
    end loop;
    close soncursor;
end;
/
--저장 프로시저 실행을 확인
--화면 출력기능 활성화
set serverout on
-- 저장 프로시저를 실행하여 dept 테이블의 모든 컬럼을 출력한다.
execute cursor_call;
/

--p.51
--트리거 사용을 위한 테이블을 생성
--emp_son 테이블 생성
create table emp_son(
    empno number(4) primary key,
    ename varchar2(12),
    job varchar2(21));
    
--트리거 생성
create or replace trigger trg_son
--insert 문이 실행되고 난 후에 트리거르 실행한다.
after
--emp_son 테이블에 테이터가 입력할 떄 이벤트를 발생시킨다.
    insert on emp_son
begin
    dbms_output.put_line('신입사원이 입사했습니다.');
end;
/
                                                                                 
set serveroutput on
insert into emp_son values(1,'홍길동','대리');






















