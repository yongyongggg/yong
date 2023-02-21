#############R ch16 연습문제 연관분석
#######김용현

setwd('C:/Rwork/dataset4/dataset4')
#문제1
#1)
library(arules)
tran <- read.transactions('tranExam.csv', format = "single", 
                          sep = ",", cols = c(1, 2), rm.duplicates = T)
tran
inspect(tran)

#2)
summary(tran)
#3)
rule <- apriori(tran, parameter = list(supp = 0.3, conf = 0.1))
#4)
inspect(rule)


#문제2
#1)
data(Adult)
library(arules)
adult <- apriori(Adult, parameter = list(supp=0.5, conf=0.9))
adult 
#2)
rule <- inspect(head(sort(adult, by = "lift"),10))
#3)
library(arulesViz)
plot(adult, method = "grouped")
#4)
plot(adult, method="graph", control=list(type="items")) 
#5)
#capital-loss,capital-gain,native-country 중심으로 연관어가 형성되어있다.
