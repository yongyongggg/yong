##########빅데이터 품질관리시스템 개발
####김용현

#문항1
#install.packages("data.table")
library(data.table)

#문항2
pisa <- fread("pisa2015.csv", na.strings = "")

#문항3
print(object.size(pisa), unit = "GB")

#문항4
eastasia2 <- subset(pisa, CNT %in%  c("Korea", "Japan"))
fwrite(eastasia2, file = "eastasia2.csv")

#문항5
pisa

#문항6
tail(pisa$CNTRYID,10)

#문항7
pisa[CNTRYID %in% c("Korea", "Japan"),
     table(ST063Q01NA)]

#문항8
pisa[CNTRYID %in% c("Korea","Japan"),
     .(xbar = mean(SCIEEFF, na.rm = T),
       sigma = sd(SCIEEFF, na.rm = T),
       minimum = min(SCIEEFF, na.rm = T),
       med = median(SCIEEFF, na.rm = T),
       maximum = max(SCIEEFF, na.rm = T))]

#문항9
pisa[CNTRYID %in% c("Korea", "Japan"),
     .(tense = factor(ST118Q04NA, levels = c("Strongly disagree", "Disagree", "Agree", "Strongly agree")))
][,
  table(tense)
]

#문항10
pisa[CNTRYID %in% c("Korea","Japan"),
     .(plot(y = SCIEEFF, x = JOYSCIE, 
            col = rgb(red = 0, green = 0, blue = 0, alpha = 0.3)), 
       xbar.joyscie = mean(JOYSCIE, na.rm = T))]






