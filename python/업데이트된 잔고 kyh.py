########김용현
#1번 문제
data =[10000,5000,8000]
def main_func(data) :
    dataset =data
    def inner_func() :
        mon = dataset[0] +dataset[1]-dataset[2]
        return mon
    return inner_func

inner_func=main_func(data)
inner_func()
money = main_func(data)
print('업데이트된 잔고 : ',format(money,',d'))

#1번 문제 정답
def outer_func(a1,a2,a3) :
    b1= a1
    b2= a2
    b3= a3
    def tot() :
        update = b1+b2-b3
        return update
    return tot
tot1=outer_func(10000,5000,8000)
tot1_val=tot1()
print('업데이트된 잔고 : ',format(tot1_val,',d'))

#2번문제
from math import sqrt
data =[10000,5000,8000]
def main_func(data) :
    dataset =data
    def inner1_func() :
        mon_val = dataset[0] +dataset[1]-dataset[2]
        return mon_val
    def inner2_func(mon) :
        SQRT= sqrt(mon)
        return SQRT
    return inner1_func, inner2_func

money, SQRT = main_func(data)
money = money()
print('업데이트된 잔고 : ',format(money,',d'))
SQRT = SQRT(money)
print('SQRT : ',SQRT)

#2번 문제 정답
from math import sqrt
def outer_func(a1,a2,a3) :
    b1= a1
    b2= a2
    b3= a3
    def tot() :
        update = b1+b2-b3
        return update
    def sqrt1(bal) :
        squared = sqrt(bal)
        return squared
    return tot, sqrt1

tot2, sqrt2 = outer_func(10000,5000,8000)
tot2_val = tot2()
print('업데이트된 잔고 : ',format(tot2_val,',d'))
sqrt2_val=sqrt2(tot2_val)
print('SQRT : ',sqrt2_val)

#문제3
from math import sqrt
def outer_func(a1,a2,a3,a4) :
    b1= a1
    b2= a2
    b3= a3
    b4= a4
    def tot() :
        update = b1+b2-b3
        return update
    def sqrt1(bal) :
        squared = sqrt(bal)
        return squared
    def sqrt2(sqrt) :
        sqrt3 = sqrt * b4
        return sqrt3
    return tot, sqrt1, sqrt2

tot2, sqrt2, sqrt3 = outer_func(10000,5000,8000,3)
tot2_val =tot2()
print('업데이트된 잔고 : ',format(tot2_val,',d'))
sqrt2_val = sqrt2(tot2_val)
print('SQRT : ',sqrt2_val)
sqrt3_val = sqrt3(sqrt2_val)
print('SQRT "곱하는수" : ',sqrt3_val)

#문제 현재 잔고, sqrt값, 곱한 값을 계산하는 사용자정의 함수를 정의하세요
#조건
#외부함수 1개(현잔고, 입금액, 출금액, 곱하는수
#내부함수 3개
# 1)현잔고, 입금액, 출금액을 계산하여 업데이트된 잔고를 계산
# 2)업데이트된 잔고에 SQRT값을 계산(form math import sqrt, sqrt()사용)
# 3)SQRT 값에 '곱하는 수'를  곱하여 결과를 산출
#업데이트된 잔고액, SQRT값, 3번쨰 내부함수에서 계산된 결과를 프린트
#현잔고 10000원, 입금액 5000, 출금액 8000
#곱하는 수 3
