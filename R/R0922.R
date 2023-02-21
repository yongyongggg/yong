######ch2
#p.2
c(1:20)
1:20
c(1, 2, 3, 4, 5)
seq(1, 10, 2)
rep(1:3, 3)
rep(1:3, each = 3)
#p.4
x <- c(1, 3, 5, 7)
y <- c(3, 5)
union(x, y)
setdiff(x, y)
intersect(x, y)
          
v1 <- c(33, -5, 20:23, 12, -2:3)
v2 <- c("홍길동", "이순신", "유관순")
v3 <- c(T, TRUE, FALSE, T, TRUE, F, T)
v1; v2; v3
v4 <- c(33, 05, 20:23, 12, "4")
v4
v1; mode(v1); class(v1)
v2; mode(v2); class(v2)
v3; mode(v3); class(v3)

#p.5
age <- c(30, 35, 40)
age
names(age) <- c("홍길동", "이순신", "강감찬")
age
age <- NULL

a <- c(1:50)
a[10:45]
a[19: (length(a) - 5)]

v1 <- c(13, -5, 20:23, 12, -2:3)
v1[1]
v1[c(2, 4)]
v1[c(3:5)]
v1[c(4, 5:8, 7)]

v1[-1]; v1[-c(2, 4)]; v1[-c(2:5)]; v1[-c(2, 5:10, 1)]

rm(list=ls())

#p.8
m <- matrix(c(1:5));m
m <- matrix(c(1:10), nrow = 2);m
m <- matrix(c(1:11), nrow = 2);m
m <- matrix(c(1:10), nrow = 2, byrow = T);m

#p.10
x1 <- c(m, 40, 50:52)
x2 <- c(30, 5, 6:8)
mr <- rbind(x1, x2);mr
mc <- cbind(x1, x2);mc

#p.11
m3 <- matrix(10:19, 2)
m4 <- matrix(10:20, 2)
m3
mode(m3) ;class(m3)
mode(m4) ;class(m4)

m3[1, ]
m3[ , 5]
m3[2, 3]
m3[1, c(2:5)]

x <- matrix(c(1:9), nrow = 3, ncol = 3);x
apply(x, 1, max)
apply(x, 1, min)
apply(x, 2, mean)

#p.13
f <- function(x) {
  x * c(1, 2, 3)
}
result <- apply(x, 1, f)
result
result <- apply(x, 2, f)
result

colnames(x) <- c("one", "two", "three")
x

#p.14
vec <- c(1:12)
arr <- array(vec, c(3, 2, 2))
arr

install.packages('RSADBE')
library(RSADBE)
data("Bug_Metrics_Software")
str(Bug_Metrics_Software)

#p.16
no <- c(1, 2, 3)
name <- c("hong", "lee", "kim")
pay <- c(150, 250, 300)
vemp <- data.frame(No = no, Name = name, Pay = pay)
vemp

m <- matrix(c(1, "hong", 150,172, "lee", 250,3, "kim", 300), 3, by = T)
memp <- data.frame(m)
memp

setwd('dataset1/dataset1')
getwd()
txtemp <- read.table('emp.txt', header = 1, sep = "")
txtemp

csvtemp <- read.csv('emp.csv', header = T)
csvtemp
help(read.csv)
name <- c("사번", "이름", "급여")
read.csv('emp2.csv', header = F, col.names = name)

df <- data.frame(x = c(1:5), y = seq(2, 10, 2), z = c('a', 'b', 'c', 'd', 'e'));df
df$x


#p.19
str(df)
ncol(df)
nrow(df)
names(df)
df[c(2:3), 1]
summary(df)
apply(df[ , c(1, 2)], 2, sum)

x1 <- subset(df, x >= 3);x1

y1 <-subset(df, y<=8);x1
xyand <- subset(df, x<=2 & y <=6);xyand
xyor <- subset(df, x<=2 | y <=0);xyor

