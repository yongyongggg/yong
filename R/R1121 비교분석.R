#######단어 빈도 비교하기
library(dplyr)
setwd('C:\\Rwork\\TM-dataset')
# 문재인 대통령 연설문 불러오기
raw_moon <- readLines("speech_moon.txt", encoding = "UTF-8")
moon <- raw_moon %>%as_tibble() %>%mutate(president = "moon")
# 박근혜 대통령 연설문 불러오기
raw_park <- readLines("speech_park.txt", encoding = "UTF-8")
park <- raw_park %>%as_tibble() %>%mutate(president = "park")
#데이터 합치기
bind_speeches <- bind_rows(moon, park) %>%select(president, value)
# 기본적인 전처리
library(stringr)
speeches <- bind_speeches %>%
  mutate(value = str_replace_all(value, "[^가-힣]", " "),value = str_squish(value))
speeches
# 토큰화
library(tidytext)
library(KoNLP)
speeches <- speeches %>%unnest_tokens(input = value,
                output = word,token = extractNoun)
speeches
#두 연설문의 단어 빈도 구하기
frequency <- speeches %>%
  count(president, word) %>% # 연설문 및 단어별 빈도
  filter(str_count(word) > 1) # 두 글자 이상 추출
head(frequency)
#president별 고빈도 단어 상위 10개 추출
top10 <- frequency %>%
  group_by(president) %>% # president별로 분리
  slice_max(n, n = 10) # 상위 10개 추출
top10

top10 %>%filter(president == "park")
#빈도 동점 단어 제외하고 추출하기
#slice_max(with_ties = F) : 원본 데이터의 정렬 순서에 따라 행 추출
top10 <- frequency %>%group_by(president) %>%
  slice_max(n, n = 10, with_ties = F)
top10
#막대 그래프 만들기
library(ggplot2)
ggplot(top10, aes(x = reorder(word, n),
                  y = n,fill = president)) +
  geom_col() +coord_flip() +facet_wrap(~ president)
#그래프별 y축 설정하기
#scales : 그래프의 축 통일 또는 각각 생성 결정
#"fixed" : 축 통일(기본값)
#"free_y" : 범주별로 y축 만듦
ggplot(top10, aes(x = reorder(word, n),
                  y = n,
                  fill = president)) +
  geom_col() +
  coord_flip() +
  facet_wrap(~ president, # president별 그래프 생성
             scales = "free_y") # y축 통일하지 않음
#특정 단어 제외하고 막대 그래프 만들기
top10 <- frequency %>%
  filter(word != "국민") %>% group_by(president) %>%
  slice_max(n, n = 10, with_ties = F)

ggplot(top10, aes(x = reorder(word, n),
                  y = n,
                  fill = president)) +
  geom_col() +
  coord_flip() +
  facet_wrap(~ president, scales = "free_y")
#그래프별로 축 정렬하기
#tidytext::reorder_within() : 변수의 항목별로 축 순서 따로 구하기
#x : 축
#by :정렬 기준
#within : 그래프를 나누는 기준
ggplot(top10, aes(x = reorder_within(word, n, president),
                  y = n,
                  fill = president)) +
  geom_col() +
  coord_flip() +
  facet_wrap(~ president, scales = "free_y")
#tidytext::scale_x_reordered() : 각 단어 뒤의 범주 항목 제거
ggplot(top10, aes(x = reorder_within(word, n, president),
                  y = n,
                  fill = president)) +
  geom_col() +
  coord_flip() +
  facet_wrap(~ president, scales = "free_y") +
  scale_x_reordered() +
  labs(x = NULL) + # x축 삭제
  theme(text = element_text(family = "nanumgothic")) # 폰트



#p.34 상대적으로 중요한 단어 비교하기
#Long form 데이터 살펴보기
df_long <- frequency %>%
  group_by(president) %>%
  slice_max(n, n = 10) %>%
  filter(word %in% c("국민", "우리", "정치", "행복"))
df_long
#wide form: 가로로 넓은 형태의 데이터
library(tidyr)
df_wide <- df_long %>%
  pivot_wider(names_from = president,
              values_from = n)
df_wide
#NA를 0으로 바꾸기
df_wide <- df_long %>%
  pivot_wider(names_from = president,
              values_from = n,
              values_fill = list(n = 0))
df_wide
#연설문 단어 빈도를 Wide form으로 변환하기
frequency_wide <- frequency %>%
  pivot_wider(names_from = president,
              values_from = n,
              values_fill = list(n = 0))
frequency_wide
# 단어의 비중을 나타낸 변수 추가하기
frequency_wide <- frequency_wide %>%
  mutate(ratio_moon = ((moon)/(sum(moon))), # moon 에서 단어의 비중
         ratio_park = ((park)/(sum(park)))) # park 에서 단어의 비중
frequency_wide
#어떤 단어가 한 연설문에 전혀 사용되지 않으면 빈도 0, 
#오즈비 0, 단어 비중 비교 불가
#빈도가 0보다 큰 값이 되도록 모든 값에 +1
frequency_wide <- frequency_wide %>%
  mutate(ratio_moon = ((moon + 1)/(sum(moon + 1))), # moon에서 단어의 비중
         ratio_park = ((park + 1)/(sum(park + 1)))) # park에서 단어의 비중
