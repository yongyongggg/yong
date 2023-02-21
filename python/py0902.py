#p.116 builtins 함수와 import 함수의 예
import random

dataset = list(range(1,6))
print(dataset)

print(len(dataset))
print(sum(dataset))
print(max(dataset))
print(min(dataset))

import statistics
from statistics import variance, stdev
print(statistics.mean(dataset))
print(statistics.median(dataset))
print(variance(dataset))
print(stdev(dataset))

# p.119 builtins 내장함수
#abs(x) x의 절대값을 반환한다.
abs(10)
abs(-10)
abs(-123.45)

#all(iterable) 모든 요소가 True 일 때 True를 반환한다.
all([1, True, 10,-15.2])
all([1, True, 0, -15.2])
all([1,False, 0, -15.2])

#anyl(iterable) 하나 이상의 요소가 True 일 때 True를 반환한다. 영(0)이 False 로 해석
any([1,False,0,-15.2])
any([False,0,0])

#bin(number) 10진수를 2진수로 반환, 2진수는 '0b'로 시작한다.
bin(10)
bin(15)

#dir(x) 객체 x에서 제공하는 변수, 내장함수, 내장클래스의 목록을 반환
x=[12,2,3,4,5]
dir(x)
x.append(6)
x

#eval(expr) 문자열 수식을 인수로 받아서 계산 가능한 파이썬 수식으로 변환한다.
a="10+30"
eval("10+20")
eval(a)
# eval(10+"20*30")의 형태는 오류가 발생한다
eval("20*30")+10

#hex(number) 10진수 정수를 16진수로 반환, 16진수는 '0x'로 문자열 시작한다.
hex(10)
hex(15)
hex(64)

#oct(number) 10진수 정수를 8진수로 반환, 8진수는 '0o'로 시작한다.
oct(10)
oct(7)

#ord(charactor) charactor 값을 아스키 값으로 반환한다.
# 숫자 영은 48, 영대문자 A는 65, 영소문자 a는 97이다
ord('0')
ord('9')
ord('A')
ord('Z')
ord('a')
ord('z')

#pow(x,y) x에대한, y의 제곱을 계산하여 반환한다.
pow(10,2)
pow(10,3)
pow(10,-1)
pow(10,-2)
pow(4,4)

#round(number) 실수를 인수로 하여 반올림을 수행하는 결과를 반환한다.
round(3.14159)
round(3.14159,3) #소수점 3자리까지 나타내라
#banker's rounding
round(2.5) #2로 반환하게 된다.

#sorted(iterable)
# 반복 가능한 원소들을 대상으로 오름차순 또는 내림차순으로 정렬한 결과
sorted([3,2,1,5])
sorted([3,2,1,5],reverse=True)
sorted([3,1,2,4,4,5,3,2,3])

#zip(iterable*) 반복가능한 객체 간의 원소들을 묶어서 튜플로 반환한다.
# 반환된 결과를 확인확인하기 위해서는 list로 변환해줘야함
zip([1,3,5],[2,4,6])
list(zip([1,3,5],[2,4,6]))
list(zip([1,3,5],[2,4]))
list(zip([1,3],[2,4,6]))

#p.123 사용자 정의 함수
#######사용자 정의 함수는 만든 후 꼮 호출을 해줘야함!!!########
#1. 인수가 없는 함수
def userFunc1 () :
    print('인수가 없는 함수')
    print('userFunc1')

userFunc1()

#2. 인수가 있는 함수
def userFunc2 (x, y) :
    print('userFunc2')
    z= x+y
    print('z = ', z)

userFunc2(10,30)

#3. return 있는 함수
def userFunc3 (x, y) :
    print('userFunc3')
    tot = x+y
    sub = x-y
    mul = x*y
    div = x/y

    return tot, sub, mul, div

x= int(input('x 입력 : '))
y= int(input('y 입력 : '))
userFunc3(x,y)
t,s,m,d = userFunc3(x,y)
print('tot = ',t)
print('sub =', s)
print('mul = ', m)
print('div = ', d)

#p.125 분산과 표준편차
from statistics import mean, variance
from math import sqrt
dataset = [2,4,5,6,1,8]
#산술 평균
def Avg(data) :
    avg= mean(data)
    return avg