sid = c("A", "B", "C", "D")
score = c(90, 80, 70, 60)
subject = c("컴퓨터", "국어국문", "소프트웨어", "유아교육")
student <- data.frame(sid, score, subject) ;student

mode(student); class(student)
str(sid); str(score); str(subject)
str(student)

#p.21
height <- data.frame(id = c(1, 2), h = c(180, 175)) ;height
weight <- data.frame(id = c(1, 2), w = c(80, 75)) ; weight

user <- merge(height, weight, by.x = "id", by.y = "id");user

#p.22
install.packages("UsingR")
library(UsingR)
data(galton)
str(galton)
dim(galton)
head(galton,15)

list <- list("lee","이순신",95)
list

unlist <-  unlist(list);unlist

num <- list(c(1:5),c(6:10)) ; num

#p.25
member <- list(name = c("홍길동", "유관순"), age = c(35, 25),
               address = c("한양", "충남"), gender = c("남자", "여자"),
               htype = c("아파트", "오피스텔"))

member
member$name
member$name[1]
member$name[2]

member$age[1] <- 45
member$id <- "hong"
member$pwd <- "1234"
member
member$age <- NULL
member
length(member)
mode(member); class(member)

#p.26
a <- list(c(1:5))
b <- list(c(6:10))
lapply(c(a, b), max)
sapply(c(a, b), max)

#p.27
multi_list <- list(c1 = list(1, 2, 3),c2 = list(10, 20, 30), c3 = list(100, 200, 300))
multi_list$c1; multi_list$c2; multi_list$c3
do.call(cbind, multi_list)
class(do.call(cbind, multi_list))

#p.28
install.packages("stringr")
library(stringr)
str_extract("홍길동35이순신45유관순25", "[1-9]{2}")
str_extract_all("홍길동35이순신45유관순25", "[1-9]{2}")
str_extract("홍길동35이순신45유관순25", "[1-9]{2}")
   
#p.29   
string <- "hongkd105leess1002you25강감찬2005"
str_extract_all(string, "[a-z]{3}")
str_extract_all(string, "[a-z]{3,}")
str_extract_all(string, "[a-z]{3,5}")

str_extract(string, "hong") 
str_extract(string, "35") 
str_extract(string, "[가-힣]{3}") 
str_extract_all(string, "[a-z]{3}") 
str_extract_all(string, "[0-9]{4}")

str_extract_all(string, "[^a-z]")
str_extract_all(string, "[^a-z]{4}")
str_extract_all(string, "[^가-힣]{5}")
str_extract_all(string, "[^0-9]{3}")

jumin <- "123456-1234567"
str_extract(jumin, "[0-9]{6}-[1234][0-9]{6}")
str_extract_all(jumin, "\\d{6}-[1234]\\d{6}")

name <- "홍길동1234,이순신5678,강감찬1012"
str_extract_all(name, "\\w{7,}")

#p.31
string <- "hongkd105leess1002you25강감찬2005"
len <- str_length(string) ;len

string <- "hongkd105leess1002you25강감찬2005"
str_locate(string, "강감찬")

string_sub <- str_sub(string, 1, len - 7)
string_sub
string_sub <- str_sub(string, 1, 23)
string_sub

ustr <- str_to_upper(string_sub); ustr
str_to_lower(ustr)

string_sub
string_rep <- str_replace(string_sub, "hongkd105", "홍길동35,")
string_rep <- str_replace(string_rep, "leess1002", "이순신45,")
string_rep <- str_replace(string_rep, "you25", "유관순25,")
string_rep

string_rep
string_c <- str_c(string_rep, "강감찬55")
string_c

string_c
string_sp <- str_split(string_c, ",")
string_sp

#p.33
string_vec <- c("홍길동35", "이순신45", "유관순25", "강감찬55")
string_vec

string_join <- paste(string_vec, collapse = ",")
string_join


















