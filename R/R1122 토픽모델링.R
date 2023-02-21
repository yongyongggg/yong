########토픽 모델링
####p.8 LDA 모델 만들기
setwd('C:\\Rwork\\TM-dataset')
# 기생충 기사 댓글 불러오기
library(readr)
library(dplyr)
raw_news_comment <- read_csv("news_comment_parasite.csv") %>%
  mutate(id = row_number())
library(stringr)
library(textclean)
str(raw_news_comment)
# 기본적인 전처리
news_comment <- raw_news_comment %>%
  mutate(reply = str_replace_all(reply, "[^가-힣]", " "),
         reply = str_squish(reply)) %>% distinct(reply, .keep_all = T) %>%
  dplyr::filter(str_count(reply, boundary('word')) >= 3)
library(tidytext)
library(KoNLP)
# 명사 추출
comment <- news_comment %>%
  unnest_tokens(input = reply,
                output = word,
                token = extractNoun,
                drop = F) %>%
  dplyr::filter(str_count(word) > 1) %>%
  # 댓글 내 중복 단어 제거
  group_by(id) %>%
  distinct(word, .keep_all = T) %>%
  ungroup() %>%
  select(id, word)
#빈도 높은 단어 제거하기
count_word <- comment %>% add_count(word) %>% dplyr::filter(n <= 200) %>% select(-n)
# 불용어, 유의어 확인하기
count_word %>% count(word, sort = T) %>% print(n = 200)
# 불용어 목록 만들기
stopword <- c("들이", "하다", "하게", "하면", "해서", "이번", "하네",
              "해요", "이것", "니들", "하기", "하지", "한거", "해주",
              "그것", "어디", "여기", "까지", "이거", "하신", "만큼")
# 불용어, 유의어 처리하기
count_word <- count_word %>%
  dplyr::filter(!word %in% stopword) %>%
        mutate(word = dplyr::recode(word,
                       "자랑스럽습니" = "자랑",
                       "자랑스럽" = "자랑",
                       "자한" = "자유한국당",
                       "문재" = "문재인",
                       "한국의" = "한국",
                       "그네" = "박근혜",
                       "추카" = "축하",
                       "정경" = "정경심",
                       "방탄" = "방탄소년단"))
#정확한 충돌 메시지가 표시
install.packages('conflicted')
library(conflicted)
# 문서별 단어 빈도 구하기
count_word_doc <- count_word %>% count(id, word, sort = T)
count_word_doc
# DTM 만들기
library(tm)
dtm_comment <- count_word_doc %>%
  cast_dtm(document = id, term = word, value = n)
dtm_comment
install.packages("topicmodels")
library(topicmodels)
# 토픽 모델 만들기
lda_model <- LDA(dtm_comment,
                 k = 8,
                 method = "Gibbs",
                 control = list(seed = 1234))
# 토픽별 단어 확률, beta 추출하기
term_topic <- tidy(lda_model, matrix = "beta")
term_topic
# 토픽별 단어 수
term_topic %>% count(topic)
# 토픽 1의 beta 합계
term_topic %>% dplyr::filter(topic == 1) %>% summarise(sum_beta = sum(beta))
#특정 단어의 토픽별 확률 살펴보기
term_topic %>% dplyr::filter(term == "작품상")
#특정 토픽에서 beta가 높은 단어 살펴보기
term_topic %>% dplyr::filter(topic == 6) %>%arrange(-beta)
#모든 토픽의 주요 단어 살펴보기
terms(lda_model, 20) %>%data.frame()
#토픽별로 beta가 가장 높은 단어 추출하기
top_term_topic <- term_topic %>% group_by(topic) %>% slice_max(beta, n = 10)
#막대 그래프 만들기
library(scales)
library(ggplot2)
ggplot(top_term_topic,
       aes(x = reorder_within(term, beta, topic),
           y = beta,
           fill = factor(topic))) +
  geom_col(show.legend = F) +
  facet_wrap(~ topic, scales = "free", ncol = 4) +
  coord_flip() +
  scale_x_reordered() +
  scale_y_continuous(n.breaks = 4,
                     labels = number_format(accuracy = .01)) +
  labs(x = NULL) +
  theme(text = element_text(family = "nanumgothic"))



#p.36  문서를 토픽별로 분류하기
#gamma 추출하기
doc_topic <- tidy(lda_model, matrix = "gamma")
doc_topic
doc_topic %>% count(topic)
# 문서 1의 gamma 합계
doc_topic %>% dplyr::filter(document == 1) %>% summarise(sum_gamma = sum(gamma))
# 문서별로 확률이 가장 높은 토픽 추출
doc_class <- doc_topic %>%group_by(document) %>% slice_max(gamma, n = 1)
doc_class
# integer로 변환
doc_class$document <- as.integer(doc_class$document)
# 원문에 토픽 번호 부여
news_comment_topic <- raw_news_comment %>%
  left_join(doc_class, by = c("id" = "document"))
