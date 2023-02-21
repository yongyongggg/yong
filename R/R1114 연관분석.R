############연관분석
setwd('C:\\Rwork\\dataset4\\dataset4')
#1단계: 연관분석을 위한 패키지 설치
install.packages("arules")
library(arules)
#arules 패키지
#2단계: 트랜잭션(transaction) 객체 생성
tran <- read.transactions("tran.txt", format = "basket", sep = ",")
tran
#3단계: 트랜잭션 데이터 보기
inspect(tran)
#4단계: 규칙(rule) 발견1
rule <- apriori(tran, parameter = list(supp = 0.3, conf = 0.1))
inspect(rule)
#5단계: 규칙(rule) 발견2
rule <- apriori(tran, parameter = list(supp = 0.1, conf = 0.1))
inspect(rule)


#p.5
stran <- read.transactions("demo_single", format = "single", cols = c(1, 2))
inspect(stran)

#p.6(중복 트랜잭션 제거)
#1단계: 트랜잭션 데이터 가져오기
stran2 <- read.transactions("single_format.csv", format = "single",
                            sep = ",", cols = c(1, 2), rm.duplicates = T)

#2단계: 트랜잭션과 상품수 확인
stran2
#3단계: 요약통계량 제공
summary(stran2)

#(규칙 발견(생성))
#1단계: 규칙 생성하기
astran2 <- apriori(stran2)
#2단계: 발견된 규칙 보기
inspect(astran2)
#3단계: 상위 5개의 향상도를 내림차순으로 정렬하여 출력
inspect(head(sort(astran2, by = "lift")))


#p.7 basket형식으로 트랜잭션 객체 생성)
btran <- read.transactions("demo_basket", format = "basket", sep = ",")
inspect(btran)



#p.8 Adult 데이터 셋 가져오기
data(Adult)
Adult
#(AdultUCI 데이터 셋 보기)
data("AdultUCI")
str(AdultUCI)

#1단계: data.frame형식으로 보기
adult <- as(Adult, "data.frame")
str(adult)
head(adult)
#2단계: 요약통계량
summary(Adult)
#실습 (지지도 10%와 신뢰도 80%가 적용된 연관규칙 발견)
ar <- apriori(Adult, parameter = list(supp = 0.1, conf = 0.8))
#실습 (다양한 신뢰도와 지지도를 적용한 예)
#1단계: 지지도를 20%로 높인 경우 1,306개 규칙 발견
ar1 <- apriori(Adult, parameter = list(supp = 0.2))
#2단계: 지지도를 20%, 신뢰도 95%로 높인 경우 348개 규칙 발견
ar2 <- apriori(Adult, parameter = list(supp = 0.2, conf = 0.95))
#3단계: 지지도를 30%, 신뢰도 95%로 높인 경우 124개 규칙 발견
ar3 <- apriori(Adult, parameter = list(supp = 0.3, conf = 0.95))
#4단계: 지지도를 35%, 신뢰도 95%로 높인 경우 67개 규칙 발견
ar4 <- apriori(Adult, parameter = list(supp = 0.35, conf = 0.95))
#5단계: 지지도를 40%, 신뢰도 95%로 높인 경우 36개 규칙 발견
ar5 <- apriori(Adult, parameter = list(supp = 0.4, conf = 0.95))


#(규칙 결과 보기)
#1단계: 상위 6개 규칙 보기
inspect(head(ar5))
#2단계: confidence(신뢰도)기준 내림차순 정렬 상위 6개 출력
inspect(head(sort(ar5, decreasing = T, by = "confidence")))
#3단계: lift(향상도)기준 내림차순 정렬 상위 6개 출력
inspect(head(sort(ar5, by = "lift")))

#(연관규칙 시각화)
#1단계 패키지 설치
install.packages("arulesViz")
install.packages('ggraph')
library(ggraph)
library(arulesViz)
#2단계: 연관규칙 시각화
plot(ar3, method = "graph", control = list(type = "items"))


#p.11 Groceries 데이터 셋으로 연관분석
#1단계: Groceries 데이터 셋 가져오기
data("Groceries")
str(Groceries)
Groceries
#2단계: 데이터프레임으로 형 변환
Groceries.df <- as(Groceries, "data.frame")
head(Groceries.df)
#3단계: 지지도 0.001, 신뢰도 0.8 적용 규칙 발견
rules <- apriori(Groceries, parameter = list(supp = 0.001, conf = 0.8))
#4단계: 규칙을 구성하는 왼쪽(LHS)  오른쪽(RHS)의 item 빈도수 보기
#규칙의 표현 A(LHS)  B(RHS)
plot(rules, method = "grouped")


#P.12 (최대 길이가 3 이하인 규칙 생성)
rules <- apriori(Groceries, 
                 parameter = list(supp = 0.001, conf = 0.80, maxlen = 3))
#규칙을 구성하는 LHS와 RHS 길이를 합쳐서 3이하의 길이를 갖는 규칙 생성
#실습 (Confidence(신뢰도)기준 내림차순으로 규칙 정렬)
rules <- sort(rules, decreasing = T, by = "confidence")
inspect(rules)
#실습 (발견된 규칙 시각화)
library(arulesViz)
plot(rules, method = "graph")


#p.13 (특정 상품(Item)으로 서브 셋 작성과 시각화)
#1단계: 오른쪽 item이 전지분유(whole milk)인 규칙만 서브 셋으로 작성
wmilk <- subset(rules, rhs %in% 'whole milk')
wmilk
inspect(wmilk)
plot(wmilk, method = "graph")
#2단계: 오른쪽 item이 other vegetables인 규칙만 서브 셋으로 작성
oveg <- subset(rules, rhs %in% 'other vegetables')
oveg
inspect(oveg)
plot(oveg, method = "graph")
#3단계: 오른쪽 item이 vegetables 단어가 포함된 규칙만 서브 셋으로 작성
oveg <- subset(rules, rhs %pin% 'vegetables')
oveg
inspect(oveg)
plot(oveg, method = "graph")
#4단계: 왼쪽 item이 butter 또는 yogurt인 규칙만 서브 셋으로 작성
butter_yogurt <- subset(rules, lhs %in% c('butter', 'yogurt'))
butter_yogurt
inspect(butter_yogurt)
plot(butter_yogurt, method = "graph")
