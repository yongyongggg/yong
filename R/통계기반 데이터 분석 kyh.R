########통계 기반 데이터 분석
####김용현

#문제1
#1)
getwd()
data <- read.csv('response.csv',header = T)
head(data)
#2)
data$job[data$job == 1] <- '1:학생'
data$job[data$job == 2] <- '2:직장인'
data$job[data$job == 3] <- '3:주부'
data$response[data$response == 1] <- '1:무응답'
data$response[data$response == 2] <- '2:낮음'
data$response[data$response == 3] <- '3:높음'
#3)
job <- data$job
response <- data$response
table(job, response, useNA = "ifany")
#4)
chisq.test(job, response)
#5)
#p-value = 6.901e-12 < 0.05 이므로
#직업 유형에 따라 응답 정도에 차이가 있다.


#문제2
#1)
data('attitude')
head(attitude)
#2)
model <- lm(rating~.,data=attitude)
#3)
summary(model)
#p-value가 <0.05이므로 통계적으로 유의하다.
#수정결정계수는 0.6628
#변수 중 통계적으로 유의한 것은 complaints, learning 2개이다.
#4)
reduced <- step(model, direction="backward")
summary(reduced)
#p-value가 < 0.05 이므로 통계적으로 의미가 있다.
#5)
formula(reduced)
# Y= 9.8709 + 0.6435X1 + 0.2112X2

#문제3
#1)
data <- read.csv('cleanData.csv',header = T)
head(data)
#2)
x <- data$position
y <- data$age3 
#3)
plot(x,y)
#4)
library(gmodels)
CrossTable(x,y,chisq=T)
#5)
#p-value < 0.05이므로 통계적으로 의미가 있다.
#나이와 직위간 관련성이 있다.


#문제4
#1)
data('mtcars')
head(mtcars)
dat <- subset(mtcars, select=c(mpg, am, vs))
head(dat)
#2)
log_reg <- glm(vs ~ mpg, data=dat, family='binomial')
log_reg
#3)
summary(log_reg)
#4)
formula(log_reg)
# Y= -8.8331+ 0.4304X1
#5)
#e^(-8.8331 + 0.4304 * 30) = 59.0804456029

#문제5)
#1) (a)값 = 72.00144
#2) (b)값 = 2
#3) (c)값 = 36.00072
#4) (d)값 = 30.0006
#5) (e)값 = 9
#6) (f)값 = 102.002
#7) (g)값 = 11
#풀이과정
# (b) = K-1 = 3-1 = 2
# (e) = n-k = 12-3 = 9
# (g) = n-1 = 12-1 = 11
# (c) = 10.8 / 3.3334 = 36.00072
# (a) = (b)*(c) = 2*36.00072 = 72.00144
# (d) = (e)*3.3334 = 9*3.3334 = 30.0006
# (f) = (a)+(d) = 72.00144+30.0006 = 102.002








