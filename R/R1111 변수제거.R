###########변수 제거 차원축소

install.packages("caret")
library(caret) 
install.packages("mlbench")
library(mlbench) 
nearZeroVar(iris, saveMetrics=TRUE)
data(Soybean)
head(Soybean)
# 0에 가까운 분산을 가지는 변수의 존재 여부 확인
nearZeroVar(Soybean, saveMetrics=TRUE)


#p.3 상관관계가 높은 변수 제거
library(caret) 
library(mlbench)
data(Vehicle)
head(Vehicle)
# 상관관계 높은 열 선정
findCorrelation(cor(subset(Vehicle, select=-c(Class))))
# 상관관계가 높은 열끼리 상관관계 확인
cor(subset(Vehicle, select=-c(Class))) [c(3,8,11,7,9,2), c(3,8,11,7,9,2)]
# 상관관계 높은 열 제거
Cor_Vehicle <- Vehicle[,-c(3,8,11,7,9,2)]
findCorrelation(cor(subset(Cor_Vehicle, select=-c(Class))))
head(Cor_Vehicle)


#p.5 카이제곱 검정을 통한 중요 변수 선발
install.packages('FSelector')
install.packages('randomForest')
library(randomForest)
library(FSelector)
library(rJava)
library(mlbench)

data(Vehicle)
#카이 제곱 검정으로 변수들의 중요성 평가
(cs <- chi.squared(Class ~., data=Vehicle))
#변수 중에서 중요한 5개 선별
cutoff.k(cs,5)
