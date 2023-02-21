############텍스트 데이터 분석
#####김용현

#문항1
setwd('C:/Rwork')
#1)
library(KoNLP)
data <- file('젤렌스키_연설문_20220219.txt', encoding = "UTF-8")
data1 <- readLines(data)
head(data1)
#2)
library(dplyr)
library(stringr)
#데이터 전처리하기
data2 <- data1 %>%
  str_replace_all("[^가-힣]", " ") %>% 
  str_squish() %>% as_tibble()


library(tidytext)
#토큰화 하기
word_space <- data2 %>%
  unnest_tokens(input = value,output = word,token = "words")
word_space
#3)
#단어 빈도구하기
word_space <- word_space %>% count(word, sort = T)
word_space
#빈도수가 2회 이상만 남기기
word_space <- word_space %>%filter(n >= 2)
word_space
#4)
library(wordcloud2)
wordcloud2(data = word_space, color='random-light', backgroundColor = "black")



#문항2
setwd('C:\\Rwork\\TM-dataset')
#1)
library(KoNLP)
library(dplyr)
library(readr)
raw_comment <- read_csv("Itaewon_text1.txt",col_names = 'reply' )
glimpse(raw_comment)
#데이터 전처리
library(textclean)
comment <- raw_comment %>%
  mutate(id = row_number(),reply = str_squish(replace_html(reply)))
glimpse(comment)
# 토큰화
library(tidytext)
comment <- comment %>%
  unnest_tokens(input = reply, output = word,
                token = "words",drop = F)
comment %>%select(word, reply)
#2)
dic <- read_csv("knu_sentiment_lexicon.csv")
# 단어에 감정 점수 부여
comment <- comment %>%
  left_join(dic, by = "word") %>%
  mutate(polarity = ifelse(is.na(polarity), 0, polarity))
comment %>% select(word, polarity) %>%arrange(-polarity)
comment <- comment %>% group_by(id, reply) %>%
  summarise(score = sum(polarity)) %>%ungroup()
comment %>%select(score, reply) %>%arrange(-score)
# -1 시민들은 국가가 참사를 방치했다고 입을 모았다. ~
