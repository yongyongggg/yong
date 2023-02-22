--간단한 메세지 출력
set serveroutput on;
begin
  dbms_output.put_line('안녕 PL/SQL');
end;
/
--스칼라 변수를 선언하고 변수값을 조회
--화면 출력기능 활성화
set serveroutput on;
--스칼라 변수를 선언
DECLARE
    sonno number(4);
    sonname varchar2(12);
--실행문을 시작
begin
    sonno := 1001;
    sonname := '홍길동';
    dbms_output.put_line(' 사번 이름');
    dbms_output.put_line(' -------------');
    dbms_output.put_line(' '|| sonno || ' ' || sonname);
--실행문 종료
end;
/
--PL/SQL 의 select 문으로 emp 테이블에서 사원번호와 이름을 조회
--화면 출력기능을 활성화한다.
set serveroutput on;
--레퍼런스 변수를 선언한다.
declare
    sonno emp.empno%type;
    sonname emp.ename%type;
--실행문 시작
begin
    select empno, ename into sonno, sonname
    from emp
    where ename = 'SMITH';
-- 화면에 출력
    dbms_output.put_line(' 사번 이름');
    dbms_output.put_line(' ---------------');
    dbms_output.put_line(' ' || sonno || ' ' || sonname);
-- 실행문을 종료
end;
/
--emp 테이블에서 직원의 커미션
set serveroutput on;
--레퍼런스 변수를 선언
declare
    sonemp emp%rowtype;
    sonsal number(7,2);
begin
    select * into sonemp
    from emp
    where ename='SMITH';
    --커미션이 null 일 경우 조건을 지정하고 수행
    if (sonemp.comm is null) then
    sonsal := sonemp.sal*12;
    --조건인 false 이거나 null 이면 수행을 종료
    end if;
    dbms_output.put_line(' 사번 이름 커미션');
    dbms_output.put_line('--------------------------');
    dbms_output.put_line(' '||sonemp.empno||' '||sonemp.ename||' '||sonsal);
end;
/
--emp 테이블에서 부서번호로 부서명 확인
set serveroutput on;
-- 레퍼런스 변수와 스칼라 변수를 선언
declare
    sonno emp.empno%type;
    sonname emp.ename%type;
    sondeptno emp.deptno%type;
    --sondname 변수를 null로 초기화
    sondname varchar2(20) := null;
begin
    select empno, ename, deptno
    into sonno, sonname, sondeptno
    from emp
    where empno = 7369;
    --sondeptno 변수가 10 일 경우를 조건에 지정
    if (sondeptno = 10) then
        sondname := 'accounting' ;
    end if;
    --sondeptno 변수가 20 일 경우를 조건에 지정하고 수행
    if (sondeptno = 20) then
        sondname :='clerk';
    end if;
    --sondeptno 변수가 30 일 경우를 조건에 지정하고 수행
    if (sondeptno = 30) then
        sondname := 'sales';
    end if;
    --sondeptno 변수가 40 일 경우를 조건에 지정하고 수행    
    if (sondeptno = 40) then
        sondname := 'operations';
    -- 조건이 false 이거나 null 이면 수행을 종료한다.
    end if;
    dbms_output.put_line(' 사번 이름 부서명');
    dbms_output.put_line(' ---------------------------');
    dbms_output.put_line(' '|| sonno ||' '||sonname||' '||sondname);
end;
/
--emp 테이블에서 사원명으로 연봉을 조회
set serveroutput on;
-- 레퍼런스 변수와 스칼라 변수를 선언한다.
declare
    sonemp emp%rowtype;
    sonsal number(7, 2);
begin
    select * into sonemp
    from emp
    where ename='SMITH';
    -- 커미션이 null 일 경우를 조건에 지정하고 수행한다.
    if (sonemp.comm is null) then
    sonsal := sonemp.sal*12;
    -- 커미션이 null 이 아닐 때 수행한다.
    else
    sonsal := sonemp.sal*12+sonemp.comm;
    -- 조건이 false 이거나 null 이면 수행을 종료한다.
    end if;
    dbms_output.put_line(' 사번 이름 연봉');
    dbms_output.put_line('--------------------------');
    dbms_output.put_line(' '||sonemp.empno||' '||sonemp.ename||' '||sonsal);
end;
/
--emp 테이블에서 부서번호로 부서명을 확인
set serveroutput on;
--레퍼런스 변수와 스칼라 변수를 선언
declare
    sonemp emp%rowtype;
    sondname varchar2(14);
begin
    select * into sonemp
    from emp
    where ename='SMITH';
    --sondeptno 변수가 10 일 경우를 조건에 지정하고 수행
    if (sonemp.deptno = 10) then
    sondname := 'accounting';
    --sondeptno 변수가 20 일 경우를 조건에 지정하고 수행
    elsif (sonemp.deptno = 20) then
        sondname := 'sales';
    --sondeptno 변수가 30 일 경우를 조건에 지정하고 수행
    elsif (sonemp.deptno = 30) then
        sondname := 'sales';
    --sondeptno 변수가 40 일 경우를 조건에 지정하고 수행   
    elsif (sonemp.deptno = 40) then
        sondname := 'operations';
    -- 조건이 false 이거나 null 이면 수행을 종료한다.
    end if;
    dbms_output.put_line(' 사번 이름 부서명');
    dbms_output.put_line(' ---------------------------');
    dbms_output.put_line(' '|| sonemp.empno ||' '||sonemp.ename||' '||sondname);
end;
/
--loop…end loop 문으로 1 부터 5 까지 출력
set serveroutput on;
declare
    num number := 1;
begin
    --end loop 문에서 제어권을 전달받고 반복
    loop
        dbms_output.put_line(num);
        --num  변수에 1을 더하여 num 변수에 할당하여 누적
        num := num + 1;
        if (num > 5) then
            exit;
        end if;
        --제어권을 loop문으로 전달한다.
    end loop;
end;
/
--for…end loop 문으로 1 부터 5 까지 출력
set serveroutput on;
declare
begin
    -- end loop 문에서 제어권을 전달받고 num 변수는 1 부터 5 까지 반복
    for num in 1..5 loop
        dbms_output.put_line(num);
    -- 제어권을 for…in 문의 num 변수로 전달
    end loop;
end;
/
--while...loop...end loop문으로 1부터 5까지 출력
set serveroutput on;
declare
    num number := 1;
begin
    -- end loop 문에서 제어권을 전달받고 num 변수는 5 이하까지 반복한다.
    while (num <= 5) loop
        dbms_output.put_line(num);
        -- num 변수에 1 을 더하여 num 변수에 할당하여 누적한다.
        num := num + 1;
        -- 제어권을 while…loop 문의 (num <= 5) 조건식에 전달한다.
    end loop;
end;


    
    
    
    
    
    
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
    