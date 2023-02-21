############R ch7 연습문제
######김용현

#문제1
dataset <- read.csv("dataset.csv", header = T)
dataset2 <- subset(dataset,price>=2&price<=8)
dataset2 <- subset(dataset2, age >= 20 & age <= 69)
str(dataset2)
positon <- dataset2$position
cpositon <- 6- positon
dataset2$position <- cpositon
head(dataset2)

#문제2
resident2 <- na.omit(dataset2$resident)
resident2

#문제3
dataset2$gender2[dataset2$gender==1] <- '남자'
dataset2$gender2[dataset2$gender==2] <- '여자'
pie(table(dataset2$gender2))

#문제4
dataset2$age2[dataset2$age <= 30] <- "청년층"
dataset2$age2[dataset2$age > 30 & dataset2$age <= 55] <- "중년층"
dataset2$age2[dataset2$age > 55 ] <- "장년층"

dataset2$age3[dataset2$age <=30] <- 1
dataset2$age3[dataset2$age > 30 & dataset2$age < 55] <- 2
dataset2$age3[dataset2$age >= 55 ] <- 3

dataset2[c("age", "age2","age3")]


#문제5
setwd('C:/Rwork/')
getwd()  
write.csv(dataset2, "cleandata.csv", quote = F, row.names = F)
new_data=read.csv("cleandata.csv", header = TRUE);new_data

#문제6
setwd('C:/Rwork/dataset3/dataset3')
user_data =read.csv("user_data.csv", header = TRUE)
return_data =read.csv("return_data.csv", header = TRUE)
str(user_data)
str(return_data)
library(reshape2)
return <- dcast(return_data, user_id~return_code,length)
names(return) <- c('user_id', '제품이상(1)', '변심(2)',
                          '원인불명(3)', '기타(4)')
user_return_data <- join(user_data, return, by = 'user_id')
user_return_data

#문제7
head(iris)
library(cvTools)
cross <- cvFolds(n = nrow(iris), K = 5, R = 2, type = "random")
head(cross)
r = 1:2
K = 1:5
for(j in r){
  for(i in K) {
    datas_idx <- cross$subsets[cross$which == i, j]
    cat('K = ', i,'j =',j, '검정데이터 \n')
    print(iris[datas_idx, ])
    
    cat('K = ', i,'j =',j, '훈련데이터 \n')
    print(iris[-datas_idx, ])
  }
}

