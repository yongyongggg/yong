##########R ch13 변수선택
install.packages('mlbench')
library(mlbench)
data('BostonHousing')
# 회귀
ss <- lm(medv ~ .,data=BostonHousing)
summary(ss)
# 전진선택
ss1 <- step(ss, direction = "forward")
formula(ss1)

# 회귀
ss <- lm(medv ~ .,data=BostonHousing)
# 후진제거
ss2 <- step(ss, direction = "backward")
formula(ss2)



#p.6 실습2 
data(attitude)
head(attitude)
# 회귀분석
model <- lm(rating~. , data=attitude)
# 수행결과
summary(model)
#독립변수 제거
reduced <- step(model, direction="backward")
summary(reduced)



#p.12 단계선택법
# 단계적 선택방법
library(mlbench)
data("BostonHousing")
# 회귀
ss <- lm(medv ~ .,data=BostonHousing)
# 단계적선택
ss3 <- step(ss, direction = "both")
formula(ss3)