frequency_wide
#오즈비 변수 추가하기
frequency_wide <- frequency_wide %>%
  mutate(odds_ratio = ratio_moon/ratio_park)
frequency_wide
frequency_wide %>% arrange(-odds_ratio)
frequency_wide %>% arrange(odds_ratio)
#오즈비가 가장 높거나 가장 낮은 단어 추출하기
top10 <- frequency_wide %>%
  filter(rank(odds_ratio) <= 10 | rank(-odds_ratio) <= 10)
top10 %>% arrange(-odds_ratio)
#비중이 큰 연설문을 나타낸 변수 추가하기
top10 <- top10 %>%
  mutate(president = ifelse(odds_ratio > 1, "moon", "park"),
         n = ifelse(odds_ratio > 1, moon, park))
top10
#막대 그래프 만들기
ggplot(top10, aes(x = reorder_within(word, n, president),
                  y = n,
                  fill = president)) +
  geom_col() +
  coord_flip() +
  facet_wrap(~ president, scales = "free_y") +
  scale_x_reordered()
#범주별로 단어 비중 알 수 있도록 x축 크기 각각 정하기
ggplot(top10, aes(x = reorder_within(word, n, president),
                  y = n,
                  fill = president)) +
  geom_col() +
  coord_flip() +
  facet_wrap(~ president, scales = "free") +
  scale_x_reordered() +
  labs(x = NULL) + # x축 삭제
  theme(text = element_text(family = "nanumgothic")) # 폰트
#원문을 문장 기준으로 토큰화하기
speeches_sentence <- bind_speeches %>%
  as_tibble() %>%
  unnest_tokens(input = value,
                output = sentence,
                token = "sentences")
speeches_sentence
#주요 단어가 사용된 문장 추출하기 - str_detect()
speeches_sentence %>%
  filter(president == "moon" & str_detect(sentence, "복지국가"))
#중요도가 비슷한 단어 살펴보기
frequency_wide %>%
  arrange(abs(1 - odds_ratio)) %>%
  head(10)
#중요도가 비슷한 단어 살펴보기
frequency_wide %>%
  filter(moon >= 5 & park >= 5) %>%
  arrange(abs(1 - odds_ratio)) %>%
  head(10)



#p.67 로그 오즈비로 단어 비교하기
frequency_wide <- frequency_wide %>%
  mutate(log_odds_ratio = log(odds_ratio))
frequency_wide
# moon에서 비중이 큰 단어
frequency_wide %>%
  arrange(-log_odds_ratio)
# park에서 비중이 큰 단어
frequency_wide %>%
  arrange(log_odds_ratio)
# 비중이 비슷한 단어
frequency_wide %>%
  arrange(abs(log_odds_ratio))
#두 연설문 각각 log_odds_ratio Top 10 추출
top10 <- frequency_wide %>%
  group_by(president = ifelse(log_odds_ratio > 0, "moon", "park")) %>%
  slice_max(abs(log_odds_ratio), n = 10, with_ties = F)
top10
#주요 변수 추출
top10 %>%
  arrange(-log_odds_ratio) %>%
  select(word, log_odds_ratio, president)
#막대 그래프 만들기
ggplot(top10, aes(x = reorder(word, log_odds_ratio),
                  y = log_odds_ratio,
                  fill = president)) +
  geom_col() +
  coord_flip() +
  labs(x = NULL) +
  theme(text = element_text(family = "nanumgothic"))



#p.87 여러 텍스트의 단어 비교하기
# 데이터 불러오기
install.packages("readr")
library(readr)
raw_speeches <- read_csv("speeches_presidents.csv")
raw_speeches
# 기본적인 전처리
speeches <- raw_speeches %>%
  mutate(value = str_replace_all(value, "[^가-힣]", " "),
         value = str_squish(value))
# 토큰화
speeches <- speeches %>%
  unnest_tokens(input = value,
                output = word,
                token = extractNoun)
# 단어 빈도 구하기
frequecy <- speeches %>%
  count(president, word) %>%
  filter(str_count(word) > 1)
frequecy
#TF-IDF 구하기
frequecy <- frequecy %>%
  bind_tf_idf(term = word, # 단어
              document = president, # 텍스트 구분 기준
              n = n) %>% # 단어 빈도
  arrange(-tf_idf)
frequecy
#TF-IDF가 높은 단어 살펴보기
frequecy %>% filter(president == "문재인")
frequecy %>% filter(president == "박근혜")
frequecy %>% filter(president == "이명박")
frequecy %>% filter(president == "노무현")
#TF-IDF가 낮은 단어 살펴보기
frequecy %>% filter(president == "문재인") %>%arrange(tf_idf)
frequecy %>% filter(president == "박근혜") %>%arrange(tf_idf)
frequecy %>% filter(president == "이명박") %>%arrange(tf_idf)
frequecy %>% filter(president == "노무현") %>%arrange(tf_idf)
#막대 그래프 만들기
# 주요 단어 추출
top10 <- frequecy %>%
  group_by(president) %>%
  slice_max(tf_idf, n = 10, with_ties = F)
