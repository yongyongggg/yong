#########형태속 분석

library(KoNLP)
library(dplyr)
#p.6 형태소 분석기를 이용해 토큰화하기 - 명사 추출
text <- tibble(value = c("대한민국은 민주공화국이다.",
            "대한민국의 주권은 국민에게 있고, 모든 권력은 국민으로부터 나온다."))
text
extractNoun(text$value)
#unnest_tokens()를 이용해 명사 추출하기
library(tidytext)
text %>%
  unnest_tokens(input = value, # 분석 대상
                output = word, # 출력 변수명
                token = extractNoun) # 토큰화 함수

#p.10 문재인 대통령 연설문 불러오기
setwd('C:\\Rwork\\TM-dataset')
raw_moon <- readLines("speech_moon.txt", encoding = "UTF-8")
#기본적인 전처리
library(stringr)
library(textclean)
moon <- raw_moon %>%
  str_replace_all("[^가-힣]", " ") %>% # 한글만 남기기
  str_squish() %>% # 중복 공백 제거
  as_tibble() # tibble로 변환
moon
#명사 기준 토큰화
word_noun <- moon %>%
  unnest_tokens(input = value,
                output = word,
                token = extractNoun)
word_noun


#P.14명사 빈도 분석하기
#단어 빈도 구하기
word_noun <- word_noun %>%
  count(word, sort = T) %>% # 단어 빈도 구해 내림차순 정렬
  filter(str_count(word) > 1) # 두 글자 이상만 남기기
word_noun
# 상위 20개 단어 추출
top20 <- word_noun %>%head(20)
# 막대 그래프 만들기
library(ggplot2)
ggplot(top20, aes(x = reorder(word, n), y = n)) +
  geom_col() +
  coord_flip() +
  geom_text(aes(label = n), hjust = -0.3) +
  labs(x = NULL) +
  theme(text = element_text(family = "nanumgothic"))
#워드 클라우드 만들기
# 폰트 설정
library(showtext)
font_add_google(name = "Black Han Sans", family = "blackhansans")
showtext_auto()

library(ggwordcloud)
ggplot(word_noun, aes(label = word, size = n, col = n)) +
  geom_text_wordcloud(seed = 1234, family = "blackhansans") +
  scale_radius(limits = c(3, NA),
               range = c(3, 15)) +
  scale_color_gradient(low = "#66aaf2", high = "#004EA1") +
  theme_minimal()



#P.23 특정 단어가 사용된 문장 살펴보기
#문장 기준으로 토큰화하기
sentences_moon <- raw_moon %>%
  str_squish() %>%
  as_tibble() %>%
  unnest_tokens(input = value,
                output = sentence,
                token = "sentences")
sentences_moon
#특정 단어가 들어 있는지 확인하기 - str_detect()
str_detect("치킨은 맛있다", "치킨")
str_detect("치킨은 맛있다", "피자")

sentences_moon %>% filter(str_detect(sentence, "국민"))
sentences_moon %>%filter(str_detect(sentence, "일자리"))




#P.33 분석도전
#Q1. speech_park.txt를 불러와 분석에 적합하게 전처리한 다음 연설문에서 명사를 추출하세요.
raw_park <- readLines("speech_park.txt", encoding = "UTF-8")
# 전처리
library(dplyr)
library(stringr)
park <- raw_park %>%
  str_replace_all("[^가-힣]", " ") %>% # 한글만 남기기
  str_squish() %>% # 연속된 공백 제거
  as_tibble() # tibble로 변환
park
# 명사 기준 토큰화
library(tidytext)
library(KoNLP)
word_noun <- park %>%
  unnest_tokens(input = value,
                output = word,
                token = extractNoun)
word_noun
#Q2. 가장 자주 사용된 단어 20개를 추출하세요.
top20 <- word_noun %>%count(word, sort = T) %>%
  filter(str_count(word) > 1) %>% head(20)
top20
#Q3. 가장 자주 사용된 단어 20개의 빈도를 나타낸 막대 그래프를 만드세요.
library(ggplot2)
ggplot(top20, aes(x = reorder(word, n), y = n)) +
  geom_col() +
  coord_flip () +
  geom_text(aes(label = n), hjust = -0.3) +
  labs(x = NULL)
#Q4. 전처리하지 않은 연설문에서 연속된 공백을 제거하고 
#tibble 구조로 변환한 다음 문장 기준으로 토큰화하세요.
sentences_park <- raw_park %>%
  str_squish() %>% # 연속된 공백 제거
  as_tibble() %>% # tibble로 변환
  unnest_tokens(input = value,
                output = sentence,
                token = "sentences")
sentences_park
#Q5. 연설문에서 "경제"가 사용된 문장을 출력하세요.
sentences_park %>% filter(str_detect(sentence, "경제"))

