#######ch8 고급시각화
#p. 2 격자형 기법 시각화
#lattice 패키지 사용 준비하기
#1단계: lattice 패키지 설치
install.packages("lattice")
library(lattice)
#2단계: 실습용 테이터 가져오기
install.packages("mlmRev")
library(mlmRev)
data("Chem97")
str(Chem97)
head(Chem97, 30)
Chem97

#p.4 histogram()함수를 이용하여 데이터 시각화
histogram(~gcsescore, data = Chem97)
#score 변수를 조건변수로 지정하여 데이터 시각화하기
histogram(~gcsescore | score, data = Chem97)
histogram(~gcsescore | factor(score), data = Chem97)

#p.5 밀도 그래프
#densityplot()함수를 사용하여 밀도 그래프 그리기
densityplot(~gcsescore | factor(score), data = Chem97,
            groups = gender, plot.Points = T, auto.ley = T)



#p.6막대 그래프
#1단계: 기본 데이터 셋 가져오기
data(VADeaths)
VADeaths
#2단계: VAdeaths 데이터 셋 구조보기
str(VADeaths)
class(VADeaths)
mode(VADeaths)
#3단계: 데이터 형식 변경(matrix형식을 table 형식으로 변경)
dft <- as.data.frame.table(VADeaths)
str(dft)
dft
#4단계: 막대 그래프 그리기
barchart(Var1 ~ Freq | Var2, data = dft, layout = c(4, 1))
#5단계: origin 속성을 사용하여 막대 그래프 그리기
barchart(Var1 ~ Freq | Var2, data = dft, layout = c(4, 1), origin = 0)


#p.8 점그래프
#dotplot()함수를 사용하여 점 그래프 그리기
#1단계: layout 속성이 없는 경우
dotplot(Var1 ~ Freq | Var2, dft)
#2단계: layout 속성을 적용한 경우
dotplot(Var1 ~ Freq | Var2, dft, layout = c(4, 1))
#점을 선으로 연결하여 시각화히기
dotplot(Var1 ~ Freq, data = dft,
        groups = Var2, type = "o",
        auto.key = list(space = "right", points = T, lines = T))


#p.9 산점도 그래프
#1단계: airquality 데이터 셋 가져오기
library(datasets)
str(airquality)
#2단계: xyplot()함수를 사용하여 산점도 그리기
xyplot(Ozone ~ Wind, data = airquality)
#3단계: 조건변수를 사용하는 xyplot()함수로 산점도 그리기
xyplot(Ozone ~ Wind | Month, data = airquality)
#4단계: 조건변수와 layout속성을 사용하는 xyplot()함수로 산점도 그리기
xyplot(Ozone ~ Wind | Month, data = airquality, layout = c(5, 1))
#5단계: Month변수를 factor타입으로 변환하여 산점도 그리기 (패널 제목에는 factor값을 표시)
convert <- transform(airquality, Month = factor(Month))
str(convert)
xyplot(Ozone ~ Wind | Month, data = convert)


#quakes 데이터 셋으로 산점도 그래프 그리기
#1단계: quakes 데이터 셋 보기
head(quakes)
str(quakes)
#2단계: 지진 발생 진앙지(위도와 경도) 산점도 그리기
xyplot(lat ~ long, data = quakes, pch = ".")
#3단계: 산점도 그래프를 변수에 저장하고, 제목 문자열 추가하기
tplot <- xyplot(lat ~ long, data = quakes, pch = ".")
tplot <- update(tplot, main = "1964년 이후 태평양에서 발생한 지진 위치")
print(tplot)

#이산형 변수를 조건으로 지정하여 산점도 그리기
#1단계: depth 변수의 범위 확인
range(quakes$depth)
#2단계: depth 변수 리코딩: 6개의 범주(100단위)로 코딩 변경
quakes$depth2[quakes$depth >= 40 & quakes$depth <= 150] <- 1
quakes$depth2[quakes$depth >= 151 & quakes$depth <= 250] <- 2
quakes$depth2[quakes$depth >= 251 & quakes$depth <= 350] <- 3
quakes$depth2[quakes$depth >= 351 & quakes$depth <= 450] <- 4
quakes$depth2[quakes$depth >= 451 & quakes$depth <= 550] <- 5
quakes$depth2[quakes$depth >= 551 & quakes$depth <= 680] <- 6
#3단계: 리코딩된 변수(depth2)를 조건으로 산점도 그리기
convert <- transform(quakes, depth2 = factor(depth2))
xyplot(lat ~ long | depth2, data = convert)


#동일한 패널에 두 개의 변수값 표현하기
xyplot(Ozone + Solar.R ~ Wind | factor(Month), 
       data = airquality, 
       col = c("blue", "red"),
       layout = c(5, 1))



