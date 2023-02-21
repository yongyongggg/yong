#p.140 재귀함수
# FIFO 선입선출 LIFO 후입선출
# 재쉬함수는 스책에 저장되기 때문에 출력을 하면 후입 선출의 형태를 가진다
def Counter(n) :
    if n == 0 :
        return 0
    else :
        Counter(n-1)
        print(n, end=" ")


print('n=0 : ', Counter(0))
Counter(5)


def Adder(n) :
    if n ==1 :
        return 1
    else:
        result = n + Adder(n-1)
        return result

print('n=1 :', Adder(1))
print('\nn=5', Adder(5))

#p.151 클래스 구성
#함수 정의
def calc_func(a,b):
    x =a
    y =b
    def plus() :
        p= x+y
        return p
    def minus() :
        m= x-y
        return m
    return plus, minus

p,m= calc_func(10,20)
print('plus = ',p())
print('minus= ',m())

#클래스 정의
class calc_class:
    x= y =0
    def __init__(self,a,b):
        self.x = a
        self.y = b
    def plus(self):
        p= self.x+self.y
        return p
    def minus(self):
        m = self.x-self.y
        return m


obj = calc_class(10,20)
print('plus =',obj.plus())
print('minus =',obj.minus())

#p.153 클래스 구성요소 예
class Car :
    cc=0
    door=0
    carType = None
    def __init__(self,cc,door,carType):
        self.cc =cc
        self.door=door
        self.carType=carType
    def display(self):
        print('자동차는 %d cc이고, 문짝은 %d개,타입은 %s'%(self.cc,self.door,self.carType))

car1 =Car(2000,4,'승용차')
car2= Car(3000,5,'SUV')
car1.display()
car2.display()
car2.cc

#p.157 self
class multiply3 :
    def data(self,x,y):
        self.x=x
        self.y=y
    def mul(self):
        result = self.x * self.y
        self.display(result)
    def display(self, result):
        print('곱셈 = %d'%(result))

obj=multiply3()
obj.data(10,20)
obj.mul()

#p.159 클래스 맴버
class DatePro:
    content = '날짜 처리 클래스'
    def __init__(self,year,month,day):
        self.year = year
        self.month = month
        self.day= day
    def display(self):
        print("%d-%d-%d"%(self.year,self.month,self.day))

    @classmethod
    def date_string(cls,dateStr):
        year = dateStr[:4]
        month = dateStr[4:6]
        day= dateStr[6:]
        print(f'{year}년 {month}월 {day}일')

data = DatePro(1995,10,25)
print(data.content)
print(data.year)
data.display()
data.year
print(DatePro.content)
# print(DatePro.year)
DatePro.date_string('19951025')

#p.161 캡슐화
class Account :
    __balance=0
    __accName = None
    __accNo = None
    def __init__(self,bal,name,no):
        self.__balance =bal
        self.__accName =name
        self.__accNo = no
    def getBalance(self):
        return self.__balance,self.__accName,self.__accNo
    def deposit(self,money):
        if money <0 :
            print('금액 확인')
            return
        self.__balance += money
    def withdraw(self,money):
        if self.__balance < money :
            print('잔액 부족')
            return
        self.__balance -= money

acc = Account(1000,'홍길동','125-152-4125-41')
# acc.__blance
bal =acc.getBalance()
print('계좌정보 : ',bal)
acc.deposit(10000)
bal =acc.getBalance()
print('계좌 정보 : ',bal)
acc.withdraw(9000)
bal =acc.getBalance()
print('계좌 정보 : ',bal)

#p.164 상속
class Super :
    def __init__(self,name,age):
        self.name = name
        self.age = age
    def display(self):
        print('name : %s, age : %d'%(self.name,self.age))

sup = Super('부모',55)
sup.display()

#자식 클래스
class Sub(Super) :
    gender = None
    def __init__(self,name,age,gender):
        self.name = name
        self.age =age
        self.gender =gender
    def display(self):
        print('name : %s, age: %d, gender : %s'%(self.name,self.age,self.gender))

sub = Sub('자식',25,'여자')
sub.display()

#p.166 super 예
class Parent :
    def __init__(self,name,job):
        self.name = name
        self.job =job
    def display(self):
        print('name : {}, job : {}'.format(self.name,self.job))

p = Parent('홍길동','회사원')
p.display()

class Children(Parent) :
    gender = None
    def __init__(self,name,job,gender):
        super().__init__(name,job)
        #Parent.__init__(self,name,job)
        self.gender =gender
    def display(self):
        print('name : {}, job : {}, gender : {}'.format(self.name,self.job,self.gender))

chil = Children('이순신','해군 장군','남자')
chil.display()

#p.168 매서드 재정의
class Employee :
    name = None
    pay = 0
    def __init__(self,name):
        self.name = name
    def pay_calc(self):
        pass

class Permanent(Employee) :
    def __init__(self,name):
        super().__init__(name)
    def pay_calc(self,base,bonus):
        self.pay = base + bonus
        print('총 수령액 : ',format(self.pay,',d'),'원')

class Temporary(Employee) :
    def __init__(self,name):
        super().__init__(name)
    def pay_calc(self,tpay,time):
        self.pay =tpay*time
        print('총 수령액 : ',format(self.pay,',d'),'원')

p =Permanent('이순신')
p.pay_calc(3000000,200000)
t = Temporary('홍길동')
t.pay_calc(15000,80)


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