########베이지안
setwd('C:\\Rwork')
install.packages("e1071")
install.packages("caret")
library(e1071)
library(caret)

data <- read.csv(file = "heart.csv", header = T)
head(data)
str(data)
library(caret)
set.seed(1234)

tr_data <- createDataPartition(y=data$AHD, p=0.7, list=FALSE)
tr <- data[tr_data,]
te <- data[-tr_data,]

Bayes <- naiveBayes(AHD~. ,data=tr)
Bayes

predicted <- predict(Bayes, te, type="class")
table(predicted, te$AHD) 

AHD <- as.factor(te$AHD)
confusionMatrix(predicted, AHD)
