#######ch3
#p.1
num <- scan()
num
sum(num)

name <- scan(what = character())
name

df = data.frame()
df = edit(df)
df

#p.3
getwd()
setwd("C:/Rwork/dataset1/dataset1")
student <- read.table(file = "student.txt")
student
names(student) <- c("번호", "이름", "키", "몸무게")
student

student <- read.table(file = "student.txt", header=T)
student

student1 <- read.table(file.choose(), header = TRUE)

student2 <- read.table(file = "student2.txt", sep = ";", header = TRUE)
student2 <- read.table(file = "student2.txt", sep = "\t", header = TRUE)
student2

student3 <- read.table(file = "student3.txt", header = TRUE, na.strings = "-")
student3

student4 <- read.csv(file = "student4.txt", sep = ",", na.strings = "-")
student4

#p.6 
titanic <-read.csv("https://vincentarelbundock.github.io/Rdatasets/csv/COUNT/titanic.csv")
titanic
dim(titanic)
str(titanic)

table(titanic$age)
table(titanic$sex)
table(titanic$survived)

head(titanic)
tail(titanic)

tab <- table(titanic$survived, titanic$sex)
tab

barplot(tab, col = rainbow(2), main = "성별에 따른 생존 여부")

#p.8
x <- 10
y <- 20
z <- x * y
cat("x * y의 결과는 ", z, "입니다.\n")
cat("x * y = ", z)
print(z)

#p.9
setwd("C:/Rwork")
library(RSADBE)
data("Severity_Counts")
sink("severity.txt")
severity <- Severity_Counts
severity
sink()

titanic
write.table(titanic, "titanic.txt", row.names = FALSE)

titanic_df <- read.table(file = "titanic.txt", sep = "", header = T)
titanic_df

setwd("C:/Rwork/")

st.df <- studentx      

write.csv(st.df, "stdf.csv", row.names = F, quote = F)