#p.12 데이터 범주화
#(equal.count()함수를 사용하여 이산형 변수 범주화하기
#1단계: 1~150 을 대상으로 겹치지 않게 4개 영역으로 범주화
numgroup <- equal.count(1:150, number = 4, overlap = 0)
numgroup
#2단계: 지진의 깊이를 5개 영역으로 범주화
depthgroup <- equal.count(quakes$depth, number = 5, overlap = 0)
depthgroup
#3단계: 범주화된 변수(depthgroup)를 조건으로 산점도 그리기
xyplot(lat ~ long | depthgroup, data = quakes, 
       main = "Fiji Earthquakes(depthgroup)",
       ylab = "latitude", xlab = "longitude", 
       pch = "@", col = "red")

#수심과 리히터 규모 변수를 동시에 적용하여 산점도 그리기
#1단계: 리히터 규모를 2개 영역으로 구분
magnitudegroup <- equal.count(quakes$mag, number = 2, overlap =0)
magnitudegroup
#2단계: margintudegroup변수를 기준으로 산점도 그리기
xyplot(lat ~ long | magnitudegroup, data = quakes, 
       main = "Fiji Earthquakes(magnitude)",
       ylab = "latitude", xlab = "longitude", 
       pch = "@", col = "blue")
#3단계: 수심과 리히터 규모를 동시에 표현(2행 5열 패널 구현)
xyplot(lat ~ long | depthgroup * magnitudegroup, data = quakes, 
       main = "Fiji Earthquakes", 
       ylab = "latitude", xlab = "longitude", 
       pch = "@", col = c("red", "blue"))


#이산형 변수를 리코딩한 뒤에 factor형으로 변환하여 산점도 그리기
#1단계: depth변수 리코딩
quakes$depth3[quakes$depth >= 39.5 & quakes$depth <= 80.5] <- 'd1'
quakes$depth3[quakes$depth >= 79.5 & quakes$depth <= 186.5] <- 'd2'
quakes$depth3[quakes$depth >= 185.5 & quakes$depth <= 397.5] <- 'd3'
quakes$depth3[quakes$depth >= 396.5 & quakes$depth <= 562.5] <- 'd4'
quakes$depth3[quakes$depth >= 562.5 & quakes$depth <= 680.5] <- 'd5'
#2단계: mag변수 리코딩
quakes$mag3[quakes$mag >= 3.95 & quakes$mag <= 4.65] <- 'm1'
quakes$mag3[quakes$mag >= 4.55 & quakes$mag <= 6.65] <- 'm2'
#3단계: factor형 변환
convert <- transform(quakes,
                     depth3 = factor(depth3),
                     mag3 = factor(mag3))
#4단계: 산점도 그래프 그리기
xyplot(lat ~ long | depth3 * mag3, data = convert,
       main = "Fiji Earthquakes", 
       ylab = "latitude", xlab = "longitude",
       pch = "@", col = c("red", "blue"))




#p.15 조건 그래프
#depth 조건에 의해서 위도와 경도의 조건 그래프 그리기
coplot(lat ~ long | depth, data = quakes)

#(조건의 구간 크기와 겹침 간격 적용 후 조건 그래프 그리기
#1단계: 조건의 구간 막대기가 0, 1 단위로 겹쳐 범주화
coplot(lat ~ long | depth, dat = quakes,
       overlap = 0.1)
#2단계: 조건 구간을 5개로 지정하고, 1행 5열의 패널로 조건 그래프 작성
coplot(lat ~ long | depth, data = quakes, 
       number = 5, row = 1)

#패널과 조건 막대에 색을 적용하여 조건 그래프 그리기
#1단계: 패널 영역에 부드러운 곡선 추가
coplot(lat ~ long | depth, data = quakes,
       number = 5, row = 1, 
       panel = panel.smooth)
#2단계: 패널 영역과 조건 막대에 색상 적용
coplot(lat ~ long | depth, data = quakes, 
       number = 5, row = 1, 
       col = 'blue',
       bar.bg = c(num = 'green'))



#p.17 3차원 산점도 그래프
#위도, 경도, 깊이를 이용하여 3차원 산점도 그리기
cloud(depth ~ lat * long, data = quakes, 
      zlim = rev(range(quakes$depth)),
      xlab = "경도", ylab = "위도", zlab = "깊이")

#테두리와 회전 속성을 추가하여 3차원 산점도 그래프 그리기
cloud(depth ~ lat * long, data = quakes, 
      zlim = rev(range(quakes$depth)),
      panel.aspect = 0.9, 
      screen = list(z = 45, x = -25),
      xlab = "경도", ylab = "위도", zlab = "깊이")






