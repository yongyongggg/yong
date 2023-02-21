########탐색적 데이터 분석
#김용현

#문제1
library(MASS)
data("Animals")
#1)
str(Animals)
#2)
summary(Animals$body)
#3)
mean(Animals$body)
#4)
sd(Animals$body)
#5)
table(Animals)

#문제2
data(iris)
install.packages("cvTools")
library(cvTools)
cross <- cvFolds(n = nrow(iris), K = 5, R = 3, type = "random")
head(cross)
r = 1:3
K = 1:5
for(j in r){
  for(i in K) {
    datas_idx <- cross$subsets[cross$which == i, j]
    cat('K = ', i,'r =',j, '검정데이터 \n')
    print(iris[datas_idx, ])
    
    cat('K = ', i,'r =',j, '훈련데이터 \n')
    print(iris[-datas_idx, ])
  }
}

#문제3
setwd('C:/Rwork/dataset2/dataset2')
data =read.csv("descriptive.csv", header = TRUE)
head(data)
#1)
data1 <- subset(data, data$cost >= 1 & data$cost <= 11)
cost <- data1$cost
mean(cost)
#2)
cost1 = sort(cost, decreasing = T)
head(cost1,10)
#3)
quantile(cost, 3/4)
#4)
data$Cost2[data$cost >= 1 & data$cost < 4] <- 1
data$Cost2[data$cost >= 4 & data$cost < 8] <- 2
data$Cost2[data$cost >= 8] <- 3
head(data,10)
head(data$Cost2,10)
#5)
pie(table(data$Cost2))

#문제4
data =read.csv("twomethod2.csv", header = TRUE)
head(data)
#1)
data1 <- subset(data, !is.na(score), c(method, score))
#2)
#귀무 가설 : 교육 방법에 따른 두 집단 간 시험 성적에 차이가 없다.
#대립 가설 : 교육 방법에 따른 두 집단 간 시험 성적에 차이가 있다.
#3)
#두 집단을 대상으로 평균 차이 검정을 통해서 두 집단의 평균이 같은지 또는 다른지를검정
#독립 표본평균 검정은 두 집단간 분산의 동질성 검증(정규성 검정)여부를 판정한 후
#정규분포이면 T-검정, 정규분포가 아니면 윌콕스(Wilcox)검정을 수행한다.
a <- subset(data1, method == 1)
b <- subset(data1, method == 2)
a1 <- a$score
b1 <- b$score
var.test(a1, b1)
#p-value=0.9951 > 0.05 이므로
#두 집단 간 분포의 모양이 동질적이다.
#t.test()함수 이용 두 집단 간 평균 차이를 검정한다.
#4)
t.test(a1, b1, altr = "two.sided", conf.int = TRUE, conf.level = 0.95)
#5)
#p-value=0.0411 < 0.05 이므로 귀무가설을 기각
#교육 방법에 따른 두 집단 간 시험 성적에 차이가 있다.