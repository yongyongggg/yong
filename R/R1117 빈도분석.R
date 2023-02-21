#######단어 빈도 분석
setwd('C:\\Rwork\\TM-dataset')
#p.2
#텍스트 전처리
raw_moon <- readLines("speech_moon.txt", encoding = "UTF-8")
head(raw_moon)
#aw_moon의 불필요한 문자 제거하기
library(stringr)
moon <- raw_moon %>% str_replace_all("[^가-힣]", " ")
head(moon)
#moon에 있는 연속된 공백 제거하기
moon <- moon %>%str_squish()
head(moon)
#문자열 벡터를 tibble 구조로 바꾸기 - as_tibble()
library(dplyr)
moon <- as_tibble(moon)
moon
#전처리 작업 한 번에 하기
moon <- raw_moon %>%
  str_replace_all("[^가-힣]", " ") %>% # 한글만 남기기
  str_squish() %>% # 연속된 공백 제거
  as_tibble() # tibble로 변환

#p.13 토큰화하기
library(tidytext)
word_space <- moon %>%
  unnest_tokens(input = value,output = word,token = "words")
word_space

#p.19 단어 빈도 분석하기
word_space <- word_space %>% count(word, sort = T)
word_space
#두 글자 이상만 남기기
word_space <- word_space %>%filter(str_count(word) > 1)
word_space
#한 번에 작업하기
#빈도 내림차순 정렬 후 두 글자 이상 단어 남기기
word_space <- word_space %>%count(word, sort = T) %>%filter(str_count(word) > 1)
#자주 사용된 단어 추출하기
top20 <- word_space %>%head(20)
top20
#막대 그래프 만들기 - geom_col()
library(ggplot2)
ggplot(top20, aes(x = reorder(word, n), y = n)) + # 단어 빈도순 정렬
            geom_col() +
            coord_flip() # 회전
#그래프 다듬기
ggplot(top20, aes(x = reorder(word, n), y = n)) +
  geom_col() +
  coord_flip() +
  geom_text(aes(label = n), hjust = -0.3) + # 막대 밖 빈도 표시
  labs(title = "문재인 대통령 출마 연설문 단어 빈도", # 그래프 제목
       x = NULL, y = NULL) + # 축 이름 삭제
  theme(title = element_text(size = 12)) # 제목 크기
#워드 클라우드 만들기 - geom_text_wordcloud()
#install.packages("ggwordcloud")
library(ggwordcloud)
ggplot(word_space, aes(label = word, size = n)) +
  geom_text_wordcloud(seed = 1234) +
  scale_radius(limits = c(3, NA), # 최소, 최대 단어 빈도
               range = c(3, 30)) # 최소, 최대 글자 크기
#그래프 다듬기
ggplot(word_space,
       aes(label = word,
           size = n,
           col = n)) + # 빈도에 따라 색깔 표현
  geom_text_wordcloud(seed = 1234) +
  scale_radius(limits = c(3, NA),
               range = c(3, 30)) +
  scale_color_gradient(low = "#66aaf2", # 최소 빈도 색깔
                       high = "#004EA1") + # 최고 빈도 색깔
  theme_minimal() # 배경 없는 테마 적용
#그래프 폰트 바꾸기
install.packages("showtext")
library(showtext)
font_add_google(name = "Nanum Gothic", family = "nanumgothic")
showtext_auto()
#그래프에 폰트 지정하기
ggplot(word_space,aes(label = word,size = n,col = n)) +
  geom_text_wordcloud(seed = 1234,
                      family = "nanumgothic") + # 폰트 적용
  scale_radius(limits = c(3, NA),range = c(3, 25)) +
  scale_color_gradient(low = "#66aaf2",high = "#004EA1") +
  theme_minimal()
#'검은고딕' 폰트 적용
font_add_google(name = "Black Han Sans", family = "blackhansans")
showtext_auto()
ggplot(word_space,aes(label = word,size = n,col = n)) +
  geom_text_wordcloud(seed = 1234,
                      family = "blackhansans") + # 폰트 적용
  scale_radius(limits = c(3, NA),range = c(3, 30)) +
  scale_color_gradient(low = "#66aaf2",high = "#004EA1") +
  theme_minimal()



#p.45 분석도전
#Q1. speech_park.txt를 불러와 분석에 적합하게
#전처리한 다음 띄어쓰기 기준으로 토큰화하세요
raw_park <- readLines("speech_park.txt", encoding = "UTF-8")
# 전처리
library(dplyr)
library(stringr)
park <- raw_park %>%
  str_replace_all("[^가-힣]", " ") %>% # 한글만 남기기
  str_squish() %>% # 연속된 공백 제거
  as_tibble() # tibble로 변환
park
# 토큰화
library(tidytext)
word_space <- park %>%
  unnest_tokens(input = value,
                output = word,
                token = "words") # 띄어쓰기 기준
word_space
#Q2. 가장 자주 사용된 단어 20개를 추출하세요.
top20 <- word_space %>%
  count(word, sort = T) %>%
  filter(str_count(word) > 1) %>%
  head(20)
top20
#Q3. 가장 자주 사용된 단어 20개의 빈도를 나타낸 막대 그래프를 만드세요. 
#그래프의 폰트는 나눔고딕으로 설정하세요.
# 폰트 설정
library(showtext)
font_add_google(name = "Nanum Gothic", family = "nanumgothic")
showtext_auto()
# 막대 그래프 만들기
library(ggplot2)
ggplot(top20, aes(x = reorder(word, n), y = n)) +
  geom_col() +coord_flip () +
  geom_text(aes(label = n), hjust = -0.3) +labs(x = NULL) +
  theme(text = element_text(family = "nanumgothic"))

































