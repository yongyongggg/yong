#######ch1 연습문제
####김용현

#문제 1
getwd()
setwd('c:/Temp')
getwd()

#문제 2
#1)
name <- '홍길동'
age <- 35
address <- '서울시'
name ; age ; address
#2)
mode(name) ; mode(age) ;mode(address)

#문제 3
#1)
ls(women)
#"height" "weight"의 모음이다.
#2)
mode(women) ;class(women)
#자료형은 list이고 자료구조는 data.frame이다.
#3)
plot(women)

#문제 4
#1)
data=c(1:100)
#2
mean(data)
