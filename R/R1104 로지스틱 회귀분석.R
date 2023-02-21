##########################################
######로지스틱 회귀분석
setwd("C:/Rwork/dataset4/dataset4")
#실습 (날씨 관련 요인 변수로 비(rain) 유무 예측)
install.packages("ROCR")
library(car)
library(lmtest)
library(ROCR)
#1단계: 데이터 가져오기
weather = read.csv("weather.csv", stringsAsFactors = F)
dim(weather)
head(weather)
str(weather)
#2단계: 변수 선택과 더미 변수 생성
weather_df <- weather[ , c(-1, -6, -8, -14)]
str(weather_df)
weather_df$RainTomorrow[weather_df$RainTomorrow == 'Yes'] <- 1
weather_df$RainTomorrow[weather_df$RainTomorrow == 'No'] <- 0
weather_df$RainTomorrow <- as.numeric(weather_df$RainTomorrow)
head(weather_df)
#3단계: 학습데이터와 검정데이터 생성(7:3비율)
idx <- sample(1:nrow(weather_df ), nrow(weather_df) * 0.7)
train <- weather_df[idx, ]
test <- weather_df[-idx, ]
#4단계: 로지스틱 회귀모델 생성
weather_model <- glm(RainTomorrow ~ ., data = train, family = 'binomial', na.action=na.omit)
weather_model
summary(weather_model)
#5단계: 로지스틱 회귀모델 예측치 생성
pred <- predict(weather_model, newdata = test, type = "response")
pred
result_pred <- ifelse(pred >= 0.5, 1, 0)
result_pred
table(result_pred)
#6단계: 모델평가 – 분류정확도 계산
table(result_pred, test$RainTomorrow)
#7단계: ROC(Receiver Operating Characteristic) 
#Curve를 이용한 모델 평가
pr <- prediction(pred, test$RainTomorrow)
prf <- performance(pr, measure = "tpr", x.measure = "fpr")
plot(prf)



data(mtcars) # mtcar datset 사용을 위한 코드
dat <- subset(mtcars, select=c(mpg, am, vs)) 
dat
log_reg <- glm(vs ~ mpg, data=dat, family= 'binomial') 
log_reg
summary(log_reg)











