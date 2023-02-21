##########R ch6 연습문제
######김용현

#문제1
library(reshape2)
data(iris)
head(iris)
#1)
long <- melt(iris, id = "Species")
long

#2)
data1 <- dcast(long,Species~variable,sum)
data1

#문제2
library(dplyr)
data(iris)

#1)
data1 <- iris %>% filter(Petal.Length >= 1.5)
data1

#2)
data2 <- data1 %>% select(c(1,3,5))
data2

#3)
data3 <- data2 %>% mutate(diff=Sepal.Length-Petal.Length)
data3
head(data3$diff)

#4)
data4 <- data3 %>% group_by(Species) %>% summarise(Sepal.Length_mean = mean(Sepal.Length),Petal.Length_mean=mean(Petal.Length))
data4




