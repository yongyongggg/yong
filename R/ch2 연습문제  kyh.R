######연습문제 2
###김용현

#문제1
#1)
Vec1 = rep('R',10) ; Vec1
#2)
Vec2 = seq(1,10,3) ; Vec2
#3)
Vec3 = rep(seq(1,10,3),3) ;Vec3
#4)
Vec4 =c(Vec2,Vec3) ;Vec4
#5)
seq(25,15,-5)
#6)
Vec5 = Vec4[seq(1,length(Vec4),2)] ;Vec5


#문제2
name <-c("최민수", "유관순", "이순신", "김유신", "홍길동")
age <-c(55, 45, 45, 53, 15) 
gender <-c(1, 2, 1, 1, 1) 
job <-c('연예인', '주부', '군인', '직장인', '학생')
sat <-c(3, 4, 2, 5, 5)
grade <-c('C', 'C', 'A', 'D', 'A')
total <- c(44.4, 28.5, 43.5, NA, 27.1)
#1)
user = data.frame(name,age,gender,job,sat,grade,total)
user
#2)
hist(user$gender)
#3)
user2 = user[seq(2,length(user),2),] ;user2

#문제3
Kor <- c(90, 85, 90)
Eng<- c(70, 85, 75)
Mat <- c(86, 92, 88)
#1)
Data = data.frame(Kor=Kor,Eng=Eng,Mat=Mat) ; Data
#2)
apply(Data,1,max) #행 방향
apply(Data,2,max) #열 방향
#3)
round(apply(Data,1,mean),digits = 2)
round(apply(Data,2,mean),digits = 2)
#4)
apply(Data,1,var) #분산
apply(Data,1,sd) #표준편차

#문제4
Data2 <- c('2017-02-05 수입3000원','2017-02-06 수입4500원','2017-02-07 수입2500원')
install.packages("stringr")
library(stringr)
#1)
str_extract(Data2,"[0-9]{4}[원]")
#2)
str_replace_all(Data2,'[0-9]{2,}','')
#3)
str_replace_all(Data2, '-', '/')
#4)
paste(Data2, collapse = ',')


