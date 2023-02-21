#1-21일 등장
setwd('C:/Rwork/csse_covid_19_daily_reports')
getwd()

#문제1
data2021 <- read.csv('12-31-2021.csv')
data2020 <- read.csv('12-31-2020.csv')

write.csv(data2021,'data2021.csv')
library(dplyr)
group1 <- data2021 %>% select(Country_Region,Confirmed,Deaths) %>% group_by(Country_Region) %>% summarise(sum(Confirmed),sum(Deaths))
group2 <- data2020 %>% select(Country_Region,Confirmed,Deaths) %>% group_by(Country_Region) %>% summarise(sum(Confirmed),sum(Deaths))

group =merge(group1,group2,by='Country_Region',all.x = T);group
sum(rowSums(is.na(group))>0)
covid <- group %>% mutate(Confrimed = group$`sum(Confirmed).x`-group$`sum(Confirmed).y`,Death=group$`sum(Deaths).x`-group$`sum(Deaths).y`) %>% select(Country_Region,Confrimed,Death)
covid <- covid %>%mutate(daily_Confrimed = covid$Confrimed/365, daily_Death=covid$Death/365 )
options(digits = 3)
covid
#문제2
rowSums(is.na(covid))>0 
covid %>% subset(is.na(Death)&is.na(Confrimed)) %>% select(Country_Region)
covid %>% filter(Confrimed ==0 & Death ==0) %>% select(Country_Region)
covid %>% filter(Confrimed >0 | Death >0) %>% select(Country_Region)

#문제3
arr1 <- covid %>% arrange(desc(Confrimed)) %>% head(20) ;arr1
arr2 <- covid %>% arrange(desc(Death)) %>% head(20) ;arr2
arr3 <- covid %>% arrange(desc(daily_Confrimed)) %>% head(20) ;arr3
arr4 <- covid %>% arrange(desc(daily_Death)) %>% head(20) ;arr4

#문제4
covid %>% filter(Country_Region == 'Korea, South')
