######R ch12 연습문제
#문제1
#1)
data <- read.csv('Response.csv',header = T)
head(data)
#2)
data$job2[data$job == 1] <- "1.학생"
data$job2[data$job == 2] <- "2.직장인"
data$job2[data$job == 3] <- "3.주부"
data$response2[data$response == 1] <- "1.무응답"
data$response2[data$response == 2] <- "2.낮음"
data$response2[data$response == 3] <- "3.높음"
#3)
table(data$job2, data$response2)
#4)
chisq.test(data$job2, data$response2)
#5)
#직업 유형에 따라 응답 정도에 차이가 있다.


#문제2
#1)
data <- read.csv('cleanData.csv',header = T)
head(data)
#2)
x <- data$position
y <- data$age3 
#3)
plot(x,y)
#4)
library(gmodels)
CrossTable(x,y,chisq=T)
#5)
#나이와 직위간 관련성이 있다.

#문제3
#귀무가설 : 교육수준과 흡연율은 관계가 없다.
#대립가설 : 교육수준과 흡연율은 관계가 있다.

#1)
data <- read.csv('smoke.csv',header = T)
head(data)
#2)
data$education2[data$education == 1] <- "1.대졸"
data$education2[data$education == 2] <- "2.고졸"
data$education2[data$education == 3] <- "3.중졸"
data$smoking2[data$smoking == 1] <- "1.과다흡연"
data$smoking2[data$smoking == 2] <- "2.보통흡연"
data$smoking2[data$smoking == 3] <- "3.비흡연"
#3)
table(data$education2, data$smoking2)
#4)
chisq.test(data$education2, data$smoking2)
#교육수준과 흡연율은 관계가 있다.