###########화면 설계
######김용현
#문항1
#1)
library(xgboost)
data(iris)
head(iris)
iris_label <- ifelse(iris$Species == 'setosa', 0,
                     ifelse(iris$Species == 'versicolor', 1, 2))
iris$label <- iris_label
library(caret)
set.seed(1234)
idx <- createDataPartition(iris$Species, p = c(0.7), list = F)
train <- iris[idx, ]
test <- iris[-idx, ]
table(train$Species) 
table(test$Species)

#문항2 2)
train_mat <- as.matrix(train[-c(5:6)])
dim(train_mat)
train_lab <- train$label
length(train_lab)
#xgb.DMatrix 객체 변환
dtrain <- xgb.DMatrix(data = train_mat, label = train_lab)
#model생성
xgb_model <- xgboost(data = dtrain, max_depth = 2, eta = 1,
      nthread = 2, nrounds = 2,objective = "multi:softmax", 
      num_class = 3, verbose = 0)
xgb_model


#문항3 3)
test_mat <- as.matrix(test[-c(5:6)])
dim(test_mat)
test_lab <- test$label
length(test_lab)
dtest <- xgb.DMatrix(data = test_mat, label = test_lab)

xgb_model1 <- xgboost(data = dtest, max_depth = 2, eta = 1,
      nthread = 2, nrounds = 2,objective = "multi:softmax", 
      num_class = 3, verbose = 0)
xgb_model1


#문항4 4)
pred_iris <- predict(xgb_model, test_mat)
pred_iris
table(pred_iris, test_lab)
sum(pred_iris == test$label)/length(pred_iris)
#93.33333%


#문항5
#2. iris 데이터를 대상으로 다음 조건에 맞게 시각화 하시오.
library(ggplot2)
iris_gg <- ggplot(iris, aes(Sepal.Length, Petal.Length,
    color = Species)) + geom_point() + geom_smooth(method = 'lm')
iris_gg

#문항6
iris_gg <- iris_gg + ggtitle('Scatter plot for iris data')
iris_gg

#문항7
ggsave(file = "C:/Rwork/iris_KYH.jpg")

#문항8
data(diamonds)
head(diamonds)
library(ggplot2)
p <- ggplot(diamonds, aes(carat, price, color = clarity))
p + geom_point()

#문항9
p <- p +geom_point()+ geom_smooth()
p

#문항10
ggsave(file = "diamonds_KYH.jpg")

