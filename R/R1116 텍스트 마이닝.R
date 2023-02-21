# KoNLP 설치
install.packages("multilinguer")
library(multilinguer)
install_jdk()
install.packages("remotes")
remotes::install_github("haven-jeon/KoNLP",
              upgrade = "never", INSTALL_opts = c("--no-multiarch"))
# 필요 package 설치
install.packages(c("stringr", "hash", "tau", "Sejong", "RSQLite", "devtools"),
                 type = "binary")
install.packages("rJava")
install.packages('wordcloud')
install.packages('tm')
library(KoNLP)
useNIADic()

# 실습: 형태소 분석을 위한 KoNLP 패키지 설치
install.packages("https://cran.rstudio.com/bin/windows/contrib/3.4/KoNLP_0.80.1.zip",
                 repos = NULL)
# 실습: 한글 사전과 텍스트 마이닝 관련 패키지 설치
install.packages("Sejong")
install.packages("wordcloud")
install.packages("tm")
# 실습: 패키지 로딩
#library(KoNLP)
install.packages("hash")
install.packages("tau")
install.packages("devtools")
install.packages("RSQLite")
library(KoNLP)
library(tm)
library(wordcloud)
# 실습: 텍스트 자료 가져오기
# facebook_bigdata.txt 필요!
setwd('C:\\Rwork\\dataset3\\dataset3')
facebook <- file("facebook_bigdata.txt", encoding = "UTF-8")
facebook_data <- readLines(facebook)
head(facebook_data)
# 실습: 세종 사전에 단어 추가하기
user_dic <- data.frame(term = c("R 프로그래밍", "페이스북", "홍길동", "소셜네트워크"),
                       tag = 'ncn')
