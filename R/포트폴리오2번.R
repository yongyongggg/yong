#########문제2
library(car)
library(lmtest)
library(ROCR)

#1단계: 데이터 가져오기
setwd('C:\\Rwork\\dataset4\\dataset4')
weather = read.csv("weather.csv", stringsAsFactors = F)
dim(weather)
head(weather)
str(weather)

#2단계: 변수 선택과 더미 변수 생성
weather_df <- weather[ , c(-1,-6, -8, -14)]
str(weather_df)
weather_df$RainTomorrow[weather_df$RainTomorrow == 'Yes'] <- 1
weather_df$RainTomorrow[weather_df$RainTomorrow == 'No'] <- 0
weather_df$RainTomorrow <- as.numeric(weather_df$RainTomorrow)
head(weather_df)
#weather_df<-na.omit(weather_df)
library(caret)
p<-preProcess(weather_df,"range") 
df<-predict(p, weather_df)

#3단계: 학습데이터와 검정데이터 생성(7:3비율)
library(SyncRNG)
v <- 1:nrow(df)
s <- SyncRNG(seed=42)
idx <- s$shuffle(v)[1:round(nrow(df)*0.7)]
idx[1:length(idx)]
train <- df[idx,]
test <- df[-idx,]

#4단계: 로지스틱 회귀모델 생성
weather_model <- glm(RainTomorrow ~ ., data = train, family = 'binomial',na.action=na.omit)
weather_model
summary(weather_model)
sqrt(vif(weather_model))>3

m_glm=step(weather_model, direction = "backward")
  

#5단계: 로지스틱 회귀모델 예측치 생성
pred <- predict(m_glm, newdata = test, type = "response")
pred
result_pred <- ifelse(pred >= 0.5, 1, 0)
result_pred
table(result_pred)

table(result_pred, test$RainTomorrow)

pr <- prediction(pred, test$RainTomorrow)
prf <- performance(pr, measure = "tpr", x.measure = "fpr")
plot(prf)










#문제3
df = iris
library(SyncRNG)
v <- 1:nrow(df)
s <- SyncRNG(seed=42)
idx <- s$shuffle(v)[1:round(nrow(df)*0.7)]
idx[1:length(idx)]
train <- df[idx,]
test <- df[-idx,]
library(randomForest)
m_rf<-randomForest(Species~.,train,ntree=200)
p_rf<-predict(m_rf, test[,-5])
p_rf
plot(m_rf)
varImpPlot(m_rf)







