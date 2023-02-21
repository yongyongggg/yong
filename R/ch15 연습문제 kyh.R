#######R ch15 연습문제
#####김용현

#문제1
setwd("C:/Rwork/dataset2/dataset2")
product <- read.csv("product.csv", header = TRUE)
head(product)
#1)
x <-sample(1:nrow(product), 0.7 * nrow(product))
train <- product[x, ]
test <- product[-x, ]
#2)
model <- lm(formula =제품_만족도~ 제품_적절성+ 제품_친밀도,
            data= train)
model
#3)
pred <- predict(model, test)
pred
#4)
cor(pred, test$제품_만족도)


#문제2
install.packages('ggplot2')
library(ggplot2)
data("diamonds")
diamonds
model <- lm(formula = price~ carat+table+depth, data=diamonds)
model
summary(model)
#price에 carat은 정의 관계이고
#table과 depth는 부의 관계를 가진다.
install.packages("lm.beta")
library(lm.beta)
lm.beta(model)
