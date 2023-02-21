#########평가 3
######김용현

#문제 1
import random
#1)
a=random.uniform(1,5)
print(' 1과 5 사이의 실수 난수 :',a)
#2)
b=random.randint(1,5)
print('1과 5사이의 정수 난수 :',b)
#문제 2
class Account :
    balance =0
    deposit =0
    withdraw =0
    def __init__(self,balance,deposit,withdraw):
        self.bal = balance
        self.dep = deposit
        self.wit = withdraw
    def getbalance(self):
        self.getbal = self.bal + self.dep - self.wit
        return self.getbal
    def getbalance2(self):
        getbal2 = self.getbal * 0.001
        return getbal2

account = Account(20000,15000,13000)
a=account.getbalance()
print('현재 잔액 :'+format(a,',d')+'원')
b=account.getbalance2()
print('이자액 :'+format(b)+'원')

#문제 3
class Account :
    balance = 0
    deposit = 0
    withdraw = 0
    def __init__(self,balance,deposit,withdraw):
        self.bal = balance
        self.dep = deposit
        self.wit = withdraw
    def getbal(self):
        getbal1 = self.bal+self.dep-self.wit
        return getbal1

class getbalance(Account) :
    def __init__(self,balance,deposit,withdraw):
        super().__init__(balance,deposit,withdraw)
        self.getbalan = self.bal + self.dep - self.wit
    def getbalan1(self) :
        self.getbal2 = self.getbalan * 0.001
        return self.getbal2
    def getbalan2(self):
        getbal3= (self.getbal2+self.getbalan) * 0.1
        return getbal3
p= Account(20000,15000,13000)
p1=p.getbal()
print('현재 잔액 :'+format(p1,',d')+'원')
p2=getbalance(20000,15000,13000)
p3=p2.getbalan1()
print('이자액 :'+format(p3)+'원')
p4=p2.getbalan2()
print('세금액 :'+format(p4)+'원')

#문제 4
# Exception

#문제 5
import re
p = re.compile('.*[.]([^b].?.?|.[^a]?.?|..?[^t]?)')
m = p.search('autoexec.bat')
print(m)
#autoexec.ba라는 결과와 매치된다.