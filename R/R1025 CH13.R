######ch 13 집단간 차이분석

#.2
######우리나라 중학교 2학년 남학생의 평균 신장 표본 조사를 위한
# 검정 통계량은 다음과 같다.
# 전체 표본 크기(N): 10,000명
# 표본 평균(X): 165.1cm
# 표본 표준편차(S): 2cm
N = 10000
X = 165.1
S = 2
low <- X -1.96 * S / sqrt(N)
high <- X + 1.96 * S / sqrt(N)
low; high

#신뢰구간으로 표본오차 구하기
high - X
(low - X) * 100
(high - X) * 100


#p.4
# 귀무가설(H0): 기존 2019년도 고객 불만율과 2020년도 CS교육 후 불만율에 차이가 없다.
# 연구가설(H1): 기존 2019년도 고객 불만율과 2020년도 CS교육 후 불만율에 차이가 있다.
# 연구환경: 
# 2019년도 114 전화번호 안내고객을 대상으로 불만을 갖는 고객은 20%였다. 
# 이를개선하기 위해서 2020년도 CS교육을 실시한 후 150명 고객을 대상으로 조사한 결과
# 14명이 불만이 있었다. 기존 20%보다 불만율이 낮아졌다고 할 수 있는가?
setwd("C:/Rwork/dataset2/dataset2 ")
data <- read.csv("one_sample.csv", header = TRUE)
head(data)
x <- data$survey
#빈도수와 비율계산
summary(x)
length(x)
table(x)
# 패키지를 이용하여 빈도수와 비율 계산
install.packages("prettyR")
library(prettyR)
freq(x)

binom.test(14, 150, p = 0.2)
binom.test(14, 150, p = 0.2, alternative = "two.sided", conf.level = 0.95)

binom.test(c(14, 150), p = 0.2, alternative = "greater", conf.level = 0.95)

binom.test(c(14, 150), p = 0.2, alternative = "less", conf.level = 0.95)

#p.7
data <- read.csv("one_sample.csv", header = TRUE)
str(data)
head(data)
x <- data$time
head(x)
summary(x)
mean(x)
#데이터 분포 확인/결측치 제거
mean(x, na.rm = T)
x1 <- na.omit(x)
mean(x1)

#정규분포 검정
shapiro.test(x1)
par(mfrow = c(1, 2))
hist(x1)
t.test(x1, mu = 5.2)
qqnorm(x1)
qqline(x1, lty = 1, col = "blue")
t.test(x1, mu = 5.2, alter = "two.side", conf.level = 0.95)             
#방향성을 갖는 단측 가설 검정
t.test(x1, mu = 5.2, alter= "greater", conf.level = 0.95)
#귀무가설의 임계값 계산
qt(0.05, 108, lower.tail=F)



#p.13
data <- read.csv("two_sample.csv", header = TRUE)
head(data)
x <- data$method
y <- data$survey
table(x)
table(y)
table(x, y, useNA = "ifany")

prop.test(c(110, 135), c(150, 150),alternative = "two.sided", conf.level = 0.95)
prop.test(c(110, 135), c(150, 150), alter = "greater", conf.level = 0.95)
prop.test(c(110, 135), c(150, 150), alter = "less", conf.level = 0.95)


#p.15
data <- read.csv("two_sample.csv", header = TRUE)
head(data)
summary(data)
result <- subset(data, !is.na(score), c(method, score))

a <- subset(result, method == 1)
b <- subset(result, method == 2)
a1 <- a$score
b1 <- b$score
length(a1)
length(b1)
mean(a1)
mean(b1)
var.test(a1, b1)

t.test(a1, b1, altr = "two.sided", conf.int = TRUE, conf.level = 0.95)
t.test(a1, b1, alter = "greater", conf.int = TRUE, conf.level = 0.95)
t.test(a1, b1, alter = "less", conf.int = TRUE, conf.level = 0.95)

#p.19
data <- read.csv("paired_sample.csv", header = TRUE)

result <- subset(data, !is.na(after), c(before, after))
x <- result$before
y <- result$after
x; y
length(x)
length(y)
mean(x)
mean(y)

var.test(x, y, pared = TRUE)

t.test(x, y, paired = TRUE,alter = "two.sided", conf.int = TRUE, conf.level = 0.95)


t.test(x, y, paired = TRUE, alter = "greater",conf.int = TRUE, conf.level = 0.95)
t.test(x, y, paired = TRUE, alter = "less",conf.int = TRUE, conf.level = 0.95)






