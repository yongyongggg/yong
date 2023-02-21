#p.18
install.packages('dplyr')
library(dplyr)
csvgrade <- read.csv("grade_csv.csv")
csvgrade %>% group_by(class) %>% summarise(mean_math = mean(math))

csvgrade <- read.csv("grade_csv.csv")
csvgrade %>% group_by(class) %>% summarise(mean_math = mean(math), sum_math= sum(math), median_math = median(math))

species <- group_by(iris, Species)
str(species)
species

df1 <- data.frame(x = 1:5, y = rnorm(5));df1
df2 <- data.frame(x = 2:6, z = rnorm(5));df2

inner_join(df1, df2, by = 'x')

a <- data.frame(id=c(1,2,3,4,5),score =c(60,80,70,90,85))
b <- data.frame(id=c(3,4,5,6,7),weight=c(80,90,85,60,85))
merge(a,b,by='id',all.x=T)
left_join(a,b,by='id')
left_join(df1,df2,by='x')

a <- data.frame(id = c(1, 2, 3, 4, 5), score = c(60, 80, 70, 90, 85))
b <- data.frame(id = c(3, 4, 5, 6, 7), weight = c(80, 90, 85, 60, 85))
merge(a,b,by='id',all.y = T)
right_join(a,b,by='id')
right_join(df1,df2,by='x')

#p.25
a <- data.frame(id = c(1, 2, 3, 4, 5), score = c(60, 80, 70, 90, 85))
b <- data.frame(id = c(3, 4, 5, 6, 7), weight = c(80, 90, 85, 60, 85))
merge(a,b,by='id',all=T)
full_join(a,b,by='id')
full_join(df1,df2,by='x')

#p.26
bind_rows(df1,df2)
bind_cols(df1,df2)
a <- data.frame(id = c(1, 2, 3, 4, 5), score = c(60, 80, 70, 90, 85))
b <- data.frame(id = c(3, 4, 5, 6, 7), weight = c(80, 90, 85, 60, 85))
bind_rows(a,b)

df1 <- data.frame(x = 1:5, y = rnorm(5));df1
df2 <- data.frame(x = 6:10, y = rnorm(5));df2
df_rows <- bind_rows(df1, df2);df_rows

a <- data.frame(id = c(1, 2, 3, 4, 5), score = c(60, 80, 70, 90, 85))
b <- data.frame(id = c(6, 7 , 8), score = c(80, 90, 85))
rbind(a,b)
df1;df2
df_cols <- bind_cols(df1, df2);df_cols

a <- data.frame(id = c(1, 2, 3, 4, 5), score = c(60, 80, 70, 90, 85))
b <- data.frame(age = c(20, 19 , 20, 19, 21), weight = c(80, 90, 85, 60, 85))
cbind(a, b)

a <- data.frame(id = c(1, 2, 3, 4, 5), score = c(60, 80, 70, 90, 85))
b <- data.frame(id = c(3, 4 , 5, 6, 7), weight = c(80, 90, 85, 60, 85))
cbind(a,b)

df <- data.frame(one = c(4, 3, 8)) ;df
df <- rename(df,'원'=one);df

df_rename <-rename(df_cols, x...2 = x...1)
df_rename <- rename(df_rename, y...1 = y...2)
df_rename

#p.30
install.packages("reshape2")
library(reshape2)
data <- read.csv("C:/Rwork/dataset3/dataset3/data.csv")
data
wide <- dcast(data, Customer_ID ~ Date, sum);wide

setwd("C:/Rwork/")
write.csv(wide, "wide.csv", row.names = FALSE)

wide <- read.csv("wide.csv")
colnames(wide) <- c('Customer_ID', 'day1', 'day2', 'day3','day4', 'day5', 'day6', 'day7')
wide

long <- melt(wide, id = "Customer_ID")
long

name <- c("Customer_ID", "Date","Buy")
colnames(long) <- name
head(long)

data("smiths")
smiths

long <- melt(id = 1:2, smiths)
long
dcast(long, subject + time ~ ...)


#p.33
data('airquality')
str(airquality)
airquality

names(airquality) <- toupper(names(airquality))
head(airquality)

air_melt <- melt(airquality, id = c("MONTH", "DAY"), na.rm = TRUE)
head(air_melt)

names(air_melt) <- tolower(names(air_melt))
acast <- acast(air_melt, day ~ month ~ variable)
acast
class(acast)