#결합 확인
news_comment_topic %>% select(id, topic)
#토픽별 문서 수 살펴보기
news_comment_topic %>% count(topic)
#토픽별 문서 수 살펴보기
news_comment_topic <- news_comment_topic %>% na.omit()
news_comment_topic %>% count(topic)
#토픽별 주요 단어 목록 만들기
top_terms <- term_topic %>% group_by(topic) %>%
  slice_max(beta, n = 6, with_ties = F) %>%
  summarise(term = paste(term, collapse = ", "))
top_terms
#토픽별 문서 빈도 구하기
count_topic <- news_comment_topic %>% count(topic)
count_topic
#문서 빈도에 주요 단어 결합하기
count_topic_word <- count_topic %>%
  left_join(top_terms, by = "topic") %>%
  mutate(topic_name = paste("Topic", topic))
count_topic_word
# 토픽별 문서 수와 주요 단어로 막대 그래프 만들기
ggplot(count_topic_word,
       aes(x = reorder(topic_name, n),
           y = n,
           fill = topic_name)) +
  geom_col(show.legend = F) +
  coord_flip() +
  geom_text(aes(label = n) , # 문서 빈도 표시
            hjust = -0.2) + # 막대 밖에 표시
  geom_text(aes(label = term), # 주요 단어 표시
            hjust = 1.03, # 막대 안에 표시
            col = "white", # 색깔
            fontface = "bold", # 두껍게
            family = "nanumgothic") + # 폰트
  scale_y_continuous(expand = c(0, 0), # y축-막대 간격 줄이기
                     limits = c(0, 820)) + # y축 범위
  labs(x = NULL)




#p.50 토픽 이름 짓기
#원문을 읽기 편하게 전처리하기, gamma가 높은 순으로 정렬하기
comment_topic <- news_comment_topic %>%
  mutate(reply = str_squish(replace_html(reply))) %>% arrange(-gamma)
comment_topic %>% select(gamma, reply)
#주요 단어가 사용된 문서 살펴보기
# 토픽 1 내용 살펴보기
comment_topic %>%
  dplyr::filter(topic == 1 & str_detect(reply, "작품")) %>%
  head(50) %>% pull(reply)
comment_topic %>%
  dplyr::filter(topic == 1 & str_detect(reply, "진심")) %>%
  head(50) %>% pull(reply)
# 토픽 이름 목록 만들기
name_topic <- tibble(topic = 1:8,
                     name = c("1. 작품상 수상 축하, 정치적 댓글 비판",
                              "2. 수상 축하, 시상식 감상",
                              "3. 조국 가족, 정치적 해석",
                              "4. 새 역사 쓴 세계적인 영화",
                              "5. 자랑스럽고 감사한 마음",
                              "6. 놀라운 4관왕 수상",
                              "7. 문화계 블랙리스트, 보수 정당 비판",
                              "8. 한국의 세계적 위상"))
# 토픽 이름 결합하기
top_term_topic_name <- top_term_topic %>%
  left_join(name_topic, name_topic, by = "topic")
top_term_topic_name
# 막대 그래프 만들기
ggplot(top_term_topic_name,
       aes(x = reorder_within(term, beta, name),
           y = beta,
           fill = factor(topic))) +
  geom_col(show.legend = F) +
  facet_wrap(~ name, scales = "free", ncol = 2) +
  coord_flip() +
  scale_x_reordered() +
  labs(title = "영화 기생충 아카데미상 수상 기사 댓글 토픽",
       subtitle = "토픽별 주요 단어 Top 10",
       x = NULL, y = NULL) +
  theme_minimal() +
  theme(text = element_text(family = "nanumgothic"),
        title = element_text(size = 12),
        axis.text.x = element_blank(),
        axis.ticks.x = element_blank())


#p.60 최적의 토픽 수 정하기
# 토픽 수 바꿔가며 LDA 모델 여러 개 만들기
install.packages("ldatuning")
library(ldatuning)
install.packages('Rmpfr')
library(Rmpfr)
models <- FindTopicsNumber(dtm = dtm_comment,
                           topics = 2:20,
                           return_models = T,
                           control = list(seed = 1234))
FindTopicsNumber_plot(models)
# 토픽 수가 8개인 모델 추출하기
optimal_model <- models %>%
  dplyr::filter(topics == 8) %>%
  pull(LDA_model) %>% # 모델 추출
  .[[1]] # list 추출
# optimal_model
tidy(optimal_model, matrix = "beta")
# lda_model
tidy(lda_model, matrix = "beta")




