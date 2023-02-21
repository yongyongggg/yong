########의사결정나무
#1단계: party패키지 설치
install.packages("party")
library(party)
#2단계: airquality 데이터셋 로딩
library(datasets)
str(airquality)
#3단계: formula생성
formula <- Temp ~ Solar.R + Wind + Ozone
#4단계: 분류모델 생성 – formula를 이용하여 분류모델 생성
air_ctree <- ctree(formula, data = airquality)
air_ctree
#5단계: 분류분석 결과
plot(air_ctree)


#p.3 학습데이터와 검정데이터 샘플링으로 분류분석 수행
#1단계: 학습데이터와 검정데이터 샘플링
set.seed(1234)
idx <- sample(1:nrow(iris), nrow(iris) * 0.7)
train <- iris[idx, ]
test <- iris[-idx, ]
#2단계: formula생성
formula <- Species ~ Sepal.Length + Sepal.Width + Petal.Length + Petal.Width
#3단계: 학습데이터 이용 분류모델 생성
iris_ctree <- ctree(formula, data = train)
iris_ctree
#4단계: 분류모델 플로팅
#4-1단계: 간단한 형식으로 시각화
plot(iris_ctree, type = "simple")
#4-2단계: 의사결정 트리로 결과 플로팅
plot(iris_ctree)
#5단계: 분류모델 평가
#5-1단계: 모델의 예측치 생성과 혼돈 매트릭스 생성
pred <- predict(iris_ctree, test)
a=table(pred, test$Species)
#5-2단계: 분류 정확도
diag(a)
(16 + 15 + 12) / nrow(test)


#p.5 K겹 교차 검정 샘플링으로 분류 분석하기
#1단계: k겹 교차 검정을 위한 샘플링
library(cvTools)
cross <- cvFolds(nrow(iris), K = 3, R = 2)
#2단계: K겹 교차 검정 데이터 보기
str(cross)
cross
length(cross$which)
dim(cross$subsets)
table(cross$which)
#3단계: K겹 교차 검정 수행
R = 1:2
K = 1:3
CNT = 0
ACC <- numeric()
for(r in R) {
  cat('\n R = ', r, '\n')
  for(k in K) {
    
    datas_ids <- cross$subsets[cross$which == k, r]
    test <- iris[datas_ids, ]
    cat('test : ', nrow(test), '\n')
    formual <- Species ~ .
    train <- iris[-datas_ids, ]
    cat('train : ', nrow(train), '\n')
    
    model <- ctree(Species ~ ., data = train)
    pred <- predict(model, test)
    t <- table(pred, test$Species)
    print(t)
    
    CNT <- CNT + 1
    ACC[CNT] <- (t[1, 1] + t[2, 2] + t[3, 3]) / sum(t)
  }
  
}
CNT
#4단계: 교차 검정 모델 평가
ACC
length(ACC)
result_acc <- mean(ACC, na.rm = T)
result_acc


#p.6 고속도로 주행거리에 미치는 영향변수 보기
#1단계: 패키지 설치 및 로딩
library(ggplot2)
data(mpg)
#2단계: 학습데이터와 검정데이터 생성
t <- sample(1:nrow(mpg), 120)
train <- mpg[-t, ]
test <- mpg[t, ]
dim(train)
dim(test)
#3단계: formula작성과 분류모델 생성
test$drv <- factor(test$drv)
formula <- hwy ~ displ + cyl + drv
tree_model <- ctree(formula, data = test)
plot(tree_model)


#p.7 Adultuci 데이터 셋을 이용한 분류분석
#1단계: 패키지 설치 및 데이터 셋 구조 보기
install.packages('arules')
library(arules)
data(AdultUCI)
str(AdultUCI)
names(AdultUCI)
#2단계: 데이터 샘플링
set.seed(1234)
choice <- sample(1:nrow(AdultUCI), 10000)
choice
adult.df <- AdultUCI[choice, ]
str(adult.df)
#3단계: 변수 추출 및 데이터프레임 생성
#3-1단계: 변수 추출
capital <- adult.df$`capital-gain`
hours <- adult.df$`hours-per-week`
education <- adult.df$`education-num`
race <- adult.df$race
age <- adult.df$age
income <- adult.df$income
#3-2단계: 데이터프레임 생성
adult_df <- data.frame(capital = capital, age = age, race = race,
                       hours = hours, education = education, income = income)
