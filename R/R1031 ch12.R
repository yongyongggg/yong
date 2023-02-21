###R ch 12

#p.2
setwd("C:/Rwork/dataset2/dataset2 ")
data <- read.csv("cleanDescriptive.csv", header = TRUE)
head(data)

x <- data$level2
y <- data$pass2

result <- data.frame(Level = x, Pass = y)
dim(result)

#p.4
table(result)
install.packages("gmodels")
library(gmodels)
install.packages("ggplot2")
library(ggplot2)

CrossTable(x = diamonds$color, y = diamonds$cut)

x <- data$level2
y <- data$pass2
CrossTable(x, y)


#p.10 일원 카이제곱
chisq.test(c(4, 6, 17, 16, 8, 9))

data <- textConnection(
  "스포츠음료종류 관측도수
 1 41
 2 30
 3 51
 4 71
 5 61
 ")
x <- read.table(data, header = T)
x
chisq.test(x$관측도수)


#p.12 이원 카이제곱 검정
data <- read.csv("cleanDescriptive.csv", header = TRUE)
x <- data$level2
y <- data$pass2
CrossTable(x, y, chisq = TRUE)


#p.13
data <- read.csv("homogenity.csv")
head(data)
data <- subset(data, !is.na(survey), c(method, survey))
#2단계: 코딩변경(변수 리코딩)
data$method2[data$method == 1] <- "방법1"
data$method2[data$method == 2] <- "방법2"
data$method2[data$method == 3] <- "방법3"
data$survey2[data$survey == 1] <- "1.매우만족"
data$survey2[data$survey == 2] <- "2.만족"
data$survey2[data$survey == 3] <- "3.보통"
data$survey2[data$survey == 4] <- "4.불만족"
data$survey2[data$survey == 5] <- "5.매우불만족"
#3단계: 교차분할표 작성
table(data$method2, data$survey2)
#*교차분할표 작성 시 각 집단의 길이가 같아야 함
#4단계: 동질성 검정 – 모든 특성치에 대한 추론 검정
chisq.test(data$method2, data$survey2)