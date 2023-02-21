#B4(양정연, 신정훈, 김용현, 조성운) 제출 코드 

# # 1. USD/KRW 환율 데이터 (https://kr.investing.com/currencies/usd-krw-historicaldata)에 있는 일별 환율데이터(2021년 11월 15일 ~ 2022년 11월 14일 대상)를
# # 기반으로 회귀분석 또는 시계열분석을 이용하여 2022년 12월 우리나라 미국달러대비
# # 원화 환율을 예측하고 시각화하시오.
# # 참고사항:
# # * 회귀분석 실시 시 기본가정 충족 여부 확인 포함.
# # * 기본가정 불충족 시에는 충족시킬 수 있는 방법을 제시하고 실행.
# # * 제시한 방법으로도 기본가정 불충족 시에는 회귀선을 구하여 예측하고 comment 하시오.

library(dplyr)
library(ggplot2)
library(forecast)

# # 데이터 불러오기
setwd("C:/Rwork/")
data <- read.csv("USD_KRW.csv")
str(data)
data<-data%>%arrange(data,as.Date(unlist(data[1])))
data
#sort(data,as.Date(unlist(data(1)])
data

# 1) 시계열 데이터로 변경
data_last <- unlist(data[2])
data_last <- sub(pattern=",",replacement="",x=data_last)
data_last <- as.numeric(data_last)
data_ts <- ts(data=data_last,start = c(1), frequency = 260)
data_ts
plot(data_ts, col= "salmon", lwd= 2, main = "종가")

# 2) 모델 식별과 추정
arima <- auto.arima(data_ts)
arima

# 3) 모형 생성
model <- arima(data_last, order = c(0, 1, 0))
model

# 4) 모델진단

# 잔차 분석에 의한 모형 진단
tsdiag(model)

# 5) Box-Ljung에 의한 잔차항 모형 진단
Box.test(model$residuals, lag = 1, type = "Ljung")

# 6) 미래 예측
par(mfrow = c(1, 2))
fore <- forecast(model, h = 34)
plot(fore)
fore

# 최종예측 95% 범위 1235.33 ~ 1412.41

# # ==================================================================
'''2. 위스콘신 유방암 데이터셋을 대상으로 분류기법 2개를 적용하여 기법별 결과를
비교하고 시각화하시오. (R과 python 버전으로 모두 실행)
-종속변수는diagnosis: Benign(양성), Malignancy(악성)'''

#xgboost-----------------------------------------------------------------
library(xgboost)

#데이터 샘플링
raw_wis <- read.csv("wisc_bc_data.csv", header = T)

#y변수 생성
wis_label <- ifelse(raw_wis$diagnosis == "B", 0,
                    ifelse(raw_wis$diagnosis == "M", 1, 2))

table(wis_label)
raw_wis$label <- wis_label

#데이터셋 생성
set.seed(1234)
idx <- sample(nrow(raw_wis), 0.7 * nrow(raw_wis))
train <- raw_wis[idx, -1]
test <- raw_wis[-idx, -1]

#matrix 객체 변환
train_mat <- as.matrix(train[-c(1, 32)])
dim(train_mat)

train_lab <- train$label
length(train_lab)

#xgb.DMatrix 객체 변환
dtrain <- xgb.DMatrix(data = train_mat, label = train_lab)

#model 생성
xgb_model <- xgboost(data = dtrain, max_depth = 2, eta = 1,
                     nthread = 2, nrounds = 2, num_class = 2,
                     objective = "multi:softmax",
                     verbose = 0)
xgb_model

#test set 생성
test_mat <- as.matrix(test[-c(1, 32)])
dim(test_mat)
test_lab <- test$label
length(test_lab)

#모델 prediction
pred_wis <- predict(xgb_model, test_mat)
pred_wis
table(pred_wis, test_lab)
sum(pred_wis == test_lab)/ NROW(pred_wis)

##model의 중요 변수(feature)와 영향력 보기
table(pred_wis, test_lab)

importance_matrix <- xgb.importance(colnames(train_mat),
                                    model = xgb_model)
importance_matrix

#중요 변수 시각화
xgb.plot.importance(importance_matrix)
par(mfrow = c(1, 1))

#randomforeset-----------------------------------------------------------------
#데이터셋 생성
set.seed(1234)
idx <- sample(nrow(raw_wis), 0.7 * nrow(raw_wis))
train <- raw_wis[idx, -1]
test <- raw_wis[-idx, -1]

