#p.17
coin <- function(n) {
  r <- runif(n,min=0,max=1)
  result <- numeric()
  for (i in 1:n){
    if(r[i] <= 0.5)
      result[i] <- 0
    else
      result[i] <- 1
  }
  return(result)
}
coin(10)

montaCoin <- function(n) {
  cnt <- 0
  for(i in 1:n) {
    cnt <- cnt + coin(1)
  }
  result <- cnt / n
  return(result)
}

montaCoin(10)
montaCoin(30)
montaCoin(100)
montaCoin(1000)
montaCoin(10000)

#p.19
library(RSADBE)
data("Bug_Metrics_Software")
Bug_Metrics_Software[ , , 1]
#행단위
rowSums(Bug_Metrics_Software[,,1])
rowMeans(Bug_Metrics_Software[ , , 1])
#열단위
colSums(Bug_Metrics_Software[ , , 1])
colMeans(Bug_Metrics_Software[ , , 1])

#p.20
seq(-2,2,by=.2)
vec <- 1:10
min(vec)
max(vec)
range(vec)
mean(vec)
median(vec)
sum(vec)
sd(rnorm(10))
table(vec)

n =1000
rnorm(n,mean=0,sd=1)
hist(rnorm(n,mean=0,sd=1))

n <- 1000
runif(n,min=0,max=10)
hist(runif(n,min=0,max=10))

n <- 20
rbinom(n, 1, prob = 1 /2 )
rbinom(n, 2, 0.5)
rbinom(n, 10, 0.5)
n <- 1000
rbinom(n, 5, prob = 1 / 6)

rnorm(5, mean = 0, sd = 1)
set.seed(123)
rnorm(5, mean = 0, sd = 1) 
set.seed(123)
rnorm(5, mean = 0, sd = 1)
set.seed(345)
rnorm(5, mean = 0, sd = 1)

#p.22
vec = 1:10
proc(vec)
prod(vec)
factorial(5)
abs(-5)
sqrt(16)
vec
cumsum(vec)
log(10)
log10(10)

#p.23
x <- matrix(1:9,nrow=3,ncol = 3,byrow=T) ;x
y <- matrix(1:3,nrow=3);y
ncol(x)
nrow(x)
t(x)
cbind(x,1:3)
rbind(x,10:12)
diag(x)
det(x)
apply(x,1,sum)
apply(x,2,mean)
svd(x)
eigen(x)
x%*%y

#p.24
x <- c(1,2,3,4,5)
y <- c(5)
x%%y

x <- matrix(c(1,4,2,3),nrow=2);x
y <- matrix(c(1,3,2,4,5,6),nrow=2);y
x%*%y

z <- matrix(c(1,2,3,4,5,6,7,8,9),nrow=3) ;z
x%*%z

c(1,2,3) %*% c(4,5,6)

#p.25
x <- matrix(c(1,4,2,3),nrow=2) ;x
y <- matrix(c(1,3,2,4),nrow=2) ;y

x%/%y
z <- matrix(c(1,2,3,4,5,6,7,8,9),nrow=3)
x%/%z

x%in%y
sum(x%in%y)

#p.27
x <- c(1,3,5,7,9)
y <- c(3,7)
union(x,y)
setequal(x,y)
intersect(x,y)
setdiff(x,y)
setdiff(y,x)
5%in%y
























