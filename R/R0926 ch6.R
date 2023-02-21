######R ch6
#p.2
install.packages('dplyr')
install.packages("magrittr")
install.packages('lifecycle',type='binary')
install.packages('pillar',type='binary')
install.packages(c('dplyr','hflights'))
library(pillar)
library(magrittr)
library(lifecycle)
library(dplyr)
library(hflights)
csvgrade <- read.csv("grade_csv.csv")
csvgrade
csvgrade %>% head() %>% summary()
iris %>% head()  
iris %>% head() %>% subset(Sepal.Length >= 5.0)

1:5 %>% sum(.)
1:5 %>% sum(length(.))
5 %>% s %>% sum(1:.)
5 %>% {sum(1:.)}
  
csvgrade <- read.csv("grade_csv.csv")
csvgrade %>% subset(1:nrow(.) %% 2 == 0)

#p.4
str(hflights)
hflights_df <- tbl_df(hflights)
hflights_df

hflights <- hflights %>% tbl_df() 

csvgrade <- read.csv("grade_csv.csv")
csvgrade %>% filter(class == 1)
csvgrade <- read.csv("grade_csv.csv")
csvgrade %>% filter(class != 1)
csvgrade <- read.csv("grade_csv.csv")
csvgrade %>% filter(math > 50)
csvgrade <- read.csv("grade_csv.csv")
csvgrade %>% filter(math < 50)
library(dplyr)
csvgrade <- read.csv("grade_csv.csv")
csvgrade %>% filter(eng >= 80)
csvgrade <- read.csv("grade_csv.csv")
csvgrade %>% filter(eng <= 80)
csvgrade <- read.csv("grade_csv.csv")
csvgrade %>% filter(class == 1 & math >= 50)
csvgrade <- read.csv("grade_csv.csv")
csvgrade %>% filter(eng < 90 | sci < 50)

csvgrade <- read.csv("grade_csv.csv")
csvgrade %>% filter(class == 1 | class == 3 | class == 5)

csvgrade <- read.csv("grade_csv.csv")
csvgrade %>% filter(class %in% c(1, 3, 5))

csvgrade <- read.csv("grade_csv.csv")
class1 <- csvgrade %>% filter(class == 1)
mean(class1$math)
mean(class1$eng)
mean(class1$sci)

filter(hflights_df, Month == 1 & DayofMonth == 2)
hflights_df %>% filter(Month ==1 & DayofMonth ==1)
filter(hflights_df, Month == 1 | Month == 2)

#p.10
library(dplyr)
csvgrade <- read.csv("grade_csv.csv")
csvgrade %>% arrange(math)
csvgrade <- read.csv("grade_csv.csv")
csvgrade %>% arrange(desc(math))

csvgrade <- read.csv("grade_csv.csv")
csvgrade %>% arrange(class, math)

arrange(hflights_df, Year, Month, DepTime, ArrTime)
hflights_df %>% arrange(Year, Month, DepTime, AirTime) 

csvgrade <- read.csv("grade_csv.csv")
csvgrade %>% select(math)
csvgrade <- read.csv("grade_csv.csv")
csvgrade %>% select(class, math)
csvgrade <- read.csv("grade_csv.csv")
csvgrade %>% select(-math)
csvgrade <- read.csv("grade_csv.csv")
csvgrade %>% filter(class == 1 ) %>% select(eng)

csvgrade <- read.csv("grade_csv.csv")
csvgrade %>% select(id, math) %>% head(3)

select(hflights_df, Year, Month, DepTime, ArrTime)
hflights_df %>% select(hflights_df, Year, Month, DepTime, AirTime)
select(hflights_df, Year:ArrTime)

#p.15
mutate(hflights_df, gain = ArrTime - DepTime,gain_per_hour = gain / (AirTime / 60))
select(mutate(hflights_df, gain = ArrDelay - DepDelay, 
              gain_per_hour = gain / (AirTime / 60)),
       Year, Month, ArrDelay, DepDelay, gain, gain_per_hour)

#p.16
csvgrade <- read.csv("grade_csv.csv")
csvgrade %>% summarise(mean_math = mean(math))

summarise(hflights_df, avgAirTime = mean(AirTime, na.rm = TRUE))
summarise(hflights_df, cnt = n(),delay = mean(AirTime, na.rm = TRUE))
summarise(hflights_df, arrTimeSd = sd(ArrTime, na.rm = TRUE),arrTimeVar = var(ArrTime, na.rm = T))




                    