#####06장 연습문제
####김용현

#문제1
print("사각형의 넓이와 둘레를 계산합니다.")
w = int(input('사각형의 가로 입력 :'))
h= int(input('사각형의 세로 입력 :'))

class Rectangle :
    width =0
    height =0
    def __init__(self,width,height):
        self.width = width
        self.height = height
    def area_calc(self):
        area= self.width * self.height
        return area
    def circum_calc(self):
        circum=(self.width+self.height)*2
        return circum

print('_'*30)
Rectangle = Rectangle(w,h)
print('사각형의 넓이 :',Rectangle.area_calc())
print('사각형의 둘레 :',Rectangle.circum_calc())
print('_'*30)

#문제2
from statistics import mean
from math import  sqrt
x = [5,9,1,7,4,6]

class Scattering :
    def __init__(self):
        pass
    def var_func(self,data):
        self.data =data
        self.avg = mean(self.data)
        diff = [(d - self.avg) ** 2 for d in self.data]
        self.var = sum(diff) / (len(self.data) - 1)
        return self.var
    def std_func(self) :
        sd = sqrt(self.var)
        return sd
scattering = Scattering()
var1=scattering.var_func(x)
sd1=scattering.std_func()

print('분산 :',var1)
print('표준편차 :',sd1)

#문제3
class Person :
    def __init__(self,age,name,gender):
        self.name =name
        self.gender =gender
        self.age =age
    def display(self):
        if self.gender == 'female' :
            print('='*30)
            print('이름 :',self.name,end=',')
            print('성별 : 여자')
            print('나이 :',self.age)
            print('=' * 30)
            return
        else :
            print('=' * 30)
            print('이름 :', self.name, end=',')
            print('성별 : 남자')
            print('나이 :', self.age)
            print('=' * 30)
            return

name = input('이름 : ')
age = int(input('나이 : '))
gender = input('성별(male/female) : ')
p = Person(age, name, gender)
p.display()


#문제4
class Employee :
    name = None
    pay = 0
    def __init__(self,name):
        self.name=name

class Permanent(Employee) :
    def __init__(self,name):
        super().__init__(name)
    def pay_calc(self,base,bonus):
        self.pay = base + bonus
        print('=' * 30)
        print('고용형태 : 정규직')
        print('이름 :',self.name)
        print('급여 : ',format(self.pay,',d'),'원')

class Temporary(Employee) :
    def __init__(self,name):
        super().__init__(name)
    def pay_calc(self,tpay,time):
        self.pay =tpay*time
        print('=' * 30)
        print('고용형태 : 임시직')
        print('이름 :', self.name)
        print('총 수령액 : ',format(self.pay,',d'),'원')

empType = input('고용형태 선택(정규직<P>, 임시직<T>) : ')
if empType == 'P' or empType =='p' :
    name = input('이름 :')
    base = int(input('기본금 :'))
    bonus = int(input('상여금 :'))
    p= Permanent(name)
    p.pay_calc(base,bonus)
elif empType == 'T' or empType == 't':
    name = input('이름 :')
    time = int(input('작업시간 :'))
    tpay = int(input('시급 :'))
    t = Temporary(name)
    t.pay_calc(tpay, time)
else :
    print('=' * 30)
    print('입력 오류')

#문제5
#모듈 작성하기
def example(x,y) :
    Add = x+y
    Sub = x-y
    Mul = x*y
    Div = x/y
    return Add, Sub, Mul, Div
#모듈 import 하기
from myCalcPackage.calcModule import example
x=int(input())
y=int(input())
Add,Sub,Mul,Div=example(x,y)
print('x=',x,';','y=',y,'일 때')
print('Add=',Add)
print('Sub=',Sub)
print('Mul=',Mul)
print('Div=',Div)