buildDictionary(ext_dic = "sejong", user_dic = user_dic)
# 실습: R 제공 함수로 단어 추출하기 
paste(extractNoun('홍길동은 많은 사람과 소통을 위해서 소셜네트워크에
가입하였습니다.'),collapse = " ")

#p.4
# 실습: 단어 추출을 위한 사용자 함수 정의하기
# 단계 1: 사용자 정의 함수 작성
exNouns <- function(x) {paste(extractNoun(as.character(x)), collapse = " ") }
# 단계 2: exNouns() 함수를 이용하여 단어 추출
facebook_nouns <- sapply(facebook_data, exNouns)
facebook_nouns[1]

# 실습: 추출된 단어를 대상으로 전처리하기
# 단계 1: 추출된 단어를 이용하여 말뭉치(Corpus) 생성
myCorpus <-Corpus(VectorSource(facebook_nouns))
# 단계 2: 데이터 전처리
# 단계 2-1: 문장부호 제거
myCorpusPrepro <- tm_map(myCorpus, removePunctuation)
# 단계 2-2: 수치 제거
myCorpusPrepro <- tm_map(myCorpusPrepro, removeNumbers)
# 단계 2-3: 소문자 변경
myCorpusPrepro <- tm_map(myCorpusPrepro, tolower)
# 단계 2-4: 불용어 제거
myCorpusPrepro <- tm_map(myCorpusPrepro, removeWords, stopwords('english'))
# 단계 2-5: 전처리 결과 확인
inspect(myCorpusPrepro[1:5])

# 실습: 단어 선별(2 ~ 8 음절 사이 단어 선택)하기
# 단계 1: 전처리된 단어집에서 2 ~ 8 음절 단어 대상 선정
myCorpusPrepro_term <-
  TermDocumentMatrix(myCorpusPrepro, 
                     control = list(wordLengths = c(4, 16)))
myCorpusPrepro_term
# 단계 2: matrix 자료구조를 data.frame 자료구조로 변경
myTerm_df <- as.data.frame(as.matrix(myCorpusPrepro_term))
dim(myTerm_df)
# 실습: 단어 출현 빈도수 구하기
wordResult <- sort(rowSums(myTerm_df), decreasing = TRUE)
wordResult[1:10]


# 실습: 불용어 제거하기
# 단계 1: 데이터 전처리
# 단계 1-1: 문장부호 제거
myCorpusPrepro <- tm_map(myCorpus, removePunctuation)
# 단계 1-2: 수치 제거
myCorpusPrepro <- tm_map(myCorpusPrepro, removeNumbers)
# 단계 1-3: 소문자 변경
myCorpusPrepro <- tm_map(myCorpusPrepro, tolower)
# 단계 1-4: 제거할 단어 지정
myStopwords = c(stopwords('english'), "사용", "하기")
# 단계 1-5: 불용어 제거
myCorpusPrepro <- tm_map(myCorpusPrepro, removeWords, myStopwords)
#단계 2: 단어 선별과 평서문 변환
myCorpusPrepro_term <-
  TermDocumentMatrix(myCorpusPrepro,
                     control = list(wordLengths = c(4, 16)))
myTerm_df <- as.data.frame(as.matrix(myCorpusPrepro_term))
# 단계 3: 단어 출현 빈도수 구하기
wordResult <- sort(rowSums(myTerm_df), decreasing = TRUE)
wordResult[1:10]

#p.6
# 실습: 단어 구름에 디자인(빈도수, 색상, 위치, 회전 등) 적용하기
# 단계 1: 단어 이름과 빈도수로 data.frame 생성
myName <- names(wordResult)
word.df <- data.frame(word = myName, freq = wordResult)
str(word.df)
# 단계 2: 단어 색상과 글꼴 지정
pal <- brewer.pal(12, "Paired")
# 단계 3: 단어 구름 시각화
wordcloud(word.df$word, word.df$freq, scale = c(5, 1), 
          min.freq = 3, random.order = F, 
          rot.per = .1, colors = pal, family = "malgun")



#P.7
# 실습: 한글 연관어 분석을 위한 패키지 설치와 메모리 로딩
#marketing.txt 필요!!!
# 단계 1: 텍스트 파일 가져오기
marketing <- file("marketing.txt", encoding = "UTF-8")
marketing2 <- readLines(marketing)
close(marketing)
head(marketing2)
# 단계 2: 줄 단위 단어 추출
lword <- Map(extractNoun, marketing2)
length(lword)
lword <- unique(lword)
length(lword)
# 단계 3: 중복 단어 제거와 추출 단어 확인
lword <- sapply(lword, unique)
length(lword)
lword

# 실습: 연관어 분석을 위한 전처리하기
# 단계 1: 단어 필터링 함수 정의
filter1 <- function(x) {
  nchar(x) <= 4 && nchar(x) >= 2 && is.hangul(x)
}
filter2 <- function(x) { Filter(filter1, x) }
# 단계 2: 줄 단위로 추출된 단어 전처리
lword <- sapply(lword, filter2)
lword

# 실습: 필터링 간단 예문 살펴보기
# 단계 1: vector 이용 list 객체 생성
word <- list(c("홍길동", "이순", "만기", "김"),
             c("대한민국", "우리나라대한민구", "한국", "resu"))
class(word)
# 단계 2: 단어 필터링 함수 정의(길이 2 ~ 4 사이 한글 단어 추출) 
filter1 <- function(x) {
  nchar(x) <= 4 && nchar(x) >= 2 && is.hangul(x)
}
filter2 <- function(x) {
  Filter(filter1, x)
}
# 단계 3: 함수 적용 list 객체 필터링
filterword <- sapply(word, filter2)
filterword

#p.8
# 실습: 트랜잭션 생성하기
# 단계 1: 연관분석을 위한 패키지 설치와 로딩
#https://cran.r-project.org/src/contrib/Archive/arules/
#version 1.6-6 다운로드 후 Rstudio에서 install
#install.packages("arules")
library(arules)
# 단계 2: 트랜잭션 생성
wordtran <- as(lword, "transactions")
wordtran

# 실습: 단어 간 연관규칙 발견하기
install.packages("backports")
library(backports) # to fix errors
# 단계 1: 연관규칙 발견
tranrules <- apriori(wordtran, parameter = list(supp = 0.25, conf = 0.05))
# 단계 2: 연관규칙 생성 결과보기
detach(package:tm, unload=TRUE)
inspect(tranrules)

# 실습: 연관규칙을 생성하는 간단한 예문 살펴보기
# 단계 1: Adult 데이터 셋 메모리 로딩
data("Adult")
Adult
str(Adult)
dim(Adult)
inspect(Adult)
# 단계 2: 특정 항목의 내용을 제외한 itermsets 수 발견
apr1 <- apriori(Adult,
          parameter = list(support = 0.1, target = "frequent"),
          appearance = list(none = 
          c("income=small", "income=large"),default = "both"))
apr1
inspect(apr1)
# 단계 3: 특정 항목의 내용을 제외한 rules 수 발견
apr2 <- apriori(Adult, 
          parameter = list(support = 0.1, target = "rules"), 
          appearance = list(none = 
          c("income=small", "income=large"),default = "both"))
apr2
# 단계 4: 지지도와 신뢰도 비율을 높일 경우
apr3 <- apriori(Adult, 
           parameter = list(supp = 0.5, conf = 0.9, target = "rules"),
           appearance = list(none =
           c("income=small", "income=large"),default = "both"))
apr3
# 실습: inspect() 함수를 사용하는 간단 예문 보기
data(Adult)
rules <- apriori(Adult)
inspect(rules[10])


#p.11
# 연관어 시각화하기
# 단계 1: 연관단어 시각화를 위해서 자료구조 변경
rules <- labels(tranrules, ruleSep = " ")
rules
# 단계 2: 문자열로 묶인 연관 단어를 행렬구조로 변경
rules <- sapply(rules, strsplit, " ", USE.NAMES = F)
rules
# 단계 3: 행 단위로 묶어서 matrix로 변환
rulemat <- do.call("rbind", rules)
class(rulemat)
# 단계 4: 연관어 시각화를 위한 igraph 패키지 설치와 로딩
# install.packages("igraph")
# install.packages("igraph", type=igraph)
install.packages('igraph', type='binary')
library(igraph)
# 단계 5: edgelist 보기
ruleg <- graph.edgelist(rulemat[c(12:59), ], directed = F)
ruleg
# 단계 6: edgelist 시각화
plot.igraph(ruleg, vertex.label = V(ruleg)$name, 
            vertex.label.cex = 1.2, vertext.label.color = 'black',
            vertex.size = 20, vertext.color = 'green',
            vertex.frame.co.or = 'blue')








#p.12 실시간 뉴스 수집과 분석
# 실습: 웹 문서 요청과 파싱 관련 패키지 설치 및 로딩
install.packages("httr")
library(httr)
install.packages("XML")
library(XML)

#(2) url 요청
# 실습: 웹 문서 요청
url <- "http://media.daum.net"
web <- GET(url)
web

#(3) HTML 파싱
# 실습: HTML 파싱하기
html <- htmlTreeParse(web, useInternalNodes = T, trim = T, encoding = "utf-8")
rootNode <- xmlRoot(html)

#(4) 태그(tag) 자료 수집
# 실습: 태그 자료 수집하기
news <- xpathSApply(rootNode, "//a[@class = 'link_txt']", xmlValue)
news

#(5) 수집한 자료 전처리
# 실습: 자료 전처리하기
# 단계 1: 자료 전처리 - 수집한 문서를 대상으로 불용어 제거
news_pre <- gsub("[\r\n\t]", ' ', news)
news_pre <- gsub('[[:punct:]]', ' ', news_pre)
news_pre <- gsub('[[:cntrl:]]', ' ', news_pre)
# news_pre <- gsub('\\d+', ' ', news_pre) # corona19(covid19) 때문에 숫자 제거 생략
news_pre <- gsub('[a-z]+', ' ', news_pre)
news_pre <- gsub('[A-Z]+', ' ', news_pre)
news_pre <- gsub('\\s+', ' ', news_pre)
news_pre

# 단계 2: 기사와 관계 없는 'TODAY', '검색어 순위' 등의 내용은 제거
news_data <- news_pre[1:59]
news_data

#(6) 파일 저장 및 읽기
# 실습: 수집한 자료를 파일로 저장하고 읽기
setwd("C:/Rwork/") 
write.csv(news_data, "news_data.csv", quote = F)
news_data <- read.csv("news_data.csv", header = T, stringsAsFactors = F)
str(news_data)
names(news_data) <- c("no", "news_text")
head(news_data)
news_text <- news_data$news_text
news_text

#(7) 토픽분석
# 실습: 세종 사전에 단어 추가
user_dic <- data.frame(term = c("펜데믹", "코로나19", "타다"), tag = 'ncn')
buildDictionary(ext_dic = 'sejong', user_dic = user_dic)
# 실습: 단어 추출 사용자 함수 정의하기
# 단계 1: 사용자 정의 함수 작성
exNouns <- function(x) { paste(extractNoun(x), collapse = " ")}
# 단계 2: exNouns() 함수를 이용하어 단어 추출
news_nouns <- sapply(news_text, exNouns)
news_nouns
# 단계 3: 추출 결과 확인
str(news_nouns)

#p.15
library(tm)
# 실습: 말뭉치 생성과 집계 행렬 만들기
# 단계 1: 추출된 단어를 이용한 말뭉치(corpus) 생성
newsCorpus <- Corpus(VectorSource(news_nouns))
newsCorpus
inspect(newsCorpus[1:5]) 
# 단계 2: 단어 vs 문서 집계 행렬 만들기
TDM <- TermDocumentMatrix(newsCorpus, control = list(wordLengths = c(4, 16)))
TDM
# 단계 3: matrix 자료구조를 data.frame 자료구조로 변경
tdm.df <- as.data.frame(as.matrix(TDM))
dim(tdm.df)
# 실습: 단어 출현 빈도수 구하기
wordResult <- sort(rowSums(tdm.df), decreasing = TRUE)
wordResult[1:10]

# 실습: 단어 구름 생성
# 단계 1: 패키지 로딩과 단어 이름 추출
library(wordcloud)
myNames <- names(wordResult)
myNames
# 단계 2: 단어와 단어 빈도수 구하기
df <- data.frame(word = myNames, freq = wordResult)
head(df)
# 단계 3: 단어 구름 생성
pal <- brewer.pal(12, "Paired") ## s 대신 l로 대체
wordcloud(df$word, df$freq, min.freq = 2,
          random.order = F, scale = c(4, 0.7),
          rot.per = .1, colors = pal, family = "malgun") #pas --> pa


#p.17
##### Wordcloud2
library(devtools)
devtools::install_github("lchiffon/wordcloud2")
# install_github("lchiffon/wordcloud2")
library(wordcloud2)
wordcloud2(data = demoFreq)
# 사용법
# https://cran.r-project.org/web/packages/wordcloud2/vignettes/wordcloud.html
# https://www.r-graph-gallery.com/196-the-wordcloud2-library.html
wc2data <- data.frame(df$word, df$freq)
wc2data
wordcloud2(data=wc2data, size=1.6, color='random-dark')
wordcloud2(data=wc2data, size=1.6, color='random-light', backgroundColor = "black")