#matrix 객체 변환
train_mat <- as.matrix(train[-c(1, 32)])
train_lab <- train$label
#install.packages('rnadomForest')
library(randomForest) 

# 랜덤포레스트 실행
RFmodel <- randomForest(train_lab~., data=train_mat, ntree=100, proximity=T)
RFmodel
#test set 생성
test_mat <- as.matrix(test[-c(1, 32)])
dim(test_mat)
test_lab <- test$label

# 시각화
plot(RFmodel)
# 모델에 사용된 변수 중 중요한 것 확인
importance = as.data.frame(importance(RFmodel))
importance= arrange(importance,desc(IncNodePurity))
importance$IncNodePurity
# 중요한 것 시각화
varImpPlot(RFmodel)

# # ==================================================================
'''3. mlbench패키지 내 BostonHousing 데이터셋을 대상으로 예측기법 2개를 적용하여
기법별 결과를 비교하고 시각화하시오. (R과 python 버전으로 모두 실행)
-종속변수는MEDV 또는CMEDV를사용'''

#의사결정나무----------------------------------------------------------------
library(rpart)
library(mlbench)
library(rpart.plot)

data("BostonHousing")
tree.df <- BostonHousing

str(tree.df)
head(tree.df)

#test, train 으로 분리하기
idx <- sample(1:nrow(tree.df), nrow(tree.df)*0.7)
train.tree <- tree.df[idx, ]
test.tree <- tree.df[-idx, ]

#tree 모형 만들기(train데이터사용)
pre_tree <- rpart(medv ~., data = train.tree, control = rpart.control())
printcp(pre_tree) #complexity parameter

#가지치기하기 
#best cp value 식별하기(xerror가 최소가 되는 것)
best_cp <- pre_tree$cptable[which.min(pre_tree$cptable[, "xerror"]),
                            "CP"]

#위 결과를 기반으로 가지치기된 나무 생성
pruned_tree <- prune(pre_tree, cp = best_cp)

#시각화하기
prp(pruned_tree, 
    faclen=0,
    extra = 1,
    digits=5)

#9개의 terminal nodes를 갖고 있음

#예측해보기(TEST 사용)
a <- predict(pruned_tree, newdata=test.tree)
test.tree$medv

#상관성 검증
cor(a, test.tree$medv)
#0.8648356 #높은상관관계

#선형회귀분석 ----------------------------------------------------------------------
library(car)
library(ggplot2)

model <- lm(formula = medv ~ ., data = BostonHousing)
vif(model) > 10

set.seed(1234)
idx <- sample(1:nrow(BostonHousing), nrow(BostonHousing) * 0.7)
train <- BostonHousing[idx, ]
test <- BostonHousing[-idx, ]

model <- lm(formula = medv ~ ., data = train)
summary(model)

step <- step(model, direction = 'backward')
formula(step)

model2 <- lm(formula = step, data = train)
summary(model2)
# Adjusted R-squared:  0.7419

pred <- predict(model2, test)
cor(pred, test$medv)
# [1] 0.8349967
bind <- cbind(pred, test$medv)
head(bind)
colnames(bind) <- c('pred', 'medv')
df <- as.data.frame(bind)

ggplot(df, aes(pred, medv)) +
  geom_point() + 
  stat_smooth(method = lm)

# # ==================================================================
'''4. 아래의 조건을 고려하여 군집분석을 실행하시오.
(1) 데이터: ggplot2 패키지 내 diamonds 데이터
(2) philentropy::distance() 함수 내 다양한 거리 계산 방법 중 Euclidian거리를 제외한
3개를 이용하여 거리 계산 및 사용된 거리에 대한 설명
(3) 탐색적 목적의 계층적 군집분석 실행
(4) 군집수 결정 및 결정 사유 설명
(5) k-means clustering 실행
(6) 시각화
(7) 거리 계산 방법에 따른 결과 차이 비교'''

library(ggplot2)
library(philentropy)
library(cluster)
library(NbClust)
library(corrgram)

# (1)
#install.packages("ggplot2")
data(diamonds)
str(diamonds)
head(diamonds)
set.seed(1234)
idx <- sample(1:nrow(diamonds), 1000)
head(idx)
t <- diamonds[idx, ]
d <- t[, -c(2:4, 8:10)]
dia <- scale(d)
head(dia)
length(dia$carat)


