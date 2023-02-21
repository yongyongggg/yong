setwd('C:\\Rwork\\TM-dataset')
library(dplyr)
#install.packages('readr')
library(readr)
dic <- read_csv("knu_sentiment_lexicon.csv")
# 긍정 단어
dic %>%filter(polarity == 2) %>%arrange(word)
# 부정 단어
dic %>%filter(polarity == -2) %>%arrange(word)

dic %>%filter(word %in% c("좋은", "나쁜"))
dic %>%filter(word %in% c("기쁜", "슬픈"))

# 이모티콘
library(stringr)
dic %>%filter(!str_detect(word, "[가-힣]")) %>%arrange(word)

#총 14,854개 단어
dic %>% mutate(sentiment = ifelse(polarity >= 1, "pos",
      ifelse(polarity <= -1, "neg", "neu"))) %>% count(sentiment)

#p.5 문장의 감정 점수 구하기
#1. 단어 기준으로 토큰화하기
df <- tibble(sentence = c("디자인 예쁘고 마감도 좋아서 만족스럽다.",
          "디자인은 괜찮다. 그런데 마감이 나쁘고 가격도 비싸다."))
df
#텍스트를 단어 기준으로 토큰화: 감정 사전과 동일하게
#install.packages('tidytext')
library(tidytext)
df <- df %>%unnest_tokens(input = sentence,
              output = word,token = "words",drop = F)
df
#단어에 감정 점수 부여하기
df <- df %>%left_join(dic, by = "word") %>%
  mutate(polarity = ifelse(is.na(polarity), 0, polarity))
df
#문장별로 감정 점수 합산하기
score_df <- df %>%group_by(sentence) %>%summarise(score = sum(polarity))
score_df



#p.15 댓글 감정 분석하기
# 데이터 불러오기
raw_news_comment <- read_csv("news_comment_parasite.csv")
# 기본적인 전처리
#install.packages("textclean")
library(textclean)
news_comment <- raw_news_comment %>%
  mutate(id = row_number(),reply = str_squish(replace_html(reply)))
# 데이터 구조 확인
glimpse(news_comment)


# 단어 기준으로 토큰화하고 감정 점수 부여하기
word_comment <- news_comment %>%
  unnest_tokens(input = reply,output = word,token = "words",drop = F)

word_comment %>% select(word, reply)

# 감정 점수 부여
word_comment <- word_comment %>%left_join(dic, by = "word") %>%
  mutate(polarity = ifelse(is.na(polarity), 0, polarity))

word_comment %>% select(word, polarity)

#감정 분류하기
word_comment <- word_comment %>%
  mutate(sentiment = ifelse(polarity == 2, "pos",
                            ifelse(polarity == -2, "neg", "neu")))

word_comment %>% count(sentiment)

#막대 그래프 만들기
top10_sentiment <- word_comment %>%filter(sentiment != "neu") %>%
  count(sentiment, word) %>%group_by(sentiment) %>%slice_max(n, n = 10)

top10_sentiment

# 막대 그래프 만들기
library(ggplot2)
ggplot(top10_sentiment, aes(x = reorder(word, n),y = n,
      fill = sentiment)) +geom_col() +coord_flip() +
      geom_text(aes(label = n), hjust = -0.3) +
      facet_wrap(~ sentiment, scales = "free") +
      scale_y_continuous(expand = expansion(mult = c(0.05, 0.15))) +
      labs(x = NULL) +theme(text = element_text(family = "nanumgothic"))

#댓글별 감정 점수 구하기
score_comment <- word_comment %>%
  group_by(id, reply) %>% summarise(score = sum(polarity)) %>% ungroup()

score_comment %>%select(score, reply)

#감정 점수 높은 댓글 살펴보기
# 긍정 댓글
score_comment %>%select(score, reply) %>% arrange(-score)
# 부정 댓글
score_comment %>%select(score, reply) %>% arrange(score)

#감정 점수 빈도 구하기
score_comment %>% count(score)

#감정 분류하고 막대 그래프 만들기
# 감정 분류하기
score_comment <- score_comment %>%
  mutate(sentiment = ifelse(score >= 1, "pos",
                     ifelse(score <= -1, "neg", "neu")))