str(adult_df)
#4단계: formula생성 – 자본이득(capital)에 영향을 미치는 변수
formula <- capital ~ income + education + hours + race + age
#5단계: 분류모델 생성 및 예측
adult_ctree <- ctree(formula, data = adult_df)
adult_ctree
#6단계: 분류모델 플로팅
plot(adult_ctree)
#7단계: 자본이득(capital) 요약 통계량 보기
adultResult <- subset(adult_df,
                      adult_df$income == 'large' &
                        adult_df$education > 14)
length(adultResult$education)
summary(adultResult$capital)
boxplot(adultResult$capital)

#p.10 조건부추론나무
install.packages("party")
library(party)
# sampling
str(iris)
set.seed(1000)
sampnum <- sample(2, nrow(iris), replace=TRUE, prob=c(0.7,0.3))
sampnum
# training & testing data 구분
trData <- iris[sampnum==1,]
head(trData)
teData <- iris[sampnum == 2, ]
head(teData)
shortvar <- Species~Sepal.Length+Sepal.Width+Petal.Length+Petal.Width
# 학습
citreeResult <- ctree(shortvar, data=trData)
# 예측값과 실제값 비교
table(predict(citreeResult), trData$Species)
citreeResult2 <- ctree(shortvar, data=teData)
# 테스트 데이터를 이용하여 분류
forcasted2 <- predict(citreeResult2, data=teData)
# forcasted
# teData$Species
# 예측결과와 실제값 비교
table(forcasted2, teData$Species)
#시각화
plot(citreeResult2) 


#p.12 rpart패키지 이용 분류분석
#rpart()함수를 이용한 의사결정 트리 생성
#1단계: 패키지 설치 및 로딩
install.packages("rpart")
library(rpart)
install.packages("rpart.plot")
library(rpart.plot)
#2단계: 데이터 로딩
data(iris)
#3단계: rpart()함수를 이용한 분류분석
rpart_model <- rpart(Species ~ ., data = iris)
rpart_model
#4단계: 분류분석 시각화
rpart.plot(rpart_model)


#p.13
setwd('C://Rwork//dataset4//dataset4')
#실습 (날씨 데이터를 이용하여 비(rain)유무 예측
#1단계: 데이터 가져오기
weather = read.csv("weather.csv", header = TRUE)
#2단계: 데이터 특성 보기
str(weather)
head(weather)
#데이터셋 (weather 데이터 셋)
#366개 관측치, 15개의 변수
#3단계: 분류분석 데이터 가져오기
weather.df <- rpart(RainTomorrow ~ ., data = weather[ , c(-1, -14)], cp = 0.01)
#4단계: 분류분석 시각화
rpart.plot(weather.df)
#5단계: 예측치 생성과 코딩 변경
#5-1단계: 예측치 생성
weather_pred <- predict(weather.df, weather)
weather_pred
#5-2단계: y의 범주로 코딩 변환
weather_pred2 <- ifelse(weather_pred[ , 2] >= 0.5, 'Yes', 'No')
#6단계: 모델 평가
table(weather_pred2, weather$RainTomorrow)
(278 + 53) / nrow(weather)


#p.15 의사결정나무
# CART
install.packages("rpart")
library(rpart)
# 의사결정나무 생성
CARTTree <- rpart(Species~., data=iris)
CARTTree
# 의사결정나무 시각화
plot(CARTTree, margin=0.2)
text(CARTTree, cex=1)
# CARTTree를 이용하여 iris데이터 종 전체를 대상으로 예측
predict(CARTTree, newdata=iris, type="class")
# 결과 저장
predicted <- predict(CARTTree, newdata=iris, type="class")
# 예측정확도
  sum(predicted == iris$Species) / NROW(predicted)
# 실제값과 예측값의 비교
real <- iris$Species
table(real, predicted)
(50+49+45)/ nrow(iris)




