# (2)
getDistMethods()
man <- dist(dia, method = 'manhattan')
max <- dist(dia, method = 'maximum')
can <- dist(dia, method = 'canberra')
help(dist)

# (3)
#install.packages('cluster')
help(hclust)

man_hc1 <- hclust(man, method = 'average')
max_hc1 <- hclust(max, method = 'average')
can_hc1 <- hclust(can, method = 'average')
help("NbClust")
NbClust(dia, distance = 'manhattan', method = 'average')


# (4)
X11()
par(mfrow = c(1, 2))
plot(man_hc1, hang = -1)
rect.hclust(man_hc1, k=2)
plot(max_hc1, hang = -1)
rect.hclust(max_hc1, k=2)
plot(can_hc1, hang = -1)
rect.hclust(can_hc1, k=2)


# (5)
corrgram(dia, upper.panel = panel.conf)
kmeans <- kmeans(d, 2)


# (6)
X11()
plot(d[c('carat', 'price')], col = kmeans$cluster,
     pch = 21, bg = kmeans$cluster)
points(kmeans$centers[, c('carat', 'price')],
       col = 3:4, pch = 23, cex = 3, bg = 3:4)

# # ==================================================================

'''5. 제공된 데이터를 대상으로 텍스트 분석을 실행하시오. 
데이터:
(1) 제공된 데이터를 이용하여 토픽 분석을 실시하여 단어구름으로 시각화 하고 단어
출현 빈도수를 기반하여 어떤 단어들이 주요 단어인지 설명하시오
(2) 제공된 데이터를 이용하여 연관어 분석을 실시하여 연관어를 시각화 하고 시각화
결과에 대해 설명하시오'''

library(KoNLP)
library(tm)
library(multilinguer)
library(wordcloud)
library(wordcloud2)
library(stringr)
library(tidytext)

setwd('c:/Rwork')
raw_zel <- readLines("zelensky.txt", encoding = "UTF-8")
head(raw_zel)

#우크라이나 단어 추가
user_dic <- data.frame(term = c("우크라이나", "러시아"), tag = "ncn")
buildDictionary(ext_dic = "sejong", user_dic = user_dic)

####1번(단어구름)####
#유의어 수정
raw_zel <- str_replace_all(raw_zel, "사람들", "사람")
raw_zel <- str_replace_all(raw_zel, "영웅들", "영웅")
raw_zel <- str_replace_all(raw_zel, "당신들이", "당신")

#명사 추출
exNouns <- function(x){paste(extractNoun(as.character(x)), collapse = " ")}

zel_nouns <- sapply(raw_zel, exNouns)
zel_nouns[1]

#단어 대상 전처리하기
zelcorpus <- Corpus(VectorSource(zel_nouns))

#문장부호 제거
zelcorpus2 <- tm_map(zelcorpus, removePunctuation)
#수치 제거
zelcorpus2 <- tm_map(zelcorpus, removeNumbers)
#소문자 변경 
zelcorpus2 <- tm_map(zelcorpus, tolower)
#불용어 제거 
myStopwords = c(stopwords('english'),
                "때문", "이것", "그것", "들이", "해서",
                "무엇", "저들", "이번", "우린", "우리")

zelcorpus2 <- tm_map(zelcorpus, removeWords, myStopwords)

#전처리 결과 확인
inspect(zelcorpus2)

#단어 선별하기
zelcorpus3 <- TermDocumentMatrix(zelcorpus2,
                                 control = list(wordLengths = c(4, 16)))
zelcorpus3

#데이터프레임으로 변경
zelcor_df2 <- as.data.frame(as.matrix(zelcorpus3), stringsAsFactors = F)
dim(zelcor_df2)

#빈도수 구하기
wordResult2 <- sort(rowSums(zelcor_df2), decreasing=TRUE)
wordResult2[1:50]

#단어 구름 적용
zelname <- names(wordResult2)
word.df <- data.frame(word = zelname, freq=wordResult2)

#빈도수 2 이상 
word.df2 <- subset(word.df, subset = freq >= 2)
head(word.df2)
str(word.df2)

#단어 색상과 글꼴 지정
wordcloud2(data = word.df2, 
           size = 1, color = 'random-light', gridSize = 1,
           backgroundColor="black"
           , maxRotation = -pi/5, minRotation = -pi/2, shape = "circle")