# 그래프 순서 정하기
top10$president <- factor(top10$president,
                          levels = c("문재인", "박근혜", "이명박", "노무현"))
# 막대 그래프 만들기
ggplot(top10, aes(x = reorder_within(word, tf_idf, president),
                  y = tf_idf,
                  fill = president)) +
  geom_col(show.legend = F) +
  coord_flip() +
  facet_wrap(~ president, scales = "free", ncol = 2) +
  scale_x_reordered() +
  labs(x = NULL) +
  theme(text = element_text(family = "nanumgothic"))



#분석도전
#Q1.1 speeches_presidents.csv를 불러와 이명박 전 
#대통령과 노무현 전 대통령의 연설문을 추출하고
#분석에 적합하게 전처리하세요.
# 데이터 불러오기
library(readr)
raw_speeches <- read_csv("speeches_presidents.csv")
# 전처리
library(dplyr)
library(stringr)
speeches <- raw_speeches %>%
  filter(president %in% c("이명박", "노무현")) %>%
  mutate(value = str_replace_all(value, "[^가-힣]", " "),
         value = str_squish(value))
speeches
#Q1.2 연설문에서 명사를 추출한 다음 연설문별 단어 빈도를 구하세요.
# 명사 추출
library(tidytext)
library(KoNLP)
speeches <- speeches %>%
  unnest_tokens(input = value,
                output = word,
                token = extractNoun)
speeches
# 연설문별 단어 빈도 구하기
frequency <- speeches %>%
  count(president, word) %>%
  filter(str_count(word) > 1)
frequency
#Q1.3 로그 오즈비를 이용해 두 연설문에서 상대적으로 
#중요한 단어를 10개씩 추출하세요.
# long form을 wide form으로 변환
library(tidyr)
frequency_wide <- frequency %>%
  pivot_wider(names_from = president, # 변수명으로 만들 값
              values_from = n, # 변수에 채워 넣을 값
              values_fill = list(n = 0)) # 결측치 0으로 변환
frequency_wide
# 로그 오즈비 구하기
frequency_wide <- frequency_wide %>%
  mutate(log_odds_ratio = log(((이명박 + 1) / (sum(이명박 + 1))) /
                                ((노무현 + 1) / (sum(노무현 + 1)))))
frequency_wide
# 상대적으로 중요한 단어 추출
top10 <- frequency_wide %>%
  group_by(president = ifelse(log_odds_ratio > 0, "lee", "roh")) %>%
  slice_max(abs(log_odds_ratio), n = 10, with_ties = F)
top10
#Q1.4 두 연설문에서 상대적으로 중요한 단어를 나타낸 막대 그래프를 만드세요.
library(ggplot2)
ggplot(top10, aes(x = reorder(word, log_odds_ratio),
                  y = log_odds_ratio,
                  fill = president)) +
  geom_col() +
  coord_flip () +
  labs(x = NULL)

#Q2.1 inaugural_address.csv를 불러와 분석에 적합하게 전처리하고 연설문에서 명사를 추출하세요.
# 데이터 불러오기
library(readr)
raw_speeches <- read_csv("inaugural_address.csv")
# 전처리
library(dplyr)
library(stringr)
speeches <- raw_speeches %>%
  mutate(value = str_replace_all(value, "[^가-힣]", " "),
         value = str_squish(value))
speeches
#Q2.1 inaugural_address.csv를 불러와 분석에 적합하게 전처리하고 연설문에서 명사를 추출하세요
# 명사 기준 토큰화
library(tidytext)
library(KoNLP)
speeches <- speeches %>%
  unnest_tokens(input = value,
                output = word,
                token = extractNoun)
speeches
#Q2.2 TF-IDF를 이용해 각 연설문에서 상대적으로 중요한 단어를 10개씩 추출하세요
# 단어 빈도 구하기
frequecy <- speeches %>%
  count(president, word) %>%
  filter(str_count(word) > 1)
frequecy
# TF-IDF 구하기
frequecy <- frequecy %>%
  bind_tf_idf(term = word, # 단어
              document = president, # 텍스트 구분 변수
              n = n) %>% # 단어 빈도
  arrange(-tf_idf)
frequecy
# 상대적으로 중요한 단어 추출
top10 <- frequecy %>%
  group_by(president) %>%
  slice_max(tf_idf, n = 10, with_ties = F)
head(top10)
#Q2.3 각 연설문에서 상대적으로 중요한 단어를 나타낸 막대 그래프를 만드세요.
library(ggplot2)
ggplot(top10, aes(x = reorder_within(word, tf_idf, president),
                  y = tf_idf,
                  fill = president)) +
  geom_col(show.legend = F) +
  coord_flip () +
  facet_wrap(~ president, scales = "free", ncol = 2) +
  scale_x_reordered() +
  labs(x = NULL)





