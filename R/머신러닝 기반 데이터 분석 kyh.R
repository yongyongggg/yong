#########빅데이터 분석
#######김용현

#문항1
#1)
library(rpart)
data(iris)
set.seed(1234)
idx <- sample(1:nrow(iris), nrow(iris) * 0.7)
train <- iris[idx, ]
test <- iris[-idx, ]
#2)
formula <- Species ~ Sepal.Length + Sepal.Width + Petal.Length + Petal.Width
iris_model1 <- rpart(formula, data = train)
iris_model1
#3)
iris_model2  <- rpart(formula, data = test)
iris_pred <- predict(iris_model2,newdata=test,type = "class")
#4)
table(iris_pred,test$Species)
sum(iris_pred == test$Species)/NROW(iris_pred)
#97.77778%

#문항2
#1)
library(party)
data(iris)
set.seed(1000) 
idx <- sample(1:nrow(iris), nrow(iris) * 0.7)
sampnum <- sample(2, nrow(iris), replace=TRUE, prob=c(0.7,0.3))
sampnum
trData <- iris[sampnum==1,]
teData <- iris[sampnum == 2, ]
#2)
formula <- Species ~ Sepal.Length + Sepal.Width + Petal.Length + Petal.Width
iris_ctree <- ctree(formula, data = trData)
iris_ctree
#3)
citreeResult2 <- ctree(formula, data=teData)
forcasted2 <- predict(citreeResult2, data=teData)
#4)
plot(citreeResult2)
 
#문항3
#1)
library(cluster)
data(iris)
idist <- dist(iris[1:4],method = 'euclidean')
#2)
hc <- hclust(idist)
#3)
plot(hc, hang = -1)
#4)
rect.hclust(hc, k = 3, border ="red")

#문항4
#1)
data('iris')
iris2 <-iris
#2)
iris2$Species <- NULL 
head(iris2)
#3)
kmeans_result <- kmeans(iris2, 6) 
kmeans_result
str(kmeans_result)
#4)
plot(iris2[c("Sepal.Length", "Sepal.Width")], col=kmeans_result$cluster)
points(kmeans_result$centers[, c("Sepal.Length", "Sepal.Width")], col=1:4, pch=8, cex=2)

plot(iris2[c("Petal.Length", "Petal.Width")], col=kmeans_result$cluster)
points(kmeans_result$centers[, c("Petal.Length", "Petal.Width")], col=1:4, pch=8, cex=2)

plot(iris2, col = kmeans_result$cluster)