#기하학적 기법 시각화
#p.18 ggplot2 패키지설치와 실습 데이터 가져오기
library(ggplot2)
  data(mpg)
str(mpg)
head(mpg)
summary(mpg)
table(mpg$drv)


#qplot()함수의 fill과 binwidth 속성 적용
#1단계: 도수 분포를 세로 막대 그래프로 표현
qplot(hwy, data = mpg)
#2단계: fill속성 적용
qplot(hwy, data = mpg, fill = drv)
#3단계: binwidth 속성 적용
qplot(hwy, data = mpg, fill = drv, binwidth = 2)

#(facets속성을 사용하여 drv변수값으로 행/열 단위로 패널 생성
#1단계: 열 단위 패널 생성
qplot(hwy, data = mpg, fill = drv, facets = . ~ drv, binwidth = 2)
#2단계: 행 단위 패널 생성
qplot(hwy, data = mpg, fill = drv, facets = drv ~ ., binwidth = 2)



#qplot()함수에서 color속성을 사용하여 두 변수 구분하기
#1단계: 두변수로 displ과 hwy변수 사
qplot(displ, hwy, data = mpg)
#2단계: 두 변수로 displ과 hwy변수 사용하며 dry변수에 색상 적용
qplot(displ, hwy, data = mpg, color = drv)

#displ과 hwy변수의 관계를 driv변수로 구분하기
qplot(displ, hwy, data = mpg, color = drv, facets = . ~ drv)



#미적요소 맵핑(mapping)
#mtcars 데이터 셋에 색상, 크기, 모양 적용하기
#1단계: 실습용 데이터 셋 확인하기
head(mtcars)
#2단계: 색상 적용
qplot(wt, mpg, data = mtcars, color = factor(carb))
#3단계: 크기 적용
qplot(wt, mpg, dat = mtcars, 
      size = qsec, color = factor(carb))
#4단계: 모양 적용
qplot(wt, mpg, data = mtcars, 
      size = qsec, color = factor(carb), shape = factor(cyl))


#기하하적 객체 적용
#diamonds 데이터 셋에 막대, 점, 선 레이아웃 적용하기
#1단계: 실습용 데이터 셋 확인하기
head(diamonds)
#2단계: geom속성과 fill속성 사용
qplot(clarity, data = diamonds, fill = cut, geom = "bar")
#3단계: 테두리 색 사용
qplot(clarity, data = diamonds, colour = cut, geom = "bar")
#4단계: geom=”point”속성으로 산점도 그래프 그리기
qplot(wt, mpg, data = mtcars, size = qsec, geom = "point")
#5단계: 산점도 그래프에 cyl변수의 요인으로 포인트 크기 적용 & carb변수의 요인으로 포인트 색 적용
qplot(wt, mpg, data = mtcars, size = factor(cyl),color = factor(carb), geom = "point")
#6단계: 산점도 그래프에 qsec변수의 요인으로 포인트 크기 적용 & cyle변수의 요인으로 포인트
#모양 적용
qplot(wt, mpg, data = mtcars, size = qsec, 
      color = factor(carb),
      shape = factor(cyl), geom = "point")
#7단계: geom=”smooth”속성으로 산점도 그래프에 평활 그리기
qplot(wt, mpg, data = mtcars, 
      geom = c("point", "smooth"))
#8단계: 산점도 그래프의평활에 cyl변수의 요인으로 색상 적용하기
qplot(wt, mpg, dat = mtcars, color = factor(cyl), 
      geom = c("point", "smooth"))
#9단계: geom=”line” 속성으로 그래프 그리기
qplot(mpg, wt, data = mtcars, 
      color = factor(cyl), geom = "line")
#10단계: geom=c(“point”, “line”)속성으로 그래프 그리기
qplot(mpg, wt, data = mtcars, 
      color = factor(cyl), geom = c("point", "line"))



#p.23ggplot()함수
#aes()함수 속성을 추가하여 미적 요소 맵핑하기)
#1단계: diamonds데이터 셋에 미적 요소 맵핑
p <- ggplot(diamonds, aes(carat, price, color = cut))
p + geom_point()
#2단계: mtcars데이터 셋에 미적 요소 맵핑
p <- ggplot(mtcars, aes(mpg, wt, color = factor(cyl)))
p + geom_point()


#기하학적 객체 적용
#geom_line()과 geom_point()함수를 적용하여 레이어 추가
#1단계: geom_line()레이어 추가
p <- ggplot(mtcars, aes(mpg, wt, color = factor(cyl)))
p + geom_line()
#2단계: geom_point레이어 추가
p <- ggplot(mtcars, aes(mpg, wt, color = factor(cyl)))
p + geom_point()

