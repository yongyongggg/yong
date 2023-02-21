# 데이터 가져오기
setwd('C:\\Rwork\\dataset4\\dataset4')
df <- read.csv("product.csv", header = TRUE)
library(SyncRNG)
v <- 1:nrow(df)
s <- SyncRNG(seed=42)
idx <- s$shuffle(v)[1:round(nrow(df)*0.7)]
idx[1:length(idx)]
train <- df[idx,]
test <- df[-idx,]

#모델 생성
train_lm <- lm(제품_만족도~제품_적절성,train)
train_lm
summary(train_lm)

#모델 평가
pred_lm <- predict(train_lm,newdata=test[,-1])
library(Metrics)
rmse(pred_lm,test[,3])
library(caret)
R2(pred_lm,test[,3])

#시각화
library(ggplot2)
ggplot(df,aes(x=제품_적절성,y=제품_만족도))+
  geom_count()+
  geom_point(color='blue')+
  stat_smooth(method='lm',color='red')

library(psych)
library(dplyr)
a=cor(train[,2],train[,3])
a**2