print('산술 평균 :', Avg(dataset))
mean(dataset)

#분산 표준편차
def var_sd (data) :
    avg= Avg(data)
    diff = [(d-avg)**2/2 for d in data]
    var = sum(diff) / (len(data)-1)
    sd = sqrt(var)
    return var, sd

v, s = var_sd(dataset)
print('분산 = ', v)
print('표준편차 = ', s)

#p.127 피타고라스 정리
def pytha(s,t) :
    a= s**2 - t**2
    b= 2*s*t
    c= s**2 + t**2
    print('3변의 길이 : ', a,b,c)

pytha(2, 1)
pytha(5,4)

#p.127 몬테카를로 시뮬레션 함수 예
import random
def coin(n) :
    result = []
    for i in range(n) :
        r =random.randint(0,1)
        if r==1 :
            result.append(1)
        else:
            result.append(0)
    return  result

print(coin(10))

def montaCoin(n) :
    cnt = 0
    for i in range(n) :
        cnt += coin(1)[0]
    result = cnt/n
    return result

print(montaCoin(10))
print(montaCoin(30))
print(montaCoin(100))
print(montaCoin(1000))
print(montaCoin(10000))
print(montaCoin(1000000))

#p.129 가변인수 함수
#튜플형 가변인수
def Func1(name, *names) :
    print(name)
    print(names)

Func1('김','이','박','황')

from statistics import mean, variance, stdev
#통계량을 구하는 함수
def statis (func, *data) :
    if func == 'avg' :
        return mean(data)
    elif func == 'var' :
        return variance(data)
    elif func =='std' :
        return stdev(data)
    else:
        return 'TypeError'

print('avg=',statis('avg',1,2,3,4,5))
print('var=',statis('var',1,2,3,4,5))
print('std=',statis('std',1,2,3,4,5))

#딕트형 가변인수
def emp_func(name, age, **other):
    print(name)
    print(age)
    print(other)

emp_func('홍길동','35',addr='서울시',height=175,weight=65)

#p.131 람다 함수
#일반함수
def Adder(x,y) :
    add =x+y
    return add

print(Adder(10,20))

#람다함수
print('add=',(lambda x,y :x+y)(10,20))

#p.133 스코프
x= 50
def local_func(x):
    x += 50
local_func(x)
print('x=',x)

#전역변수
def global_func() :
    global x
    x += 50

global_func()
print('x=',x)

#p.134
def a () :
    print('a 함수')
    def b():
        print('b 함수')
    return b

b= a()
b()

#함수 클로저
data =list(range(1,101))
def outer_func(data) :
    dataSet = data
    def tot() :
        tot_val =sum(dataSet)
        return tot_val
    def avg(tot_val) :
        avg_val =tot_val/len(dataSet)
        return avg_val
    return tot, avg

tot, avg = outer_func(data)

tot()
tot_val=tot()
print('tot=',tot_val)
avg_val =avg(tot_val)
print('avg =', avg_val)

#p.135 산포도를 구하는 중첩함수
from statistics import mean,variance
from math import sqrt

data=[4,5,3.5,2.5,6.3,5.5]
def scattering_func(data) :
    dataSet =data
    def avg_func():
        avg_val = mean(dataSet)
        return avg_val
    def var_func(avg) :
        diff = [(data-avg)**2 for data in dataSet]
        print(sum(diff))
        var_val = sum(diff) /(len(dataSet)-1)
        return var_val
    def std_func(var) :
        std_val =sqrt(var)
        return std_val
    return avg_func,var_func,std_func

avg, var, std =scattering_func(data)
print(avg())
var1=var(avg())
print(var1)
std1=std(var(avg()))
print(std1)

#p.137 획득자 지정자
def main_func(num) :
    num_val = num
    def getter () :
        return num_val
    def setter(value) :
        nonlocal num_val
        num_val =value
    return getter, setter

getter, setter = main_func(100)

print('num =',getter())
setter(200)
print('num =',getter())

#함수 장식자 wrap
def wrap (func) :
    def decorated() :
        print('반가워요!')
        func()
        print('잘가요!')
    return decorated

@wrap
def hello() :
    print('hi ~', '홍길동')

hello()















