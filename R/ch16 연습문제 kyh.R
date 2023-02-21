###########R ch16 군집분석
#######김용현

#문제1
#1)
data(iris)
iris=iris[,-5]
idist <- dist(iris, method = "euclidean")
#2)
result <- hclust(idist)
#3)
plot(result, hang = -1)
#4)
rect.hclust(result, k=4)


#문제2
setwd('C:\\Rwork\\dataset4\\dataset4')
data = read.csv('product_sales.csv',header = T)
#1)
t <- sample(1:nrow(data),nrow(data)*0.7)
data1 <- data[t,]
result <- kmeans(data1,3)
#2)
data1$cluster <- result$cluster
head(data1)
#3)
cor(data1[,-5], method = "pearson")
plot(data1$tot_price, data1$avg_price, col = data1$cluster)
#4)
points(result$centers[ , c("tot_price", "avg_price")],
       col = c(3, 1, 2), pch = 8, cex = 5)
