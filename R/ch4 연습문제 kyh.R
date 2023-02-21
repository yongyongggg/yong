#########R ch4 연습문제
#####김용현

#문제1
EMP <- c("2014홍길동220","2002이순신300","2010유관순260")
install.packages('stringr')
library(stringr)
emp_pay<-function(x){
  pay=str_extract(x,'[0-9]{3}$')
  pay1=as.numeric(pay)
  pay2=mean(pay1)
  cat('전체급여 평균:',pay2,'\n')
  cat('평균 이상 급여 수령자','\n')
  for(n in 1:3) {
    if (pay1[n]>=pay2){
      cat(str_sub(x[n], 5, 7), '=>', str_sub(x[n], 8, 10),'\n')
    }
  }
}

emp_pay(EMP)


#문제2
name <- c('유관순', '홍길동', '이순신', '신사임당')
gender <- c('F','M','M','F')
price <- c(50, 65, 45, 75)

#1)
client = data.frame(name,gender,price)
client  
#2)
result =c()
for(n in 1:length(client$price)){
  result[n]=ifelse(client$price[n] >= 65, 'beat', 'Normal')
}
client_new=cbind(client,result);client_new 
#result=ifelse(client$price >= 65, 'beat', 'Normal')

#3)
table(client_new$result)
  
  
  
  
  