#p.73 분석 도전
#Q1. speeches_roh.csv를 불러온 다음 연설문이 
#들어있는 content를 문장 기준으로 토큰화하세요
# 연설문 불러오기
library(readr)
speeches_raw <- read_csv("speeches_roh.csv")
# 문장 기준 토큰화
library(dplyr)
library(tidytext)
speeches <- speeches_raw %>%
  unnest_tokens(input = content,output = sentence,token = "sentences",drop = F)
#Q2. 문장을 분석에 적합하게 전처리한 다음 명사를 추출하세요
# 전처리
library(stringr)
speeches <- speeches %>%
  mutate(sentence = str_replace_all(sentence, "[^가-힣]", " "),
         sentence = str_squish(sentence))
# 명사 추출
library(tidytext)
library(KoNLP)
library(stringr)
nouns_speeches <- speeches %>%
  unnest_tokens(input = sentence, output = word,token = extractNoun, drop = F) %>%
  dplyr::filter(str_count(word) > 1)

#Q3. 연설문 내 중복 단어를 제거하고 빈도가 100회 이하인 단어를 추출하세요
# 연설문 내 중복 단어 제거
nouns_speeches <- nouns_speeches %>% group_by(id) %>%
  distinct(word, .keep_all = T) %>% ungroup()
# 단어 빈도 100회 이하 단어 추출
nouns_speeches <- nouns_speeches %>% add_count(word) %>%
  dplyr::filter(n <= 100) %>% select(-n)
#Q4. 추출한 단어에서 다음의 불용어를 제거하세요
stopword <- c("들이", "하다", "하게", "하면", "해서", "이번", "하네",
              "해요", "이것", "니들", "하기", "하지", "한거", "해주",
              "그것", "어디", "여기", "까지", "이거", "하신", "만큼")
# 불용어 제거
nouns_speeches <- nouns_speeches %>% dplyr::filter(!word %in% stopword)
#Q5. 연설문별 단어 빈도를 구한 다음 DTM을 만드세요
# 연설문별 단어 빈도 구하기
count_word_doc <- nouns_speeches %>% count(id, word, sort = T)
# DTM 만들기
dtm_comment <- count_word_doc %>% cast_dtm(document = id, term = word, value = n)
#Q6. 토픽 수를 2~20개로 바꿔가며 LDA 모델을 만든 다음 최적 토픽 수를 구하세요.
# 토픽 수 바꿔가며 LDA 모델 만들기
library(ldatuning)
models <- FindTopicsNumber(dtm = dtm_comment, topics = 2:20, return_models = T,
                           control = list(seed = 1234))
# 최적 토픽 수 구하기
FindTopicsNumber_plot(models)
#Q7. 토픽 수가 9개인 LDA 모델을 추출하세요.
lda_model <- models %>%
  dplyr::filter (topics == 9) %>%
  pull(LDA_model) %>%
  .[[1]]
#Q8. LDA 모델의 beta를 이용해 각 토픽에 등장할 확률이 
#높은 상위 10개 단어를 추출한 다음 토픽별 주요 단어를 나타낸 막대 그래프를 만드세요.
# beta 추출
term_topic <- tidy(lda_model, matrix = "beta")
# 토픽별 beta 상위 단어 추출
top_term_topic <- term_topic %>%
  group_by(topic) %>%
  slice_max(beta, n = 10)
top_term_topic
# 막대 그래프 만들기
library(ggplot2)
ggplot(top_term_topic,
       aes(x = reorder_within(term, beta, topic),
           y = beta,
           fill = factor(topic))) +
  geom_col(show.legend = F) +
  facet_wrap(~ topic, scales = "free", ncol = 3) +
  coord_flip () +
  scale_x_reordered() +
  labs(x = NULL)
#Q9. LDA 모델의 gamma를 이용해 연설문 원문을 확률이 가장 높은 토픽으로 분류하세요.
# gamma 추출
doc_topic <- tidy(lda_model, matrix = "gamma")
# 문서별로 확률이 가장 높은 토픽 추출
doc_class <- doc_topic %>%
  group_by(document) %>%
  slice_max(gamma, n = 1)
# 변수 타입 통일
doc_class$document <- as.integer(doc_class$document)
# 연설문 원문에 확률이 가장 높은 토픽 번호 부여
speeches_topic <- speeches_raw %>%
  left_join(doc_class, by = c("id" = "document"))
#Q10. 토픽별 문서 수를 출력하세요.
speeches_topic %>% count(topic)
#Q11. 문서가 가장 많은 토픽의 연설문을 gamma가 높은 순으로 
#출력하고 내용이 비슷한지 살펴보세요.
speeches_topic %>% dplyr::filter(topic == 9) %>%
  arrange(-gamma) %>% select(content)