# 감정 빈도와 비율 구하기
frequency_score <- score_comment %>%count(sentiment) %>%
  mutate(ratio = n/sum(n)*100)

frequency_score
# 막대 그래프 만들기
ggplot(frequency_score, aes(x = sentiment, y = n, fill = sentiment)) +
  geom_col() +geom_text(aes(label = n), vjust = -0.3) +
  scale_x_discrete(limits = c("pos", "neu", "neg"))
#비율 누적 막대 그래프 만들기
df <- tibble(contry = c("Korea", "Korea", "Japen", "Japen"), # 축
             sex = c("M", "F", "M", "F"), # 누적 막대
             ratio = c(60, 40, 30, 70)) # 값
df

ggplot(df, aes(x = contry, y = ratio, fill = sex)) + geom_col()
#막대에 비율 표기
ggplot(df, aes(x = contry, y = ratio, fill = sex)) +
  geom_col() +
  geom_text(aes(label = paste0(ratio, "%")), # % 표시
  position = position_stack(vjust = 0.5)) # 가운데 표시

#x축을 구성할 더미 변수(dummy variable) 추가
# 더미 변수 생성
frequency_score$dummy <- 0
frequency_score

ggplot(frequency_score, aes(x = dummy, y = ratio, fill = sentiment)) +
  geom_col() +
  geom_text(aes(label = paste0(round(ratio, 1), "%")),
            position = position_stack(vjust = 0.5)) +
  theme(axis.title.x = element_blank(), # x축 이름 삭제
        axis.text.x = element_blank(), # x축 값 삭제
        axis.ticks.x = element_blank()) # x축 눈금 삭제




#p.39 감정 범주별 주요 단어 살펴보기
#감정 범주별 단어 빈도 구하기
#토큰화하고 두 글자 이상 한글 단어만 남기기
comment <- score_comment %>%
          unnest_tokens(input = reply, # 단어 기준 토큰화
          output = word,token = "words",drop = F) %>%
          filter(str_detect(word, "[가-힣]") & # 한글 추출
          str_count(word) >= 2) # 두 글자 이상 추출
# 감정 및 단어별 빈도 구하기
frequency_word <- comment %>% filter(str_count(word) >= 2) %>%
  count(sentiment, word, sort = T)

frequency_word

# 긍정 댓글 고빈도 단어
frequency_word %>% filter(sentiment == "pos")

# 부정 댓글 고빈도 단어
frequency_word %>% filter(sentiment == "neg")

#상대적으로 자주 사용된 단어 비교하기
#로그 오즈비 구하기
# wide form으로 변환
library(tidyr)
comment_wide <- frequency_word %>%filter(sentiment != "neu") %>%
  pivot_wider(names_from = sentiment,values_from = n,
              values_fill = list(n = 0))

comment_wide

# 로그 오즈비 구하기
comment_wide <- comment_wide %>%
  mutate(log_odds_ratio = log(((pos + 1) / (sum(pos + 1))) /
                              ((neg + 1) / (sum(neg + 1)))))

comment_wide

#로그 오즈비가 가장 큰 단어 10개씩 추출하기
top10 <- comment_wide %>%
  group_by(sentiment = ifelse(log_odds_ratio > 0, "pos", "neg")) %>%
  slice_max(abs(log_odds_ratio), n = 10, with_ties = F)
top10

# 막대 그래프 만들기
ggplot(top10, aes(x = reorder(word, log_odds_ratio),
                  y = log_odds_ratio, fill = sentiment)) +
  geom_col() + coord_flip() + labs(x = NULL) +
  theme(text = element_text(family = "nanumgothic"))





#p.49  감정 사전 수정하기
#"소름" , "미친" : 긍정적인 감정을 극적으로 표현한 단어
# "소름"이 사용된 댓글
score_comment %>%filter(str_detect(reply, "소름")) %>%select(reply)
# "미친"이 사용된 댓글
score_comment %>%filter(str_detect(reply, "미친")) %>%select(reply)

dic %>% filter(word %in% c("소름", "소름이", "미친"))
new_dic <- dic %>%
  mutate(polarity = ifelse(word %in% c("소름", "소름이", "미친"), 2, polarity))

