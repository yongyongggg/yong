#####R ch11 연습문제
##김용현

setwd("C:/Rwork/dataset2/dataset2 ")
#1
#1)
data <- read.csv("descriptive.csv", header = TRUE)
data <- subset(data, type == 1 | type == 2)
x <- table(data$type) ;x
par(mfrow = c(1, 2))
barplot(x)
pie(x)

data <- subset(data, pass == 1 | pass == 2)
x <- table(data$pass) ;x
barplot(x)
pie(x)

#2)
summary(data$age)
mean(data$age)
sd(data$age)
library(moments)
skewness(data$age)
kurtosis(data$age)
par(mfrow = c(1, 1))
hist(data$age,freq = F)
#왜도는 양수이기 때문에 오른쪽이 긴 꼬리를 가진다.
#첨도는 3보다 작기 때문에 정규분포보단 더 완만하다.

#3)
hist(data$age, freq = F)
lines(density(data$age), col = 'blue')
x=seq((mean(data$age)-5*sd(data$age)),(mean(data$age)+5*sd(data$age)),0.01)
curve(dnorm(x, mean(data$age), sd(data$age)), col = 'red', add = T)



#2
#1)
library(MASS)
data("Animals")

#2)
#(1)
dim(Animals)
#(2)
summary(Animals$brain)
#(3)
mean(Animals$brain)
#(4)
median(Animals$brain)
#(5)
sd(Animals$brain)
#(6)
var(Animals$brain)
#(7)
max(Animals$brain)
#(8)
min(Animals$brain)

