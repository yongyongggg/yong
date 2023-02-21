######### 서포트백터머신

# SVM
#
setwd('C://Rwork//dataset4//dataset4')
credit1 <- read.csv("credit.csv", header=TRUE)
str(credit1)
# Creditability 컬럼의 0과 1의 숫자를 팩터형 1과 2로 바꿈
credit1$Creditability <- as.factor(credit1$Creditability)
str(credit1)
# 학습데이터와 테스트데이터 구성
library(caret) 
set.seed(1234)
trData <- createDataPartition(y = credit1$Creditability, p=0.7, list=FALSE)
head(trData)
train <- credit1[trData,] 
test <- credit1[-trData,] 
str(train) 
# 파라미터 설정
install.packages("e1071")
library("e1071")
# radial 커널 사용 튜닝
result1 <- tune.svm(Creditability~., data=train, gamma=2^(-5:0), cost = 2^(0:4), 
                    kernel="radial")
# linear 커널 사용 튜닝
result2 <- tune.svm(Creditability~., data=train, cost = 2^(0:4), kernel="linear")
# polynomial 커널 사용 튜닝
result3 <- tune.svm(Creditability~., data=train, cost = 2^(0:4), degree=2:4,
                    kernel="polynomial")
# 튜닝된 파라미터 확인
result1$best.parameters
result2$best.parameters
result3$best.parameters
# SVM 실행
normal_svm1 <- svm(Creditability~., data=train, gamma=0.0625, cost=1, kernel = "radial")
normal_svm2 <- svm(Creditability~., data=train, cost=1, kernel="linear")
normal_svm3 <- svm(Creditability~., data=train, cost=1, degree=3, kernel = "polynomial")
# 결과 확인
summary(normal_svm1)
summary(normal_svm2)
summary(normal_svm3)
# sv index 확인
normal_svm1$index
normal_svm2$index
normal_svm3$index
# SVM으로 예측
normal_svm1_predict <- predict(normal_svm1, test)
str(normal_svm1_predict)
normal_svm2_predict <- predict(normal_svm2, test)
str(normal_svm2_predict)
normal_svm3_predict <- predict(normal_svm3, test)
str(normal_svm3_predict)
# radial kernel 적용 시 Confusion Matrix 구성 및 Statistics
confusionMatrix(normal_svm1_predict, test$Creditability)
# linear kernel 적용 시 Confusion Matrix 구성 및 Statistics
confusionMatrix(normal_svm2_predict, test$Creditability)
# polynomial kernel 적용 시 Confusion Matrix 구성 및 Statistics
confusionMatrix(normal_svm3_predict, test$Creditability)
# iris 데이터 대상으로 예측
install.packages("kernlab")
library(kernlab)
model1 <- ksvm(Species~., data=iris)
iris_predicted <- predict(model1, newdata=iris)
table(iris_predicted, iris$Species)
