#######xgboost
install.packages("xgboost")
library(xgboost)
#2단계: y변수 생성
iris_label <- ifelse(iris$Species == 'setosa', 0,
                     ifelse(iris$Species == 'versicolor', 1, 2))
table(iris_label)
iris$label <- iris_label
#3단계: data set 생성
idx <- sample(nrow(iris), 0.7 * nrow(iris))
train <- iris[idx, ] 
test <- iris[-idx, ]
#4단계: matrix 객체 변환
train_mat <- as.matrix(train[-c(5:6)])
dim(train_mat)
train_lab <- train$label
length(train_lab)
#5단계: xgb.DMatrix 객체 변환
dtrain <- xgb.DMatrix(data = train_mat, label = train_lab)
#6단계: model생성 – xgboost matrix 객체 이용
xgb_model <- xgboost(data = dtrain, max_depth = 2, eta = 1,
                     nthread = 2, nrounds = 2,
                     objective = "multi:softmax", 
                     num_class = 3,
                     verbose = 0)
xgb_model
#7단계: test set 생성
test_mat <- as.matrix(test[-c(5:6)])
dim(test_mat)
test_lab <- test$label
length(test_lab)
#8단계: model prediction
pred_iris <- predict(xgb_model, test_mat)
pred_iris
#9단계: confusion matrix
table(pred_iris, test_lab)
#10단계: 모델 성능평가1 – Accuracy
(12 + 15 + 18) / length(test_lab)
#11단계: model의 중요 변수(feature)와 영향력 보기
importance_matrix <- xgb.importance(colnames(train_mat), 
                                    model = xgb_model)
importance_matrix
#12단계: 중요 변수 시각화
xgb.plot.importance(importance_matrix)
