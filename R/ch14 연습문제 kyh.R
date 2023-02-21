######R ch14 연습문제
###김용현

#문제1
#1)
library(memisc) 
setwd("C:/Rwork/dataset2/dataset2")
data.spss <- as.data.set(spss.system.file('drinking_water_example.sav')) 
data.spss 
drinkig_water_exam <- data.spss[1:7] 
drinkig_water_exam_df <- as.data.frame(drinkig_water_exam) 
str(drinkig_water_exam_df)
dr
#2)
result <- factanal(drinkig_water_exam_df, factors = 2, rotation = "varimax",scores = "regression")
result
#3)
colnames(result$loadings) <- c("제품친밀도","제품만족도")
result$loadings
#4)
plot(result$scores[ , c(1,2)],
     main = "제품친밀도와 제품만족도 요인점수 행렬")
text(result$scores[ , 1], result$scores[ , 2],
     labels = name, cex = 0.7, pos = 3, col = "blue")
points(result$loadings[ , c(1:2)], pch = 19, col = "red")
text(result$loadings[ , 1], result$loadings[ , 2],
     labels = rownames(result$loadings),  cex = 0.8, pos= 3, col = "red")
#5)
inti <- data.frame(drinkig_water_exam_df$Q1, drinkig_water_exam_df$Q2,
                       drinkig_water_exam_df$Q3)
sati <- data.frame(drinkig_water_exam_df$Q4,drinkig_water_exam_df$Q5,
                  drinkig_water_exam_df$Q6,drinkig_water_exam_df$Q7)

#문제2
app_inti <- round((drinkig_water_exam_df$Q1+drinkig_water_exam_df$Q2+drinkig_water_exam_df$Q3)
                     / ncol(inti), 2)                                                                
app_sati <- round((drinkig_water_exam_df$Q4+drinkig_water_exam_df$Q5+drinkig_water_exam_df$Q6+drinkig_water_exam_df$Q7)
                  / ncol(sati), 2)   
subject_factor_df<- data.frame(app_inti,app_sati)
cor(subject_factor_df)
