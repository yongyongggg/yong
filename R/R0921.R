dim(available.packages())
head(a)
install.packages(("stringr"))
library(stringr)
a <-10
b <-3
a <-available.packages()
search()
require(stringr)
data()
sessionInfo()
hist(Nile)
hist(Nile,freq = F)
lines(density(Nile))

getwd()
setwd('C:/Rwork')
getwd()

#p.4
var1 <- 0
var1
var1=1
var1
var2 =1
var2
var3=3
var3

goods.code <- 'a001'
goods.name <- '냉장고'
goods.price <- 850000
goods.des <- '최고사양, 동급 최고 품질'

age <- 35
names <- '홍길동동'
age
names

age <- 35
names <- c("홍길동", "이순신", "유관순")
age
names

int <- 20
int
string <- "홍길동"
string
boolean <- TRUE
boolean
sum(10, 20, 20)
sum(10, 20, 20, NA)
sum(10, 20, 20, NA, na.rm = TRUE)
ls()
sum(1:2,3:5)
is.character(string)
x <- is.numeric(int)
x
is.logical(boolean)
is.logical(x)
is.na(x)


x <- c(1, 2, "3")
x
result <- x * 3
result <- as.numeric(x) * 3
#result <- as.integer(x) * 3
result

z <- 5.3 - 3i
Re(z)
Im(z)
is.complex(x)
as.complex(5.3)

mode(int)
mode(string)
mode(boolean)
class(int)
class(string)
class(boolean)

gender <- c("man", "woman", "woman", "man", "man")
# plot(gender)

Ngender <- as.factor(gender)
table(Ngender)
plot(Ngender)
mode(Ngender)
class(Ngender)
is.factor(Ngender)

args(factor)
Ogender <- factor(gender, levels = c("woman", "man"), ordered = T)
Ogender

par(mfrow = c(1, 2))
plot(Ngender)
plot(Ogender)

as.Date("20/02/28", "%y/%m/%d")
class(as.Date("20/02/28", "%y/%m/%d"))
dates <- c("02/28/20", "02/30/20", "03/01/20")
as.Date(dates, "%m/%d/%y") 

Sys.getlocale(category = "LC_ALL")
Sys.getlocale(category = "LC_COLLATE")

Sys.time()

sdate <- "2019-11-11 12:47:5"
class(sdate)
today <- strptime(sdate, format = "%Y-%m-%d %H:%M:%S")
class(today)

args(max)
max(10, 20, NA, 30)
example(seq)
example(max)
example(mean)
mean(10:20)
x <- c(0:10, 50)
mean(x)

setwd("C:/Rwork/dataset1/dataset1")
data <- read.csv("test.csv", header = T)
data