####2번 연관어 분석 ####
raw_zel2 <- readLines("zelensky.txt", encoding = "UTF-8")

#줄 단위 단어 추출
lword <- Map(extractNoun, raw_zel2)
length(lword)
lword <- unique(lword)
length(lword)

#중복 단어 제거와 추출 단어 확인
lword <- sapply(lword, unique)
length(lword)
lword

#연관어 분석을 위한 전처리
#필터링 함수 정의
filter1 <- function(x){
  nchar(x) <= 10 && nchar(x) >=2 && is.hangul(x)
}
filter2 <- function(x){Filter(filter1, x)}

#줄 단위로 처리된 단어 전처리 
lword <- sapply(lword, filter2)
lword

#트랜잭션 생성
library(arules)

#트랜잭션 생성
wordtran <- as(lword, "transactions")
wordtran

#연관규칙 발견하기
library(backports)

#연관규칙
tranrules <- apriori(wordtran, parameter = list(supp=0.04, conf = 0.6))

#연관규칙 생성 결과보기
#detach(package:tm, unload =TRUE)
inspect(head(sort(tranrules, by = "lift")))

#연관어 시각화
rules <- labels(tranrules)
rules

#행렬구조로 변경
rules <- sapply(rules, strsplit, " ", USE.NAMES = F)
rules

#행 단위로 묶어서 matrix로 변환
rulemat <- do.call("rbind", rules)
class(rulemat)
rulemat

#edgelist #single 객체만 시각화
library(igraph)
ruleg <- graph.edgelist(rulemat[c(1:60),-2], directed = F)
plot.igraph(ruleg, vertex.label = V(ruleg)$name,
            edge.lty = "solid", edge.width = 1.5,
            vertex.label.cex =1.2, vertex.label.color = 'black',
            vertex.size = 20, vertex.color = "#a1d76a",
            vertex.frame.color = "black")
# # ==================================================================

'''6. R의 ggplot2 패키지 내 함수와 python의 matplotlib 패키지 내 함수를 사용하여
막대 차트(가로, 세로), 누적막대 차트, 점 차트, 원형 차트, 상자 그래프, 히스토그램,
산점도, 중첩자료 시각화, 변수간의 비교 시각화, 밀도그래프를 수업자료pdf 내 데이터를
이용하여 각각 시각화하고 비교하시오'''

library(ggplot2)
library(reshape2)
library(GGally)

#데이터: 아이리스(iris)
data("iris")
visual_data <- iris
str(visual_data)


#6-1. 막대차트(가로)
#변수가 여러가지이므로 그룹화하여 진행
data <- aggregate(iris[,1:4], by = list(iris$Species),
                  FUN = mean)

data

mt.visual <- melt(data, id.vars = c('Group.1'))
mt.visual
head(mt.visual)

chart1 <- ggplot(mt.visual, aes(x = Group.1, y = value, 
                                group = variable, fill = variable)) +
  
  geom_bar(stat = "identity", position = "dodge") +
  xlab('Species') + ylab('Values(mean)') + theme_light() +
  theme(text = element_text(size = 13),
        axis.text.x = element_text(angle = 0, hjust =.5),
        plot.title = element_text(hjust = 0.5),
        plot.subtitle = element_text(hjust = 0.5)) +
  coord_flip() +
  ggtitle("iris 가로 막대 그래프")

chart1 

#6-2. 막대차트(세로)
chart2 <- ggplot(mt.visual, aes(x = Group.1, y = value, 
                                group = variable, fill = variable)) +
  geom_bar(stat = "identity", position = "dodge") +
  xlab('Species') + ylab('Values(mean)') + theme_light()+
  theme(text = element_text(size = 13),
        axis.text.x = element_text(angle = 0, hjust =.5),
        plot.title = element_text(hjust = 0.5),
        plot.subtitle = element_text(hjust = 0.5)) +
  ggtitle("iris 세로 막대 그래프")

chart2
gridExtra::grid.arrange(chart1, chart2, ncol = 1)

#6-3. 누적막대 차트
chart3 <- ggplot(mt.visual, aes(x = Group.1, y = value, 
                                group = variable, fill = variable)) +
  
  geom_bar(stat = "identity", position = "stack") +
  xlab('Species') + ylab('Values(mean)') + theme_light() +
  theme(text = element_text(size = 13),
        axis.text.x = element_text(angle = 0, hjust =.5),
        plot.title = element_text(hjust = 0.5),
        plot.subtitle = element_text(hjust = 0.5)) +
  ggtitle("iris 누적 그래프")

