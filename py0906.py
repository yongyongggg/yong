#p.170 다형성
class Flight:
    def fly(self):
        print('날다, fly 원형 메서드')
class Airplane(Flight) :
    def fly(self):
        print('비행기 날다.')
class Bird(Flight) :
    def fly(self):
        print('새가 날다.')
class PaperAirplane(Flight) :
    def fly(self):
        print('종이 비행기 날다')

flight = Flight()
air = Airplane()
bird = Bird()
paper = PaperAirplane()


flight.fly()

flight=air
flight.fly()

flight= bird
flight.fly()

flight = paper
flight.fly()

#p.173 builtins 모듈 내장클래스
#리스트 열거형 객체 이용
lst = [1,3,5]
for i,c in enumerate(lst) :
    print('색인 :',i,end=', ')
    print('내용 :',c)

#딕트 열거형 객체 이용
dit = {'name':'홍길동','jot':'회사원','addr':'서울시'}
for i, k in enumerate(dit) :
    print('순서 :',i,end=', ')
    print('키 :',k,end=', ')
    print('값 :',dit[k])

#p.174 import 모듈 내장 클래스 예
import datetime
from datetime import date,time

today = date(2022,9,6)
print(today)
print(today.year)
print(today.month)
print(today.day)
w = today.weekday()
print('요일 정보 : ',w)

currTime = time(21,4,30,9999)
print(currTime) #초아래 소수점은 6자리가 디폴트값이다.
print(currTime.hour)
print(currTime.minute)
print(currTime.second)
isoTime =currTime.isoformat()
print(isoTime)

#p.178 p.177 모듈 불러와서 사용하기
import myPackage.scattering

data =[1,3,1.5,2,1,3.2]
print('평균 :', myPackage.scattering.Avg(data))
var,sd=myPackage.scattering.var_sd(data)
print('분산 :', var)
print('표준편차 :',sd)

from myPackage.scattering import Avg, var_sd
print('평균 :',Avg(data))
var, sd = var_sd(data)
print('분산 :',var)
print('표준편차 :',sd)

#p.180 프로그램 시작점이 있는 경우
import myPackage.scattering
#p.181 프로그램 시작점이 없는 경우
import myPackage.scattering2











