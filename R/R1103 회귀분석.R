########R 회귀분석
setwd("C:/Rwork/dataset2/dataset2")
#p.4 단순 선형 회귀분석
product <- read.csv("product.csv", header = TRUE)
str(product)
#2단계: 독립변수와 종속변수 생성
y = product$제품_만족도
x = product$제품_적절성
df <- data.frame(x, y)
#3단계: 단순 선형회귀 모델 생성
result.lm <- lm(formula = y ~ x, data = df)
#4단계: 회귀분석의 절편과 기울기
result.lm
#5단계: 모델의 적합값과 잔차 보기
names(result.lm)
#5-1단계: 적합값 보기
fitted.values(result.lm)[1:2]
#5-2단계: 관측값 보기
head(df, 1)
#5-3단계: 회귀방정식을 적용하여 모델의 적합값 계산
Y = 0.7789 + 0.7393 * 4;Y
#5-4단계: 잔차(오차) 계산
3 - 3.735963
#5-5단계: 모델의 잔차 보기
residuals(result.lm)[1:2]
#5-6단계: 모델의 잔차와 회귀방정식에 의한 적합값으로부터 관측값 계산
-0.7359630 + 3.735963

#p.6 선형 회귀분석 모델 시각화
#1단계: xy 산점도
plot(formula = y ~ x, data = product)
#2단계: 선형 회귀모델 생성
result.lm <- lm(formula = y ~ x, data = product)
#3단계: 회귀선
abline(result.lm, col = "red")

summary(result.lm)
#1에 가까울수록 설명변수(독립변수)가 설명을 잘한다 라고 판단


#p.7 다중회귀 분석
#1단계: 변수 모델링
y = product$제품_만족도
x1 = product$제품_친밀도
x2 = product$제품_적절성
df <- data.frame(x1, x2, y)
#2단계: 다중 회귀분석
result.lm <- lm(formula = y ~x1 + x2, data = df)
result.lm

#1단계: 패키지 설치
install.packages('car')
library(car)
#car 패키지
#2단계: 분산팽창요인(VIF)
vif(result.lm)
#실습 (다중 회귀분석 결과보기)
summary(result.lm)



#p.9
#실습 (다중 공선성 문제 확인)
#1단계: 패키지 설치 및 데이터 로딩
install.packages("car")
library(car)
data(iris)
#2단계: iris 데이터 셋으로 다중 회귀분석
model <- lm(formula = Sepal.Length ~ Sepal.Width + 
              Petal.Length + Petal.Width, data = iris)
vif(model)
sqrt(vif(model)) > 2
#3단계: iris 변수 간의 상관계수 구하기
cor(iris[ , -5])
#실습 (데이터 셋 생성과 회귀모델 생성)
#1단계: 학습데이터와 검정데이터 표본 추출
x <-sample(1:nrow(iris), 0.7 * nrow(iris))
train <- iris[x, ]
test <- iris[-x, ]
#2단계: 변수 제거 및 다중 회귀분석
model <- lm(formula = Sepal.Length ~ Sepal.Width + Petal.Length, data = train)
model
summary(model)


#p.11 실습 (회귀방정식 도출)
#1단계: 회귀방정식을 위한 절편과 기울기 보기
mode
#2단계: 회귀방정식 도출
head(train, 1)
Y = 2.3826 + 0.5684 * 2.9 + 0.4576 * 4.6
Y
6.6 - Y
#검정데이터를 이용하여 회귀모델의 예측치를 생성.
#학습데이터에 의해 생성된 회귀모델을 검정데이터에 적용하여 모델의 예측치를 생성
pred <- predict(model, test)
pred
#실습 (상관계수를 이용한 회귀모델 평가)
cor(pred, test$Sepal.Length)

#p.13 기본 가정 충족으로 회귀분석 수행
#1: 회귀모델 생성
#1-1단계: 변수 모델링
formula = Sepal.Length ~ Sepal.Width + Petal.Length + Petal.Width
#1-2단계: 회귀모델 생성
model <- lm(formula = formula, data = iris)
model
#2단계: 잔차(오차)분석
#2-1단계: 독립성 검정 – 더빈 왓슨 값으로 확인
install.packages('lmtest')
library(lmtest)
dwtest(model)
#2-2단계: 등분산성 검정 – 잔차와 적합값의 분포
plot(model, which = 1)
#2-3단계: 잔차의 정규성 검정
attributes(model)
res <- residuals(model)
shapiro.test(res)
par(mfrow = c(1, 2))
hist(res, freq = F)
qqnorm(res)
#3단계: 다중 공선성 검사
library(car)
sqrt(vif(model)) > 2
#4단계: 회귀모델 생성과 평가
formula = Sepal.Length ~ Sepal.Width + Petal.Length
model <- lm(formula = formula, data = iris)
summary(model)