chart3 

###position=stack

#6-4. 점 차트
#1번에서 그룹화한 데이터 이용
str(data)
mt.visual
chart4 <- ggplot(mt.visual, aes(x = Group.1, y = value,
                                group = variable, color = variable))+
  geom_point(shape = 19, size = 5) + 
  xlab('Species') + ylab('Values(mean)') + theme_light()+
  theme(text = element_text(size = 13),
        axis.text.x = element_text(angle = 0, hjust =.5),
        plot.title = element_text(hjust = 0.5),
        plot.subtitle = element_text(hjust = 0.5))+
  labs(color = "Variable") +
  ggtitle("iris 점 차트")

chart4

#6-5. 원형 차트
#ggplot에서 pie chart를 그리려면, bar plot을 만들어서 원형으로 변경해야 한다.
#백분율 data로  변경해 주어야 한다.
#범주화해서 진행하기.
visual_data2 <- visual_data
visual_data2

#Sepal.Length
min(visual_data2$Sepal.Length)
max(visual_data2$Sepal.Length)
table(visual_data2$Sepal.Length)
visual_data2$Sepal.Length2[visual_data2$Sepal.Length >= 4 & visual_data2$Sepal.Length <5] <- 1 
visual_data2$Sepal.Length2[visual_data2$Sepal.Length >= 5 & visual_data2$Sepal.Length <6] <- 2
visual_data2$Sepal.Length2[visual_data2$Sepal.Length >= 6 & visual_data2$Sepal.Length <7] <- 3
visual_data2$Sepal.Length2[visual_data2$Sepal.Length >= 7 ] <- 4
pie_data1 <- as.data.frame(table(visual_data2$Sepal.Length2))
pie_data1

pie_data1$RF <- round(pie_data1$Freq/150, 3)
pie_data1

chart5 <- ggplot(pie_data1, aes(x="", y =RF, fill = Var1))+
  geom_bar(stat = "identity") + coord_polar("y") +
  theme_light() +
  
  geom_text(aes(label = paste0(round(RF*100,1),"%")),
            position = position_stack(vjust = 0.5)) +
  
  theme(text = element_text(size = 13),
        plot.title = element_text(hjust = 0.5),
        plot.subtitle = element_text(hjust = 0.5),
        axis.text.x = element_blank())+
  ylab("") + xlab("") + labs(subtitle = "Sepal.Length 범주별 비율", title = "iris 원형 그래프") +
  scale_fill_discrete(name = "범주", labels = c("4cm이상 5cm미만", "5cm이상 6cm미만", "6cm이상 7cm미만", "7cm이상"))

chart5

#Sepal.Width
min(visual_data2$Sepal.Width)
max(visual_data2$Sepal.Width)
table(visual_data2$Sepal.Width)
visual_data2$Sepal.Width2[visual_data2$Sepal.Width >= 2 & visual_data2$Sepal.Width <3] <- 1 
visual_data2$Sepal.Width2[visual_data2$Sepal.Width >= 3 & visual_data2$Sepal.Width <4] <- 2
visual_data2$Sepal.Width2[visual_data2$Sepal.Width >= 4 ] <- 3

pie_data2 <- as.data.frame(table(visual_data2$Sepal.Width2))
pie_data2

pie_data2$RF <- round(pie_data2$Freq/150, 3)
pie_data2

chart6 <- ggplot(pie_data2, aes(x="", y =RF, fill = Var1))+
  geom_bar(stat = "identity") + coord_polar("y") +
  theme_light() +
  
  geom_text(aes(label = paste0(round(RF*100,1),"%")),
            position = position_stack(vjust = 0.5)) +
  
  theme(text = element_text(size = 13),
        plot.title = element_text(hjust = 0.5),
        plot.subtitle = element_text(hjust = 0.5),
        axis.text.x = element_blank())+
  ylab("") + xlab("") + labs(subtitle = "Sepal.Width 범주별 비율", title = "iris 원형 그래프") +
  scale_fill_discrete(name = "범주", labels = c("2cm이상 3cm미만", "3cm이상 4cm미만", "4cm이상"))

chart6

