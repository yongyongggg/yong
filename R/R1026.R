########R1026
####P.24
setwd("C:/Rwork/dataset2/dataset2 ")
data <- read.csv("three_sample.csv", header = TRUE)
head(data)

method <- data$method
survey <- data$survey
method; survey

table(method, useNA = "ifany")
table(method, survey, useNA = "ifany")

prop.test(c(34, 37, 39),c(50, 50, 50))

#P.27
data <- read.csv("C:/Rwork/three_sample.csv", header=T)
head(data)

data <- subset(data, !is.na(score), c(method, score))
head(data)

par(mfrow = c(1, 2))
plot(data$score)
barplot(data$score)
mean(data$score)

length(data$score)
data2 <- subset(data, score < 14)
length(data2$score)

x <- data2$score
par(mfrow = c(1, 1))
boxplot(x)

data2$method2[data2$method == 1] <- "방법1"
data2$method2[data2$method == 2] <- "방법2"
data2$method2[data2$method == 3] <- "방법3"

table(data2$method2)

x <- table(data2$method2)
x

y <- tapply(data2$score, data2$method2, mean)
y

df <- data.frame(교육방법 = x, 시험성적 = y)
df

bartlett.test(score ~ method, data = data2)

result <- aov(score ~ method2, data = data2)
names(result)
summary(result)

TukeyHSD(result)

plot(TukeyHSD(result))




