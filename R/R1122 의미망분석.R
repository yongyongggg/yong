############의미망 분석
####p.3 동시 출현 단어 분석
setwd('C:\\Rwork\\TM-dataset')
# 기생충 기사 댓글 불러오기
library(readr)
raw_news_comment <- read_csv("news_comment_parasite.csv")
# 전처리
library(dplyr)
library(stringr)
library(textclean)
news_comment <- raw_news_comment %>%
  select(reply) %>%
  mutate(reply = str_replace_all(reply, "[^가-힣]", " "),
         reply = str_squish(reply),
         id = row_number())
#토큰화하기
library(tidytext)
library(KoNLP)
comment_pos <- news_comment %>%
  unnest_tokens(input = reply,
                output = word,
                token = SimplePos22,
                drop = F)
comment_pos %>% select(reply, word)
#품사 분리하여 행 구성하기
# 품사별로 행 분리
library(tidyr)
comment_pos <- comment_pos %>% separate_rows(word, sep = "[+]")
comment_pos %>% select(word, reply)
# 명사 추출하기

noun <- comment_pos %>% filter(str_detect(word, "/n")) %>%
  mutate(word = str_remove(word, "/.*$"))
noun %>% select(word, reply)
# 동사, 형용사 추출하기
pvpa <- comment_pos %>%
  filter(str_detect(word, "/pv|/pa")) %>% # "/pv", "/pa" 추출
  mutate(word = str_replace(word, "/.*$", "다")) # "/"로 시작 문자를 "다"로 바꾸기
pvpa %>% select(word, reply)
# 품사 결합
comment <- bind_rows(noun, pvpa) %>% filter(str_count(word) >= 2) %>% arrange(id)
comment %>% select(word, reply)
#명사, 동사, 형용사를 한 번에 추출하기
#comment_new <- comment_pos %>%
#  separate_rows(word, sep = "[+]") %>%
#  filter(str_detect(word, "/n|/pv|/pa")) %>%
#  mutate(word = ifelse(str_detect(word, "/pv|/pa"),
#                       str_replace(word, "/.*$", "다"),
#                      str_remove(word, "/.*$"))) %>%
#  filter(str_count(word) >= 2) %>%
#  arrange(id)
#단어 동시 출현 빈도 구하기
install.packages("widyr")
library(widyr)
pair <- comment %>%pairwise_count(item = word,feature = id,sort = T)
pair
#특정 단어와 자주 함께 사용된 단어 살펴보기
pair %>% filter(item1 == "영화")
pair %>% filter(item1 == "봉준호")



#p.20 동시 출현 네트워크
#네트워크 그래프 데이터 만들기
install.packages("tidygraph")
library(tidygraph)
graph_comment <- pair %>%filter(n >= 25) %>% as_tbl_graph()
graph_comment 
#네트워크 그래프 만들기
install.packages("ggraph")
library(ggraph)
ggraph(graph_comment) +
  geom_edge_link() + # 엣지
  geom_node_point() + # 노드
  geom_node_text(aes(label = name)) # 텍스트
# 한글 폰트 설정
library(showtext)
font_add_google(name = "Nanum Gothic", family = "nanumgothic")
showtext_auto()
#엣지와 노드의 색깔, 크기, 텍스트 위치 수정
set.seed(1234) # 난수 고정
ggraph(graph_comment, layout = "fr") + # 레이아웃
  geom_edge_link(color = "gray50", # 엣지 색깔
                 alpha = 0.5) + # 엣지 명암
  geom_node_point(color = "lightcoral", # 노드 색깔
                  size = 5) + # 노드 크기
  geom_node_text(aes(label = name), # 텍스트 표시
                 repel = T, # 노드밖 표시
                 size = 5, # 텍스트 크기
                 family = "nanumgothic") + # 폰트
  theme_graph() # 배경 삭제
#네트워크 그래프 함수 만들기
word_network <- function(x) {
  ggraph(x, layout = "fr") +
    geom_edge_link(color = "gray50",
                   alpha = 0.5) +
    geom_node_point(color = "lightcoral",
                    size = 5) +
    geom_node_text(aes(label = name),
                   repel = T,
                   size = 5,
                   family = "nanumgothic") +
    theme_graph()
}
set.seed(1234)
word_network(graph_comment)
# 유의어 처리하기
comment <- comment %>%
  mutate(word = ifelse(str_detect(word, "감독") &
                         !str_detect(word, "감독상"), "봉준호", word),
         word = ifelse(word == "오르다", "올리다", word),
         word = ifelse(str_detect(word, "축하"), "축하", word))