new_dic %>% filter(word %in% c("소름", "소름이", "미친"))

#수정한 사전으로 감정 점수 부여하기
new_word_comment <- word_comment %>%
  select(-polarity) %>% left_join(new_dic, by = "word") %>%
  mutate(polarity = ifelse(is.na(polarity), 0, polarity))

#댓글별 감정 점수 구하기
new_score_comment <- new_word_comment %>%group_by(id, reply) %>%
  summarise(score = sum(polarity)) %>%ungroup()

new_score_comment %>% select(score, reply) %>% arrange(-score)

#감정 분류하기
# 1점 기준으로 긍정 중립 부정 분류
new_score_comment <- new_score_comment %>%
  mutate(sentiment = ifelse(score >= 1, "pos",
                     ifelse(score <= -1, "neg", "neu")))

# 원본 감정 사전 활용
score_comment %>%count(sentiment) %>% mutate(ratio = n/sum(n)*100)
# 수정한 감정 사전 활용
new_score_comment %>%count(sentiment) %>%mutate(ratio = n/sum(n)*100)

word <- "소름|소름이|미친"
# 원본 감정 사전 활용
score_comment %>%filter(str_detect(reply, word)) %>%count(sentiment)
# 수정한 감정 사전 활용
new_score_comment %>%filter(str_detect(reply, word)) %>%count(sentiment)

#감정 범주별 주요 단어 살펴보기
#두 글자 이상 한글 단어만 남기고 단어 빈도 구하기
# 토큰화 및 전처리
new_comment <- new_score_comment %>%
  unnest_tokens(input = reply,output = word,token = "words",drop = F) %>%
  filter(str_detect(word, "[가-힣]") &str_count(word) >= 2)
# 감정 및 단어별 빈도 구하기
new_frequency_word <- new_comment %>% count(sentiment, word, sort = T)

#로그 오즈비 구하기
# Wide form으로 변환
new_comment_wide <- new_frequency_word %>% filter(sentiment != "neu") %>%
  pivot_wider(names_from = sentiment,
              values_from = n, values_fill = list(n = 0))
# 로그 오즈비 구하기
new_comment_wide <- new_comment_wide %>%
  mutate(log_odds_ratio = log(((pos + 1) / (sum(pos + 1))) /
                                ((neg + 1) / (sum(neg + 1)))))

#로그 오즈비가 큰 단어로 막대 그래프 만들기
new_top10 <- new_comment_wide %>%
  group_by(sentiment = ifelse(log_odds_ratio > 0, "pos", "neg")) %>%
  slice_max(abs(log_odds_ratio), n = 10, with_ties = F)

ggplot(new_top10, aes(x = reorder(word, log_odds_ratio),
                      y = log_odds_ratio,fill = sentiment)) + 
  geom_col() + coord_flip() + labs(x = NULL) +
  theme(text = element_text(family = "nanumgothic"))

#주요 단어가 사용된 댓글 살펴보기
#긍정 댓글 원문
new_score_comment %>%
  filter(sentiment == "pos" & str_detect(reply, "축하")) %>%
  select(reply)

#긍정 댓글 원문
new_score_comment %>%
  filter(sentiment == "pos" & str_detect(reply, "소름")) %>%
  select(reply)

#부정 댓글 원문
new_score_comment %>%
  filter(sentiment == "neg" & str_detect(reply, "좌빨")) %>%
  select(reply)

#부정 댓글 원문
new_score_comment %>%
  filter(sentiment == "neg" & str_detect(reply, "못한")) %>%
  select(reply)

#분석 결과 비교하기
# 수정한 감정 사전 활용
new_top10 %>%select(-pos, -neg) %>%arrange(-log_odds_ratio)
# 원본 감정 사전 활용
top10 %>%select(-pos, -neg) %>%arrange(-log_odds_ratio)


new_comment_wide %>% filter(word == "미친")






#p.75
#Q1. "news_comment_BTS.csv"를 불러온 다음 행 번호를 나타낸 변수를 
#추가하고 분석에 적합하게 전처리하세요.
# 기사 댓글 불러오기
library(readr)
library(dplyr)
raw_news_comment <- read_csv("news_comment_BTS.csv")
glimpse(raw_news_comment)

