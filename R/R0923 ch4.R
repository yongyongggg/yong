##########R ch4
#p.1
num1 <- 100
num2 <- 20
result <- num1 + num2
result
result <- num1 - num2
result
result <- num1 * num2
result
result <- num1 / num2
result
result <- num1 %% num2
result
result <- num1 ^ 2
result
result <- num1 ^ num2
result

boolean <- num1 == num2
boolean
boolean <- num1 != num2
boolean
boolean <- num1 > num2
boolean
boolean <- num1 >= num2
boolean
boolean <- num1 < num2
boolean
boolean <- num1 <= num2
boolean

logical <- num1 >= 50 & num2 <= 10
logical
logical <- num1 >= 50 | num2 <= 10
logical
logical <- num1 >= 50
logical
logical <= !(num1 >= 50)
logical
x <- TRUE; y <- FALSE
xor(x, y)

#p.4
x <- 50; y <- 4; z <- x * y
if(x * y >= 40) {
  cat("x * y의 결과는 40이상입니다.\n")
  cat("x * y = ", z)
} else {
  cat("x * y의 결과는 40미만입니다. x * y = ", z, "\n")
}

score <- scan()
score
result <- "노력"
if(score >= 80) {
  result <- "우수"
}
cat("당신의 학점은 ", result, score)

score <- scan()
if(score >= 90) {
  result = "A학점"
} else if(score >= 80) {
  result = "B학점"
} else if(score >= 70) {
  result = "C학점"
} else if(score >= 60) {
  result = "D학점"
} else {
  result = "F학점"
}
cat("당신의 학점은", result)
print(result)


score <- scan()
ifelse(score >= 80, "우수", "노력")
ifelse(score <= 80, "우수", "노력")

getwd()
setwd("C:/Rwork/dataset1/dataset1")
excel <- read.csv("excel.csv", header = T)
q1 <- excel$q1
q1
ifelse(q1 >= 3, sqrt(q1), q1)

ifelse(q1 >= 2 & q1 <= 4, q1 ^ 2, q1)

#p.7
empname <- scan(what = "")
empname
switch(empname,hong = 250,lee = 350,kim = 200, kang = 400)

name <- c("kim", "lee", "choi", "park")
which(name == "choi")

no <- c(1:5)
name <- c("홍길동", "이순신", "강감찬", "유관순", "김유신")
score <- c(85, 78, 89, 90, 74)
exam <- data.frame(학번 = no, 이름 = name, 성적 = score)
exam
which(exam$이름 == "유관순")
exam[4, ]

i <- c(1:10)
for(n in i) {
  print(n * 10)
  print(n)
}

i <- c(1:10)
for(n in i)
  if(n %% 2 == 0) print(n)

i <- c(1:10)
for(n in i) {
  if(n %% 2 == 0) {
    next
  } else {
    print(n)
  }
}

name <- c(names(exam))
for(n in name) {
  print(n)
}

score <- c(85, 95, 98)
name <- c("홍길동", "이순신", "강감찬")
i <- 1
for(s in score) {
  cat(name[i], " -> ", s, "\n")
  i <- i + 1
}

i = 0
while(i < 10) {
  i <- i + 1
  print(i)
}

f1 <- function() {
  cat("매개변수가 없는 함수")
}
f1()

f3 <- function(x, y) {
  add <- x + y
  return(add)
}
add <- f3(10, 20)
add

#p.13
test <- read.csv("test.csv", header = TRUE)
head(test)

summary(test)
table(test$A)

data_pro <- function(x) {
  for(idx in 1:length(x)){
    cat(idx,'번째 칼럼의 빈도분석 결과')
    print(table(x[idx]))
    cat
  }
  for(idx in 1:length(x)){
    f <-table(x[idx])
    cat(idx,'번째 칼럼의 최대값/최소값\n')
    cat('max =',max(f),'min =',min(f))
  }
}

data_pro(test)

x <- c(7, 5, 12, 9, 15, 6)
var_sd <- function(x) {
  var <- sum((x - mean(x)) ^ 2) / (length(x) - 1)
  sd <- sqrt(var)
  cat("표본분산: ", var, "\n")
  cat("표본표준편차: ",sd)
}
var_sd(x)

pytha <- function(s, t) {
  a <- s ^ 2 - t ^ 2
  b <- 2 * s * t
  c <- s ^ 2 + t ^ 2
  cat("피타고라스 정리: 3개의 변수: ", a, b, c)
}
pytha(2, 1)


gugu <- function(i,j) {
  for(x in i){
    cat('**',x,'단**\n')
    for(y in j){
      cat(x,'*',y,'=',x*y,'\n')
    }
    cat('\n')
  }
}

i <- c(2:9)
j <- c(1:9)
gugu(i,j)


#p.16
data <- c(10, 20, 5, 4, 40, 7, NA, 6, 3, NA, 2, NA)
na <- function(x) {
  print(x)
  print(mean(x, na.rm = T))
  data = ifelse(!is.na(x), x, 0)
  print(data)
  print(mean(data))
  data2 = ifelse(!is.na(x), x, round(mean(x, na.rm = TRUE), 2))
  print(data2)
  print(mean(data2))
}
na(data)