#Petal.Length
min(visual_data2$Petal.Length)
max(visual_data2$Petal.Length)
table(visual_data2$Petal.Length)
visual_data2$Petal.Length2[visual_data2$Petal.Length >= 1 & visual_data2$Petal.Length <4] <- 1 
visual_data2$Petal.Length2[visual_data2$Petal.Length >= 4 & visual_data2$Petal.Length <6] <- 2
visual_data2$Petal.Length2[visual_data2$Petal.Length >= 6 ] <- 3

pie_data3 <- as.data.frame(table(visual_data2$Petal.Length2))
pie_data3

pie_data3$RF <- round(pie_data3$Freq/150, 3)
pie_data3

chart7 <- ggplot(pie_data3, aes(x="", y =RF, fill = Var1))+
  geom_bar(stat = "identity") + coord_polar("y") +
  theme_light() +
  
  geom_text(aes(label = paste0(round(RF*100,1),"%")),
            position = position_stack(vjust = 0.5)) +
  
  theme(text = element_text(size = 13),
        plot.title = element_text(hjust = 0.5),
        plot.subtitle = element_text(hjust = 0.5),
        axis.text.x = element_blank())+
  ylab("") + xlab("") + labs(subtitle = "Petal.Length 범주별 비율", title = "iris 원형 그래프") +
  scale_fill_discrete(name = "범주", labels = c("1cm이상 4cm미만", "4cm이상 6cm미만", "6cm이상"))

chart7
#Petal.Width
min(visual_data2$Petal.Width)
max(visual_data2$Petal.Width)
table(visual_data2$Petal.Width)
visual_data2$Petal.Width2[visual_data2$Petal.Width >= 0 & visual_data2$Petal.Width <1] <- 1 
visual_data2$Petal.Width2[visual_data2$Petal.Width >= 1 & visual_data2$Petal.Width <2] <- 2
visual_data2$Petal.Width2[visual_data2$Petal.Width >= 2 ] <- 3

pie_data4 <- as.data.frame(table(visual_data2$Petal.Width2))
pie_data4

pie_data4$RF <- round(pie_data4$Freq/150, 3)
pie_data4

chart8 <- ggplot(pie_data4, aes(x="", y =RF, fill = Var1))+
  geom_bar(stat = "identity") + coord_polar("y") +
  theme_light() +
  
  geom_text(aes(label = paste0(round(RF*100,1),"%")),
            position = position_stack(vjust = 0.5)) +
  
  theme(text = element_text(size = 13),
        plot.title = element_text(hjust = 0.5),
        plot.subtitle = element_text(hjust = 0.5),
        axis.text.x = element_blank())+
  ylab("") + xlab("") + labs(subtitle = "Petal.Width 범주별 비율", title = "iris 원형 그래프") +
  scale_fill_discrete(name = "범주", labels = c("1cm 미만", "1cm이상 2cm미만", "2cm이상"))

chart8

gridExtra::grid.arrange(chart5, chart6, chart7, chart8, ncol = 2)

#6-6. 상자 그래프(box plot)
head(visual_data)
par(mfrow = c(2,2))
#Sepal.Length
chart9 <- ggplot(data = visual_data, aes(x = Species, y = Sepal.Length,
                                         fill = Species)) +
  theme_light()+
  theme(text = element_text(size = 13),
        axis.text.x = element_text(angle = 0, hjust =.5),
        plot.title = element_text(hjust = 0.5),
        plot.subtitle = element_text(hjust = 0.5))+
  geom_boxplot(aes(fill = Species), outlier.shape = 21, outlier.size= 4) + 
  ggtitle("iris 상자 그래프") +
  ylab(" ") + xlab(" ") + labs(subtitle = "Sepal.Length")

chart10 <- ggplot(data = visual_data, aes(x = Species, y = Sepal.Width,
                                          fill = Species)) +
  theme_light()+
  theme(text = element_text(size = 13),
        axis.text.x = element_text(angle = 0, hjust =.5),
        plot.title = element_text(hjust = 0.5),
        plot.subtitle = element_text(hjust = 0.5))+
  geom_boxplot(aes(fill = Species), outlier.shape = 21, outlier.size= 4) + 
  ggtitle("iris 상자 그래프") +
  ylab(" ") + xlab(" ") + labs(subtitle = "Sepal.Width")

