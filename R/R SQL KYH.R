#분석용 데이터 구축 평가
#김용현

#문제2
install.packages('rJava')
install.packages('DBI')
install.packages('RJDBC')
library(rJava)
library(DBI)
library(RJDBC)
Sys.setenv(JAVA_HOME = "C://Program Files//Java//jdk1.8.0_202")

drv <- JDBC("oracle.jdbc.driver.OracleDriver", "C:/oraclexe/app/oracle/product/11.2.0/server/jdbc/lib/ojdbc6.jar")
conn <- dbConnect(drv,"jdbc:oracle:thin:@//127.0.0.1:1521/xe", "scott", "tiger")


#문제3
query = "SELECT * FROM exam_table"
dbGetQuery(conn, query)

#문제4
query = "INSERT INTO EXAM_TABLE VALUES('1005', '2345', 'Jung', 95)"
dbGetQuery(conn, query)
query = "INSERT INTO EXAM_TABLE VALUES('1006', '4567', 'Kang', 80)"
dbGetQuery(conn, query)

#문제5
query = "SELECT * FROM exam_table"
dbGetQuery(conn, query)

#문제6
query = "SELECT * FROM EXAM_TABLE ORDER BY SCORE DESC"
dbGetQuery(conn, query)

#문제7
query = "UPDATE EXAM_TABLE SET SCORE = 80 WHERE NAME = 'Choi'"
dbSendUpdate(conn, query)

#문제8
query = "SELECT * FROM EXAM_TABLE WHERE SCORE > 80"
result <- dbGetQuery(conn, query) ; result

#문제9
query = "DELETE FROM EXAM_TABLE WHERE NAME = 'Kang'"
dbSendUpdate(conn, query)

#문제10
query = "SELECT * FROM EXAM_TABLE"
dbGetQuery(conn, query)