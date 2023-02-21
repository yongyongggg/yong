#########R ch7
getwd()
setwd('C:/Rwork/dataset3/dataset3')
#p.2
dataset <- read.csv('dataset.csv',header=T)
dataset

print(dataset)
View(dataset)
head(dataset)
tail(dataset)

names(dataset)
attributes(dataset)
str(dataset)

#p.5
dataset$age
dataset$resident
length(dataset$age)

x <- dataset$gender ;x
y <- dataset$price ;y

plot(dataset$price)

dataset['gender']
dataset['price']

dataset[2]
dataset[6]
dataset[3,]
dataset[,3]

dataset[c('job','price')]
dataset[c(2,6)]
dataset[c(1,2,3)]
dataset[c(2,4:6,3,1)]

dataset[,c(2:4)]
dataset[c(2:4),]
dataset[-c(1:100),]

#p.7 결측치 처리
summary(dataset$price)
sum(dataset$price)

sum(dataset$price,na.rm=T)
price2=na.omit(dataset$price)
sum(price2)
length(price2)

x <- dataset$price
x[1:30]
dataset$price2 = ifelse(!is.na(x), x, 0)
dataset$price2[1:30]

x <- dataset$price
x[1:30]
dataset$price3 = ifelse(!is.na(x), x, round(mean(x, na.rm = TRUE), 2))
dataset$price3[1:30]
dataset[c('price', 'price2', 'price3')]

#p.10
table(dataset$gender)
pie(table(dataset$gender))

dataset <- subset(dataset,gender==1|gender==2)
dataset
length(dataset$gender)
pie(table(dataset$gender))
pie(table(dataset$gender), col = c("red", "blue"))

#p.11 극단치
dataset <- read.csv("dataset.csv", header = T)
dataset$price
length(dataset$price)
plot(dataset$price)
summary(dataset$price)

dataset2 <- subset(dataset,price>=2&price<=8)
length(dataset2$price)
stem(dataset2$price)

summary(dataset2$age)
length(dataset2$age)

dataset2 <- subset(dataset2, age >= 20 & age <= 69)
length(dataset2)
boxplot(dataset$age)

boxplot(dataset$price)
boxplot(dataset$price)$stats

dataset_sub <- subset(dataset, price >= 2 & price <= 7.9)
summary(dataset_sub$price)

#p.14 코딩변경
dataset2$resident2[dataset2$resident==1] <- '1.서울특별시'
dataset2$resident2[dataset2$resident==2] <- '2.인천광역시'
dataset2$resident2[dataset2$resident==3] <- '3.대전광역시'
dataset2$resident2[dataset2$resident==4] <- '4.대구광역시'
dataset2$resident2[dataset2$resident==5] <- '5.시군구'

dataset2[c('resident','resident2')]

dataset2$job2[dataset2$job == 1] <- '공무원'
dataset2$job2[dataset2$job == 2] <- '회사원'
dataset2$job2[dataset2$job == 3] <- '개인사업'

dataset2[c("job", "job2")]

dataset2$age2[dataset2$age <= 30] <- "청년층"
dataset2$age2[dataset2$age > 30 & dataset2$age <= 55] <- "중년층"
dataset2$age2[dataset2$age > 55 ] <- "장년층"
head(dataset2)

survey <- dataset2$survey
survey
csurvey <- 6 - survey
csurvey

dataset2$survey <- csurvey
head(dataset2)


par(mfrow = c(1, 1))
#p.17
new_data <- read.csv("new_data.csv", header = TRUE)
str(new_data)

resident_gender <- table(new_data$resident2,new_data$gender2)
resident_gender
gender_resident <- table(new_data$gender2,new_data$resident2)
gender_resident

barplot(resident_gender, beside = T, horiz = T,col = rainbow(5),
        legend = row.names(resident_gender), main = '성별에 따른 거주지역 분포 현황')


barplot(gender_resident, beside = T,col = rep(c(2, 4), 5), horiz = T,
        legend = c("남자", "여자"),main = '거주지역별 성별 분포 현황')

#p.19
install.packages("lattice")
library(lattice)
str(new_data)
densityplot(~ age, data = new_data,groups = job2,
            # plot.points = T: 밀도, auto.key = T: 범례)
            plot.points = T, auto.key = T)

densityplot(~ price | factor(gender),data = new_data,
            groups = position2,
            plot.points = T, auto.key = T)


densityplot(~ price | factor(position2),
            data = new_data,
            groups = gender2,
            plot.points = T, auto.key = T)


xyplot(price ~ age | factor(gender2),data = new_data)


#p.22 파생 변수
user_data <- read.csv("user_data.csv", header = T)
head(user_data)
table(user_data$house_type)

house_type2 <- ifelse(user_data$house_type == 1 |
                        user_data$house_type == 2, 0 , 1)
house_type2[1:10]

user_data$house_type2 <- house_type2
head(user_data)


pay_data <- read.csv("pay_data.csv", header = T)
head(pay_data, 10)
table(pay_data$product_type)

library(reshape2)
product_price <- dcast(pay_data, user_id ~ product_type,sum, na.rm = T)
head(product_price, 3)
names(product_price) <- c('user_id', '식표품(1)', '생필품(2)',
                          '의류(3)', '잡화(4)', '기타(5)')
head(product_price)

pay_price <- dcast(pay_data, user_id ~ pay_method, length)
head(pay_price, 3)

names(pay_price) <- c('user_id', '현금(1)', '직불카드(2)',
                      '신용카드(3)', '상품권(4)')
head(pay_price, 3)

#p.26 파생변수 합치기
library(plyr)
user_pay_data <- join(user_data, product_price, by = 'user_id')
head(user_pay_data, 10)

user_pay_data <- join(user_pay_data, pay_price, by = 'user_id')
user_pay_data[c(1:10), c(1, 7:15)]

user_pay_data$총구매금액 <- user_pay_data$'식표품(1)' +
  user_pay_data$'생필품(2)' +user_pay_data$'의류(3)' +
  user_pay_data$'잡화(4)' + user_pay_data$'기타(5)'

user_pay_data[c(1:10), c(1, 7:11, 16)]

#p.28 표본추출
print(user_pay_data)
write.csv(user_pay_data, "cleanData.csv", quote = F, row.names = F)
data <- read.csv("cleanData.csv", header = TRUE)
data

nrow(data)
choice1 <- sample(nrow(data),30) ;choice1

choice2 <- sample(50:nrow(data),30);choice2

choice3 <- sample(c(50:100), 30) ;choice3

choice4 <- sample(c(10:50, 80:150, 160:190), 30) ;choice4

data[choice1, ]

#p.30
data("iris")
dim(iris)

idx <-sample(1:nrow(iris), nrow(iris) * 0.7)
training <- iris[idx, ]
testing <- iris[-idx, ]
dim(training)
dim(testing)
dim(iris)

#p.32
name <- c('a', 'b','c', 'd', 'e', 'f')
score <- c(90, 85, 99, 75, 65, 88)
df <- data.frame(Name = name, Score = score)

install.packages("cvTools")
library(cvTools)

cross <- cvFolds(n = 6, K = 3, R = 1, type = "random")
cross

str(cross)
cross$which

cross$subsets[cross$which == 1, 1]
cross$subsets[cross$which == 2, 1]
cross$subsets[cross$which == 3, 1]

r = 1
K = 1:3
for(i in K) {
  datas_idx <- cross$subsets[cross$which == i, r]
  cat('K = ', i, '검정데이터 \n')
  print(df[datas_idx, ])
  
  cat('K = ', i, '훈련데이터 \n')
  print(df[-datas_idx, ])
}