# 단어 동시 출현 빈도 구하기
pair <- comment %>%
  pairwise_count(item = word,feature = id,sort = T)
# 네트워크 그래프 데이터 만들기
graph_comment <- pair %>%filter(n >= 25) %>% as_tbl_graph()
# 네트워크 그래프 만들기
set.seed(1234)
word_network(graph_comment)
#네트워크 그래프 데이터에 연결 중심성, 커뮤니티 변수 추가하기
set.seed(1234)
graph_comment <- pair %>%
  filter(n >= 25) %>%
  as_tbl_graph(directed = F) %>%
  mutate(centrality = centrality_degree(), # 연결 중심성
         group = as.factor(group_infomap())) # 커뮤니티
graph_comment
#네트워크 그래프에 연결 중심성, 커뮤니티 표현하기
set.seed(1234)
ggraph(graph_comment, layout = "fr") + # 레이아웃
  geom_edge_link(color = "gray50", # 엣지 색깔
                 alpha = 0.5) + # 엣지 명암
  geom_node_point(aes(size = centrality, # 노드 크기
                      color = group), # 노드 색깔
                  show.legend = F) + # 범례 삭제
  scale_size(range = c(5, 15)) + # 노드 크기 범위
  geom_node_text(aes(label = name), # 텍스트 표시
                 repel = T, # 노드밖 표시
                 size = 5, # 텍스트 크기
                 family = "nanumgothic") + # 폰트
  theme_graph() # 배경 삭제
#주요 단어의 커뮤니티 살펴보기
graph_comment %>% filter(name == "봉준호")
#같은 커뮤니티로 분류된 단어 살펴보기
graph_comment %>% filter(group == 4) %>% arrange(-centrality) %>% data.frame()
#연결 중심성이 높은 주요 단어 살펴보기
graph_comment %>% arrange(-centrality)
#2번 커뮤니티로 분류된 단어
graph_comment %>% filter(group == 2) %>% arrange(-centrality) %>% data.frame()
#주요 단어가 사용된 원문 살펴보기
news_comment %>%
  filter(str_detect(reply, "봉준호") & str_detect(reply, "대박")) %>%
  select(reply)
news_comment %>%
  filter(str_detect(reply, "박근혜") & str_detect(reply, "블랙리스트")) %>%
  select(reply)
news_comment %>%
  filter(str_detect(reply, "기생충") & str_detect(reply, "조국")) %>%
  select(reply)


#p.47 단어 간 상관 분석
#파이 계수 구하기
word_cors <- comment %>%add_count(word) %>%filter(n >= 20) %>%
  pairwise_cor(item = word,feature = id,sort = T)
word_cors
#특정 단어와 관련성이 큰 단어 살펴보기
word_cors %>% filter(item1 == "대한민국")
word_cors %>% filter(item1 == "역사")
#관심 단어별로 파이 계수가 큰 단어 추출하기
# 관심 단어 목록 생성
target <- c("대한민국", "역사", "수상소감", "조국", "박근혜", "블랙리스트")
top_cors <- word_cors %>% filter(item1 %in% target) %>%
  group_by(item1) %>% slice_max(correlation, n = 8)
# 그래프 순서 정하기
top_cors$item1 <- factor(top_cors$item1, levels = target)
library(ggplot2)
ggplot(top_cors, aes(x = reorder_within(item2, correlation, item1),
                     y = correlation,
                     fill = item1)) +
  geom_col(show.legend = F) +
  facet_wrap(~ item1, scales = "free") +
  coord_flip() +
  scale_x_reordered() +
  labs(x = NULL) +
  theme(text = element_text(family = "nanumgothic"))
#네트워크 그래프 데이터 만들기. 연결 중심성과 커뮤니티 추가하기
set.seed(1234)
graph_cors <- word_cors %>% filter(correlation >= 0.15) %>%
  as_tbl_graph(directed = F) %>%
  mutate(centrality = centrality_degree(), group = as.factor(group_infomap()))
