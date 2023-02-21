#####R CH13 연습문제
setwd("C:/Rwork/dataset2/dataset2 ")

#문제1
data <- read.csv("twomethod.csv", header = TRUE)
head(data)
result <- subset(data, !is.na(score), c(method, score))

a <- subset(result, method == 1)
b <- subset(result, method == 2)
a1 <- a$score
b1 <- b$score
var.test(a1, b1)

t.test(a1, b1, altr = "two.sided", conf.int = TRUE, conf.level = 0.95)
t.test(a1, b1, alter = "greater", conf.int = TRUE, conf.level = 0.95)
t.test(a1, b1, alter = "less", conf.int = TRUE, conf.level = 0.95)
#교육 방법에 따라 시험성적에 차이가 있다.

#문제2
data <- read.csv("two_sample.csv", header = TRUE)
head(data)
x <- data$gender
y <- data$surve
table(x)
table(y)
table(x, y, useNA = "ifany")

prop.test(c(138, 107), c(174, 126),alternative = "two.sided", conf.level = 0.95)
prop.test(c(138, 107), c(174, 126), alter = "greater", conf.level = 0.95)
prop.test(c(138, 107), c(174, 126), alter = "less", conf.level = 0.95)
#성별에 따라 만족도에 차이가 없다.

#문제3
data <- read.csv("student_height.csv", header = TRUE)
head(data)
height <- data$height
#평균
summary(height)
mean(height)
x1 <- na.omit(height)
shapiro.test(x1)
#정규분포를 따르지 않는다
par(mfrow = c(1, 2))
hist(x1)
t.test(x1, mu = 148.5)
qqnorm(x1)
qqline(x1, lty = 1, col = "blue")
t.test(x1, mu = 148.5, alter = "two.side", conf.level = 0.95)
#키에 차이가 없다

#문제4
#귀무가설 : 구매 비율에 차이가 없다
#연구가설 : 구매 비율에 차이가 있다
data <- read.csv("hdtv.csv", header = TRUE)
head(data)
x <- data$buy
install.packages("prettyR")
library(prettyR)
freq(x)
binom.test(10, 50, p = 0.15)
binom.test(c(10, 50), p=0.15, alternative= "greater", conf.level = 0.95)
binom.test(c(10, 50), p=0.15, alternative= "less", conf.level = 0.95)
#구매 비율에 차이가 없다.