chart11 <- ggplot(data = visual_data, aes(x = Species, y = Petal.Length,
                                          fill = Species)) +
  theme_light()+
  theme(text = element_text(size = 13),
        axis.text.x = element_text(angle = 0, hjust =.5),
        plot.title = element_text(hjust = 0.5),
        plot.subtitle = element_text(hjust = 0.5))+
  geom_boxplot(aes(fill = Species), outlier.shape = 21, outlier.size = 4) + 
  ggtitle("iris 상자 그래프") +
  ylab(" ") + xlab(" ") + labs(subtitle = "Petal.Length")

chart11

chart12 <- ggplot(data = visual_data, aes(x = Species, y = Petal.Width,
                                          fill = Species)) +
  theme_light()+
  theme(text = element_text(size = 13),
        axis.text.x = element_text(angle = 0, hjust =.5),
        plot.title = element_text(hjust = 0.5),
        plot.subtitle = element_text(hjust = 0.5))+
  geom_boxplot(aes(fill = Species), outlier.shape = 21, outlier.size = 4) + 
  ggtitle("iris 상자 그래프") +
  ylab(" ") + xlab(" ") + labs(subtitle = "Petal.Width")

chart12

gridExtra::grid.arrange(chart9, chart10, chart11, chart12, ncol = 2)

#6-7. 히스토그램 (누적 그래프와 분포 동일/종으로 나뉘지 않는다는 점이 다름)
chart13 <- ggplot(visual_data, aes(x = Sepal.Length)) +
  theme_light()+
  geom_histogram(fill = "#FFB266", color = "white") +
  theme(text = element_text(size = 13),
        axis.text.x = element_text(angle = 0, hjust =.5),
        plot.title = element_text(hjust = 0.5),
        plot.subtitle = element_text(hjust = 0.5))+
  ggtitle("iris 히스토그램") +
  xlab(" ") + labs(subtitle = "Sepal.Length")

chart14 <- ggplot(visual_data, aes(x = Sepal.Width)) + 
  theme_light()+ 
  geom_histogram(fill = "#FFB266", color = "white") +
  theme(text = element_text(size = 13),
        axis.text.x = element_text(angle = 0, hjust =.5),
        plot.title = element_text(hjust = 0.5),
        plot.subtitle = element_text(hjust = 0.5))+
  ggtitle("iris 히스토그램") +
  xlab(" ") + labs(subtitle = "Sepal.Width")

chart15 <- ggplot(visual_data, aes(x = Petal.Length)) + 
  theme_light()+ 
  geom_histogram(fill = "#FFB266", color = "white") +
  theme(text = element_text(size = 13),
        axis.text.x = element_text(angle = 0, hjust =.5),
        plot.title = element_text(hjust = 0.5),
        plot.subtitle = element_text(hjust = 0.5))+
  ggtitle("iris 히스토그램") +
  xlab(" ") + labs(subtitle = "Petal.Length")

chart15

chart16 <- ggplot(visual_data, aes(x = Petal.Width)) + 
  theme_light()+ 
  geom_histogram(fill = "#FFB266", color = "white") +
  theme(text = element_text(size = 13),
        axis.text.x = element_text(angle = 0, hjust =.5),
        plot.title = element_text(hjust = 0.5),
        plot.subtitle = element_text(hjust = 0.5))+
  ggtitle("iris 히스토그램") +
  xlab(" ") + labs(subtitle = "Petal.Length")

chart16

gridExtra::grid.arrange(chart13, chart14, chart15, chart16, ncol = 2)

#6-8. 산점도
chart17 <- ggplot(visual_data, aes(Sepal.Length, Sepal.Width, col = Species,
                                   size = 3))+
  theme_light()+
  theme(text = element_text(size = 13),
        axis.text.x = element_text(angle = 0, hjust =.5),
        plot.title = element_text(hjust = 0.5),
        plot.subtitle = element_text(hjust = 0.5))+
  labs(title = "iris 산점도 그래프", subtitle = "Sepal.Width & Sepal.Length") +
  geom_point()
chart17

chart18 <- ggplot(visual_data, aes(Petal.Length, Petal.Width, col = Species,
                                   size = 3))+
  theme_light()+
  theme(text = element_text(size = 13),
        axis.text.x = element_text(angle = 0, hjust =.5),
        plot.title = element_text(hjust = 0.5),
        plot.subtitle = element_text(hjust = 0.5))+
  labs(title = "iris 산점도 그래프", subtitle = "Petal.Width & Petal.Length") +
  geom_point()