#네트워크 그래프 만들기
set.seed(1234)
ggraph(graph_cors, layout = "fr") +
  geom_edge_link(color = "gray50",
                 aes(edge_alpha = correlation, # 엣지 명암
                     edge_width = correlation), # 엣지 두께
                 show.legend = F) + # 범례 삭제
  scale_edge_width(range = c(1, 4)) + # 엣지 두께 범위
  geom_node_point(aes(size = centrality,
                      color = group),
                  show.legend = F) +
  scale_size(range = c(5, 10)) +
  geom_node_text(aes(label = name),
                 repel = T,
                 size = 5,
                 family = "nanumgothic") +
  theme_graph() 



#p.60 연이어 사용된 단어쌍 분석
#엔그램으로 토큰화하기
text <- tibble(value = "대한민국은 민주공화국이다. 대한민국의 주권은 국민에게 있고, 모든
권력은 국민으로부터 나온다.")
text
# 바이그램 토큰화
text %>%
  unnest_tokens(input = value,output = word,token = "ngrams",n = 2)
# 트라이그램 토큰화
text %>%
  unnest_tokens(input = value,output = word,token = "ngrams",n = 3)
# 단어 기준 토큰화
text %>%
  unnest_tokens(input = value, output = word, token = "words")
# 유니그램 토큰화
text %>%
  unnest_tokens(input = value, output = word,token = "ngrams", n = 1)
#명사, 동사, 형용사 추출하기
comment_new <- comment_pos %>%
  separate_rows(word, sep = "[+]") %>%
  filter(str_detect(word, "/n|/pv|/pa")) %>%
  mutate(word = ifelse(str_detect(word, "/pv|/pa"),
                       str_replace(word, "/.*$", "다"),
                       str_remove(word, "/.*$"))) %>%
  filter(str_count(word) >= 2) %>% arrange(id)
#유의어 처리하기
comment_new <- comment_new %>%
  mutate(word = ifelse(str_detect(word, "감독") &
                         !str_detect(word, "감독상"), "봉준호", word),
         word = ifelse(word == "오르다", "올리다", word),
         word = ifelse(str_detect(word, "축하"), "축하", word))
#한 댓글이 하나의 행이 되도록 결합하기
comment_new %>%select(word)
#한 댓글이 하나의 행이 되도록 결합하기
line_comment <- comment_new %>% group_by(id) %>%
  summarise(sentence = paste(word, collapse = " "))
line_comment
#바이그램으로 토큰화하기
bigram_comment <- line_comment %>%
  unnest_tokens(input = sentence,output = bigram,token = "ngrams", n = 2)
bigram_comment
# 바이그램 분리하기
bigram_seprated <- bigram_comment %>%
  separate(bigram, c("word1", "word2"), sep = " ")
bigram_seprated
# 단어쌍 빈도 구하기
pair_bigram <- bigram_seprated %>%count(word1, word2, sort = T) %>% na.omit()
pair_bigram
# 동시 출현 단어쌍
pair %>% filter(item1 == "대한민국")
# 바이그램 단어쌍
pair_bigram %>% filter(word1 == "대한민국")
# 네트워크 그래프 데이터 만들기
graph_bigram <- pair_bigram %>% filter(n >= 8) %>% as_tbl_graph()
# 네트워크 그래프 만들기
set.seed(1234)
word_network(graph_bigram)
# 유의어 처리
bigram_seprated <- bigram_seprated %>%
  mutate(word1 = ifelse(str_detect(word1, "대단"), "대단", word1),
         word2 = ifelse(str_detect(word2, "대단"), "대단", word2),
         word1 = ifelse(str_detect(word1, "자랑"), "자랑", word1),
         word2 = ifelse(str_detect(word2, "자랑"), "자랑", word2),
         word1 = ifelse(str_detect(word1, "짝짝짝"), "짝짝짝", word1),
         word2 = ifelse(str_detect(word2, "짝짝짝"), "짝짝짝", word2)) %>%
# 같은 단어 연속 제거
filter(word1 != word2)
# 단어쌍 빈도 구하기
pair_bigram <- bigram_seprated %>%count(word1, word2, sort = T) %>% na.omit()
# 네트워크 그래프 데이터 만들기
set.seed(1234)
graph_bigram <- pair_bigram %>%
  filter(n >= 8) %>%
  as_tbl_graph(directed = F) %>%
  mutate(centrality = centrality_degree(), # 중심성
         group = as.factor(group_infomap())) # 커뮤니티
# 네트워크 그래프 만들기
set.seed(1234)
ggraph(graph_bigram, layout = "fr") + # 레이아웃
  geom_edge_link(color = "gray50", # 엣지 색깔
                 alpha = 0.5) + # 엣지 명암
  geom_node_point(aes(size = centrality, # 노드 크기
                      color = group), # 노드 색깔
                  show.legend = F) + # 범례 삭제
  scale_size(range = c(4, 8)) + # 노드 크기 범위
  geom_node_text(aes(label = name), # 텍스트 표시
                 repel = T, # 노드밖 표시
                 size = 5, # 텍스트 크기
                 family = "nanumgothic") + # 폰트
  theme_graph() # 배경 삭제





#p.96 분석도전
#Q1. "news_comment_BTS.csv"를 불러온 다음 행 번호를 나타낸 
#변수를 추가하고 분석에 적합하게 전처리하세요
library(readr)
library(dplyr)
raw_news_comment <- read_csv("news_comment_BTS.csv")
glimpse(raw_news_comment)
library(stringr)
library(textclean)
news_comment <- raw_news_comment %>%
  select(reply) %>%
  mutate(id = row_number(),
         reply = str_replace_all(reply, "[^가-힣]", " "),
         reply = str_squish(reply))
news_comment %>% select(id, reply)
# 품사 기준 토큰화
library(tidytext)
library(KoNLP)
comment_pos <- news_comment %>% 
  unnest_tokens(input = reply,output = word,token = SimplePos22,drop = F)
# 한 행이 한 품사를 구성하도록 분리
library(tidyr)
comment_pos <- comment_pos %>%separate_rows(word, sep = "[+]")
comment_pos %>% select(word, reply)
# 명사, 동사, 형용사 추출
comment <- comment_pos %>%
  separate_rows(word, sep = "[+]") %>%
  filter(str_detect(word, "/n|/pv|/pa")) %>%
  mutate(word = ifelse(str_detect(word, "/pv|/pa"),
                       str_replace(word, "/.*$", "다"),
                       str_remove(word, "/.*$"))) %>%
  filter(str_count(word) >= 2) %>%
  arrange(id)
# 유의어 통일하기
comment <- comment %>%
  mutate(word = case_when(str_detect(word, "축하") ~ "축하",
                          str_detect(word, "방탄") ~ "자랑",
                          str_detect(word, "대단") ~ "대단",
                          str_detect(word, "자랑") ~ "자랑",
                          T ~ word))
# 단어를 댓글별 한 행으로 결합
line_comment <- comment %>% group_by(id) %>%
  summarise(sentence = paste(word, collapse = " "))
line_comment
# 바이그램 토큰화
bigram_comment <- line_comment %>% 
  unnest_tokens(input = sentence,output = bigram,token = "ngrams",n = 2)
bigram_comment
# 바이그램 단어쌍 분리
bigram_seprated <- bigram_comment %>% separate(bigram, c("word1", "word2"), sep = " ")
bigram_seprated
# 단어쌍 빈도 구하기
pair_bigram <- bigram_seprated %>% count(word1, word2, sort = T) %>% na.omit()
pair_bigram
# 네트워크 그래프 데이터 만들기
library(tidygraph)
set.seed(1234)
graph_bigram <- pair_bigram %>%
  filter(n >= 3) %>%
  as_tbl_graph(directed = F) %>%
  mutate(centrality = centrality_degree(),
         group = as.factor(group_infomap()))
graph_bigram
library(ggraph)
set.seed(1234)
ggraph(graph_bigram, layout = "fr") +
  geom_edge_link() +
  geom_node_point(aes(size = centrality,
                      color = group),
                  show.legend = F) +
  geom_node_text(aes(label = name),
                 repel = T,
                 size = 5) +
  theme_graph()
# 그래프 꾸미기
library(showtext)
font_add_google(name = "Nanum Gothic", family = "nanumgothic")
set.seed(1234)
ggraph(graph_bigram, layout = "fr") + # 레이아웃
  geom_edge_link(color = "gray50", # 엣지 색깔
                 alpha = 0.5) + # 엣지 명암
  geom_node_point(aes(size = centrality, # 노드 크기
                      color = group), # 노드 색깔
                  show.legend = F) + # 범례 삭제
  scale_size(range = c(4, 8)) + # 노드 크기 범위
  geom_node_text(aes(label = name), # 텍스트 표시
                 repel = T, # 노드밖 표시
                 size = 5, # 텍스트 크기
                 family = "nanumgothic") + # 폰트
  theme_graph() # 배경 삭제 




