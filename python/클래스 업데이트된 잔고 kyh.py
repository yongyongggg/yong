#김용현

#문제1
class Account :
    balance =0
    deposit =0
    withdraw =0
    def __init__(self,balance,deposit,withdraw):
        self.bal = balance
        self.dep = deposit
        self.wit = withdraw
    def getbalance(self):
        getbalnce = self.bal + self.dep - self.wit
        return getbalnce

getbal = Account(10000,5000,8000)
getbal1=getbal.getbalance()
print('업데이트된 잔고 : ',format(getbal1,',d'))

#문제2
from math import sqrt
class Account :
    balance =0
    deposit =0
    withdraw =0
    def __init__(self,balance,deposit,withdraw):
        self.bal = balance
        self.dep = deposit
        self.wit = withdraw
    def getbalance(self):
        self.getbalance = self.bal + self.dep - self.wit
        return self.getbalance
    def sqrt(self):
        sqrt1 = sqrt(self.getbalance)
        return sqrt1


getbal = Account(10000,5000,8000)
getbal1=getbal.getbalance()
sqrt1=getbal.sqrt()
print('업데이트된 잔고 : ',format(getbal1,',d'))
print('sqrt 값 :',sqrt1)

#문제3
from math import sqrt
class Account :
    balance =0
    deposit =0
    withdraw =0
    number = 0
    def __init__(self,balance,deposit,withdraw,number):
        self.bal = balance
        self.dep = deposit
        self.wit = withdraw
        self.num = number
    def getbalance(self):
        self.getbalance = self.bal + self.dep - self.wit
        return self.getbalance
    def sqrt(self):
        self.sqrt1 = sqrt(self.getbalance)
        return self.sqrt1
    def mul(self):
        mul_val = self.sqrt1*self.num
        return mul_val


getbal = Account(10000,5000,8000,3)
getbal1=getbal.getbalance()
sqrt1=getbal.sqrt()
mul1=getbal.mul()
print('업데이트된 잔고 : '+format(getbal1,',d')+'원')
print('sqrt 값 :',sqrt1)
print('곱하는 수 :',mul1)
#문제 현재 자고를 조회하는 클래스를 정의하세요
#조건
#1)생성자(현잔고,입금액,출금액)
#method 3개
#2-1)현잔고, 입금액, 출금액을 계산하여 업데이트된 잔고를 계산
#2-2) 업데이트된 잔고에서 SQRT값을 계산 (from math import sqrt,sqrt()사용)
#2-3) SQRT값에 곱하는 수를 곱하여 결과를 산출
#3)현잔고:10000원, 입금액:5000원, 출금액:8000원
#4)업데이트된 잔고,SQRT값, 곱하는수를 프린트 하세요.
#5) 곱하는수 3