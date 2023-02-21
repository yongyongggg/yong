install.packages('rJava')
install.packages('DBI')
install.packages('RJDBC')
library(rJava)
library(DBI)
library(RJDBC)
Sys.setenv(JAVA_HOME = "C://Program Files//Java//jdk1.8.0_202")

drv <- JDBC("oracle.jdbc.driver.OracleDriver", "C:/oraclexe/app/oracle/product/11.2.0/server/jdbc/lib/ojdbc6.jar")
conn <- dbConnect(drv,"jdbc:oracle:thin:@//127.0.0.1:1521/xe", "scott", "tiger")
query = "SELECT * FROM test_table"
dbGetQuery(conn, query)
#나이 기준 내림차순
query = "SELECT * FROM test_table order by age desc"
dbGetQuery(conn, query)
# insert record
query = "insert into test_table values('kang', '1234', '강감찬', 45)"
dbSendUpdate(conn, query)
# 추가 확인
query = "SELECT * FROM test_table"
dbGetQuery(conn, query)
# 나이가 40세 이상인 record 
query = "select * from test_table where age >= 40"
result <- dbGetQuery(conn, query)
result
# name이 '강감찬'인 데이터의 age를 40으로 수정
query = "update test_table set age = 40 where name = '강감찬'"
dbSendUpdate(conn, query)
# 수정된 레코드 조회
query = "select * from test_table where name = '강감찬'"
dbGetQuery(conn, query)
# name이 '홍길동'인 레코드 삭제
query = "delete from test_table where name = '홍길동'"
dbSendUpdate(conn, query)
# 전체 레코드 조회
query = "select * from test_table"
dbGetQuery(conn, query)
