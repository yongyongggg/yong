##########빅데이터 처리시스템 개발
#######김용현
#문제1
download.file(
  "https://github.com/r-spark/okcupid/raw/master/profiles.csv.zip",
  "okcupid.zip")

unzip("okcupid.zip", exdir = "data")
unlink("okcupid.zip")

#문제2
library(dplyr)
profiles <- read.csv("data/profiles.csv")
write.csv(dplyr::sample_n(profiles, 10^3),
          "data/profiles.csv", row.names = FALSE)

#문제3
library(sparklyr)
library(ggplot2)
library(dbplot)
library(dplyr)
sc <- spark_connect(master = "local", version = "3.0.0")

#문제4
okc <- spark_read_csv(
  sc, 
  "data/profiles.csv", 
  escape = "\"", 
  memory = FALSE,
  options = list(multiline = TRUE)
)

#문제5
okc <- okc %>% mutate(
    height = as.numeric(height),
    income = ifelse(income == "-1", NA, as.numeric(income))) 

#문제6
okc <- okc %>% mutate(sex = ifelse(is.na(sex), "missing", sex)) %>%
  mutate(drinks = ifelse(is.na(drinks), "missing", drinks)) %>%
  mutate(drugs = ifelse(is.na(drugs), "missing", drugs)) %>%
  mutate(job = ifelse(is.na(job), "missing", job))

#문제7
okc <- okc %>%
  mutate(
    not_working = ifelse(job %in% c("student", "unemployed", "retired"), 1 , 0))

#문제8
data_splits <- sdf_random_split(okc, training = 0.7, testing = 0.3, seed = 100)
okc_train <- data_splits$training
okc_test <- data_splits$testing

#문제9
scale_values <- okc_train %>%
  summarize(mean_age = mean(age),sd_age = sd(age)) %>%collect()

scale_values

#문제10
okc_train <- okc_train %>%
  mutate(scaled_age = (age - !!scale_values$mean_age) /
           !!scale_values$sd_age)
dbplot_histogram(okc_train, scaled_age)
