########R ch3 연습문제
#### 김용현

#문제1
#1)
table(CO2)
a= subset(CO2,CO2$Treatment =='nonchilled')
a
write.table(a, "CO2_df1.csv", row.names = FALSE)
#2)
b= subset(CO2,CO2$Treatment =='chilled')
b
write.table(b, "CO2_df2.csv", row.names = FALSE)

#문제2
#1)
titanicData <-read.csv("https://vincentarelbundock.github.io/Rdatasets/csv/COUNT/titanic.csv")
titanicData
str(titanicData)
#2)
head(titanic[,-c(1,3)])