# 전처리
library(stringr)
library(textclean)
news_comment <- raw_news_comment %>%
  mutate(id = row_number(),reply = str_squish(replace_html(reply)))

news_comment %>% select(id, reply)

#Q2. 댓글을 띄어쓰기 기준으로 토큰화하고 감정 사전을 
#이용해 댓글의 감정 점수를 구하세요.
# 토큰화
library(tidytext)
library(KoNLP)
word_comment <- news_comment %>%
  unnest_tokens(input = reply, output = word,
                token = "words", # 띄어쓰기 기준
                drop = F) # 원문 유지

word_comment %>% select(word)

# 감정 사전 불러오기
dic <- read_csv("knu_sentiment_lexicon.csv")
# 단어에 감정 점수 부여
word_comment <- word_comment %>% left_join(dic, by = "word") %>%
  mutate(polarity = ifelse(is.na(polarity), 0, polarity))

word_comment %>%select(word, polarity) %>%arrange(-polarity)

# 댓글별로 단어의 감정 점수 합산
score_comment <- word_comment %>%group_by(id, reply) %>%
  summarise(score = sum(polarity)) %>%ungroup()

score_comment %>%select(score, reply) %>%arrange(-score)

#Q3. 감정 범주별 댓글 빈도를 나타낸 막대 그래프를 만드세요.
# 감정 범주 변수 생성
score_comment <- score_comment %>%
  mutate(sentiment = ifelse(score >= 1, "pos",
                            ifelse(score <= -1, "neg", "neu")))

score_comment %>%select(sentiment, reply)

# 감정 범주 빈도 구하기
frequency_score <- score_comment %>% count(sentiment)
frequency_score

# 막대 그래프 만들기
library(ggplot2)
ggplot(frequency_score, aes(x = sentiment, y = n, fill = sentiment)) +
  geom_col() +geom_text(aes(label = n), vjust = -0.3)

#Q4. 댓글을 띄어쓰기 기준으로 토큰화한 다음
#감정 범주별 단어 빈도를 구하세요.
# 토큰화
comment <- score_comment %>%
  unnest_tokens(input = reply, output = word,
                token = "words", drop = F)
# 감정 범주별 단어 빈도 구하기
frequency_word <- comment %>%count(sentiment, word, sort = T)
frequency_word

#Q5. 로그 오즈비를 이용해 긍정 댓글과 부정 댓글에 
#상대적으로 자주 사용된 단어를 10개씩 추출하세요.
# long form을 wide form으로 변환
library(tidyr)
comment_wide <- frequency_word %>%filter(sentiment != "neu") %>%
  pivot_wider(names_from = sentiment,
              values_from = n, values_fill = list(n = 0))
comment_wide

# 로그 오즈비 구하기
comment_wide <- comment_wide %>%
  mutate(log_odds_ratio = log(((pos + 1) / (sum(pos + 1))) /
                                ((neg + 1) / (sum(neg + 1)))))
comment_wide

# 긍정, 부정 댓글에 상대적으로 자주 사용된 단어 추출
top10 <- comment_wide %>%
  group_by(sentiment = ifelse(log_odds_ratio > 0, "pos", "neg")) %>%
  slice_max(abs(log_odds_ratio), n = 10)

top10

#Q6. 긍정 댓글과 부정 댓글에 상대적으로 자주 
#사용된 단어를 나타낸 막대 그래프를 만드세요.
ggplot(top10, aes(x = reorder(word, log_odds_ratio),
                  y = log_odds_ratio,fill = sentiment)) +
  geom_col() +coord_flip() +labs(x = NULL)


#Q7. 'Q3'에서 만든 데이터를 이용해 '긍정 댓글에 가장 자주 사용된 단어'를 
#언급한 댓글을 감정 점수가 높은 순으로 출력하세요.
score_comment %>%filter(str_detect(reply, "자랑스럽다")) %>%
  arrange(-score) %>% select(reply)

#Q8. 'Q3'에서 만든 데이터를 이용해 '부정 댓글에 가장 자주 사용된 단어'를 
#언급한 댓글을 감정 점수가 낮은 순으로 출력하세요.
score_comment %>%filter(str_detect(reply, "국내")) %>%
  arrange(score) %>%select(reply)














