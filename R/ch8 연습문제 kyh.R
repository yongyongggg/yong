########R ch8 연습문제
setwd('C:\\Rwork\\dataset3\\dataset3')
#문제1
library(ggmap)
university <- read.csv("university.csv")
university
seoul <- c(left = 126.77, bottom = 37.40, right = 127.17, top = 37.70)
map <- get_stamenmap(seoul, zoom=11, maptype='watercolor')
#정적 지도 생성
layer1 <- ggmap(map)
layer1
#지도위에 포인트
layer2 <- layer1 + geom_point(data=university, aes(x=LON,y=LAT, color=학교명), size=3)
layer2
#지도위에 텍스트 추가
layer3 <- layer2 + geom_text(data=university, aes(x=LON+0.01, y=LAT+0.01,label=학교명), size=5)
layer3
#지도 저장
ggsave("university.png",width=10.24,height=7.68)

#문제2
p<- ggplot(data=diamonds, aes(x=carat, y=price, colour=clarity))
p + geom_point() + geom_smooth()

#문제3
library(latticeExtra)
xyplot(min.temp + max.temp ~ day | month, data=SeatacWeather, type="l", layout=c(3,1))

#문제4
#1)
depthgroup<-equal.count(quakes$depth, number=3, overlap=0)
#2)
magnitudegroup<-equal.count(quakes$mag, number=2, overlap=0)
#3)
xyplot(lat ~ long | magnitudegroup*depthgroup, data=quakes, main="Fiji Earthquakes", ylab="latitude", xlab="longitude", 
       pch="@",col=c("red","blue"))





