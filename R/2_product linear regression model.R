#1. 제품적절성이 제품만족도에 미치는 영향 주제로 R을 이용한 단순 선형 회귀분석을
#실시하고, 딥러닝 교재 3장에서 사용된 인공신경망을 이용한 선형 회귀분석을
#python으로 실행하여 결과를 비교하시오.
library(SyncRNG)
library(ggplot2)
library(caret)

#데이터 호출
df <- read.csv("product.csv")
summary(df)
str(df)
#분포 막대그래프
barplot(table(df$제품_만족도))
barplot(table(df$제품_적절성))
#모델생성
v <- 1:nrow(df)
s <- SyncRNG(seed=42)
idx <- s$shuffle(v)[1:round(nrow(df)*0.7)]

idx[1:length(idx)]
train <- df[idx,]
test <- df[-idx,]

m_lm<- lm(제품_만족도~제품_적절성, train)