chart18

gridExtra::grid.arrange(chart17, chart18, ncol = 2)

#6-9. 중첩자료 시각화
irisdata <- data.frame(table(visual_data$Sepal.Length, visual_data$Sepal.Width))
names(irisdata) <- c("Sepal.Length", "Sepal.Width", "freq")

chart19 <- ggplot(data = irisdata, aes(x = Sepal.Length, y = Sepal.Width)) +
  scale_size(range = c(1,20), guide = 'none') +
  geom_point(colour = "grey90", aes(size =freq)) +
  geom_point(aes(colour=freq, size=freq))+
  scale_colour_gradient(low="5", high = "blue")+
  geom_smooth(formula = y~x, method = lm, se = FALSE) +
  theme_light()+
  
  theme(text = element_text(size = 13),
        axis.text.x = element_text(angle = 0, hjust =.5),
        plot.title = element_text(hjust = 0.5),
        plot.subtitle = element_text(hjust = 0.5))+
  labs(title = "iris 중첩자료", subtitle = "Sepal.Width & Sepal.Length")

chart19

irisdata2 <- data.frame(table(visual_data$Petal.Length, visual_data$Petal.Width))
names(irisdata2) <- c("Petal.Length", "Petal.Width", "freq")

chart20 <- ggplot(data = irisdata2, aes(x = Petal.Length, y = Petal.Width)) +
  scale_size(range = c(1,20), guide = 'none') +
  geom_point(colour = "grey90", aes(size =freq)) +
  geom_point(aes(colour=freq, size=freq))+
  scale_colour_gradient(low="5", high = "blue")+
  geom_smooth(formula = y~x, method = lm, se = FALSE) +
  theme_light() + 
  
  theme(text = element_text(size = 13),
        axis.text.x = element_text(angle = 0, hjust =.5),
        plot.title = element_text(hjust = 0.5),
        plot.subtitle = element_text(hjust = 0.5))+
  labs(title = "iris 중첩자료", subtitle = "Petal.Width & Petal.Length")

chart20

gridExtra::grid.arrange(chart19, chart20, ncol = 1)


#6-10. 변수간의 비교 시각화
#install.packages("GGally") #ggplot2를 extend해주는 패키지(pairs 사용을 위해)
chart21 <- ggpairs(visual_data,
                   aes(color = Species,
                       alpha = 0.5)) + theme_bw()+
  theme(text = element_text(size = 13),
        axis.text.x = element_text(angle = 0, hjust =.5),
        plot.title = element_text(hjust = 0.5)) +
  labs(title = "iris 변수간 비교")

chart21

#6-11. 밀도그래프
chart21 <- ggplot(visual_data) +
  theme_light() +
  stat_density(mapping=aes(x=Sepal.Width, fill = Species, alpha=3/5), 
               colour = "black", position = "identity") +
  theme(text = element_text(size = 13),
        axis.text.x = element_text(angle = 0, hjust =.5),
        plot.title = element_text(hjust = 0.5)) +
  labs(title = "iris 밀도 그래프" )

chart21

chart22 <- ggplot(visual_data) +
  theme_light() +
  stat_density(mapping=aes(x=Sepal.Length, fill = Species, alpha=3/5), 
               colour = "black",position = "identity") +
  theme(text = element_text(size = 13),
        axis.text.x = element_text(angle = 0, hjust =.5),
        plot.title = element_text(hjust = 0.5)) +
  labs(title = "iris 밀도 그래프" )

chart23 <- ggplot(visual_data) +
  theme_light() +
  stat_density(mapping=aes(x=Petal.Width, fill = Species, alpha=3/5),
               colour = "black", position = "identity")+
  theme(text = element_text(size = 13),
        axis.text.x = element_text(angle = 0, hjust =.5),
        plot.title = element_text(hjust = 0.5)) +
  labs(title = "iris 밀도 그래프" )

chart24 <- ggplot(visual_data) +
  theme_light() +
  stat_density(mapping=aes(x=Petal.Length, fill = Species, alpha=3/5),
               colour = "black", position = "identity") +
  theme(text = element_text(size = 13),
        axis.text.x = element_text(angle = 0, hjust =.5),
        plot.title = element_text(hjust = 0.5)) +
  labs(title = "iris 밀도 그래프" )


gridExtra::grid.arrange(chart21, chart22, chart23, chart24, ncol = 2)