# 미적 요소 맵핑과 기하학적 객체 적용
#stat_bin()함수를 사용하여 막대 그래프 그리기
#1단계: 기본 미적 요소 맵핑 객체를 생성한 뒤에 stat_bin()함수 사용
p <- ggplot(diamonds, aes(price))
p + stat_bin(aes(fill = cut), geom = "bar")
#2단계: price빈도를 밀도(전체의 합=1)로 스케일링하여 stat_bin()함수 사용
p + stat_bin(aes(fill = ..density..), geom = "bar")


#stat_bin()함수 적용 영역과 산점도 그래프 그리기
#1단계: stat_bin()함수 적용 영역 나타내기
p <- ggplot(diamonds, aes(price))
p + stat_bin(aes(fill = cut), geom = "area")
#2단계: stat_bin()함수로 산점도 그래프 그리기
p + stat_bin(aes(color = cut, 
                 size = ..density..), geom = "point")


#산점도에 회귀선 적용하기
library(UsingR)
data("galton")
p <- ggplot(data = galton, aes(x = parent, y = child))
p + geom_count() + geom_smooth(method ="lm")


#테마(Theme) 적용
#1단계: 제목을 설정한 산점도 그래프
p <- ggplot(diamonds, aes(carat, price, color = cut))
p <- p + geom_point() + ggtitle("다이아몬드 무게와 가격의 상관관계")
print(p)
#2단계: theme()함수를 이용하여 그래프의 외형 속성 적용
p + theme(
  title = element_text(color = "blue", size = 25), 
  axis.title = element_text(size = 14, face ="bold"),
  axis.title.x = element_text(color = "green"),
  axis.title.y = element_text(color = "green"),
  axis.text = element_text(size = 14),
  axis.text.y = element_text(color = "red"),
  axis.text.x = element_text(color = "purple"),
  legend.title = element_text(size = 20,
                              face = "bold",
                              color = "red"),
  legend.position = "bottom",
  legend.direction = "horizontal"
)



#p.27 그래프를 이미지 파일로 저장하기
#1단계: 저장할 그리기
p <- ggplot(diamonds, aes(carat, price, color = cut))
p + geom_point()
#2단계: 가장 최근에 그려진 그래프 저장
ggsave(file = "C:/Rwork/output/diamond_price.pdf")
ggsave(file = "C:/Rwork/output.diamond_price.jpg", dp = 72)


#변수에 저장된 그래프를 이미지 파일로 저장하기
p <- ggplot(diamonds, aes(clarity))
p <- p + geom_bar(aes(fill = cut), position = "fill")
ggsave(file = "C:/Rwork/output/bar.png",
       plot = p, width = 10, height = 5)


#p.28 지도 공간 기법 시각화
#지도 관련 패키지 설치
library(ggplot2)
install.packages("ggmap")
library(ggmap)

#서울을 중심으로 지도 시각화
#1단계: 서울 지역의 중심 좌표 설정
seoul <- c(left = 126.77, bottom = 37.40, 
           right = 127.17, top = 37.70)
#2단계: zoom, maptype으로 정적 지도 이미지 가져오기
map <- get_stamenmap(seoul, zoom = 12, maptype = 'terrain')
ggmap(map)

#2019년도 1월 대한민국 인구수를 기준으로 지역별 인구수 표시
#1단계: 데이터 셋 가져오기
pop <- read.csv(file.choose(), header = T)
library(stringr)
region <- pop$'지역명'
lon <- pop$LON
lat <- pop$LAT
tot_pop <- as.numeric(str_replace_all(pop$'총인구수', ',', ''))
df <- data.frame(region, lon, lat, tot_pop)
df
df <- df[1:17, ]
df
#2단계: 정적 지도 이미지 가져오기
daegu <- c(left = 123.4423013, bottom = 32.8528306,
           right = 131.601445, top = 38.8714354)
map <- get_stamenmap(daegu, zoom = 7, maptype = 'watercolor')
#3단계: 지도 시각화하기
layer1 <- ggmap(map)
layer1
#4단계: 포인트 추가
layer2 <- layer1 + geom_point(data = df, aes(x = lon, y = lat,
            color = factor(tot_pop), size = factor(tot_pop)))
Layer2                            
#5단계: 텍스트 추가
layer3 <- layer2 + geom_text(data = df, 
                             aes(x = lon + 0.01, y = lat + 0.08,
                                 label = region), size = 3)
layer3
#6단계: 크기를 지정하여 파일로 저장
ggsave("pop201901.png", scale = 1, width = 10.24, height = 7.68)

















