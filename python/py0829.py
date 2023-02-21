#변수 사용하기
a=[1,2,3]
b=a
b
#변수 영향 알아보기
a[1]=4
a
b
#다른 주소를 가르키는 법
a=[1,2,3]
b =a[:]
a[1]=4
a
b
#copy 모듈 사용하기
from copy import copy
a = [1,2,3]
b = copy(a)
b is a
a = [1,2,3]
b=a.copy()
b is a
#변수를 만드는 여러가지 방법
a,b = ('python','life')
(a,b)='python','life'
[a,b]=['python','life']
a= b='python'
#두 변수의 값 바꾸기
a=3
b=5
a,b=b,a
a
b

#논리 연산자
# A  B     and   or   xor
# T  T     T     T    F
# T  F     F     T    T
# F  T     F     T    T
# F  F     F     F    F

#########책 시작
#p.37 자료형 확인하기
var1 = "Hello python"
print(var1)
print(type(var1))

var1= 100
print(var1)
print(type(var1))

var2= 105.25
print(type(var2))

var3 = True
print(type(var3))

#p.38 자료형 변환
#실수 -> 정수
a= int(10.5)
b= int(20.42)
add= a+b
print('add = ', add)
#정수 -> 실수
a= float(10)
b= float(20)
add2= a+b
print('add2 = ', add2)
#논리형 -> 정수
print(int(True))
print(int(False))
#문자형 -> 정수
st='10'
print(int(st)**2)

#p.39 산술연산자
num1 =100
num2 =20

add= num1 + num2
print(add)

sub= num1 - num2
print(sub)

mul= num1 *num2
print(mul)

div= num1 /num2
print(div)

div2= num1 % num2
print(div2)

square = num1**2
print(square)

#p.40 관계연산자
bool_result = num1 ==num2
print(bool_result)

bool_result= num1 != num2
print(bool_result)

bool_result = num1 > num2
print(bool_result)

bool_result = num1 >= num2
print(bool_result)

bool_result = num1 < num2
print(bool_result)

bool_result = num1 <= num2
print(bool_result)

#p.40 논리연산자
log_result = num1 >=50 and num2 <=10
print(log_result)

log_result = num1 >=50 or num2 <=10
print(log_result)

log_result = num1 >=50
print(log_result)

log_result = not(num1 >=50)
print(log_result)

#p.41 대입연산자
i = tot = 10
i += 1
tot += i
print(i, tot)

print('출력1', end= ' , ')
print('출력2', end=(' . '))
print('출력3')

v1 , v2= 100, 200
v2, v1= v1, v2
print(v1, v2)

#패깅 할당
### *있는 곳에 몰아서 할당하고 나머지는 하나씩 가진다
lst =[1,2,3,4,5]
v1, *v2, v3 =lst
print(v1, v2 ,v3)

v1, v2, v3, *v4 = lst
print(v1,v2,v3,v4)

lst1=(1,2,3,4,5,6,7)
v1, v2, v3, *v4 =lst1
print(v1,v2,v3,v4)

#p.43 표준입력장치
num = input('숫자입력 : ')
print('num type : ', type(num))
print(num)
print(num*2)

num1= int( input('숫자 입력 : '))
print('num1 = ', num1*2)

num2 = float(input('숫자 입력 : '))
result = num1 + num2
print('result = ', result)

#p.45 표준출력장치
temp1 = 10+20+30+40+50
print('value = ', temp1 )

print('010','3156','5245',sep='-')

#p.46 format과 양식문자
print('원주율= ', format(3.14159, "8.3f"))
print('금액= ', format(10000, "10d"))
print('금액= ',format(12500000,'3,d'))

name= '홍길동'
age = 35
price=125.456
print('이름: %s, 나이 : %d, data= %.2f' %(name, age, price))

# p.47 외부상수 출력
print('이름 : {}, 나이 : {}, data= {}'.format(name, age, price))
print('이름 : {1}, 나이 : {0}, data = {2}'.format(age,name,price))

uid = input('id input : ')
query = f"select * from member where wud = {uid}"
print(query)

#p.48 문자열
oneLine = "this is one line string"
print(onLine)

multiLine ="""this is
multi line
string"""
print(multiLine)

multiLine2 = "this is \nmulti line\nstring"
print(multiLine2)

#p.49 문자열 색인
string = "python"
print(string[0])
print(string[-5])

print('python' + 'program')
print("python-" + str(3.7) + '.exe')
# 숫자는 문자열로 변환 후 합칠수 있다.

print('*'*30)

#p.50 슬라이싱
print(oneLine)
print('문자열 길이 : ', len(oneLine))
print(oneLine[0:4])
print(oneLine[:4])
print(oneLine[:])
print(oneLine[::2])

print(oneLine[0:-1:2])
print(oneLine[-6:-1])
print(oneLine[-6:])

substring =oneLine[-11:]
print(substring)

#p.52 문자열 처리함수
oneLine = 'This is one line string'
len(oneLine)
'{0:>28}'.format(oneLine)
oneLine.lower()
oneLine.upper()
print('t 글자수 :', oneLine.count('t'))

print(oneLine.swapcase())
print(oneLine.startswith('this'))
print(oneLine.startswith('that'))

print(oneLine.replace('this','that'))

multiLine = '''this is
multi line
string'''
sent =multiLine.split('\n')
print('문자 : ',sent)

words = oneLine.split(' ')
print('문자 : ', words)

sent2 = ','.join(words)
print(sent2)

#p.54 이스케이프 문자 차단 기능
print('escape 문자 차단')
print('\n출력 이스케이프 문자')

print('\\n출력 이스케이프 기능 차단1')
print(r'\n출력 이스케이프 기능 차단2')

print('path =','c:\python\test')
print('path =','c:\\python\\test')
print('path =',r'c:\python\test')

#03장
#p.61 단일 조건문
var= 10
if var >= 5:
    print('var =', var)
    print('var는 5보다 크다')
    print('조건이 참인 경우 실행')

print('항상 실행')

score = int(input('점수 입력 : '))
if score >= 80 and score <=100 :
    print('우수')
else:
    if score>= 70 :
            print('보통')
    else :
        print('저조')

#p.62 중첩 조건문
score = int(input('점수 입력 : '))
grade = ''
if score >=80 and score <=100 :
    grade = '우수'
elif score >=70 :
    grade = '보통'
elif score >= 50 :
    grade = '저조'
else :
    grade = '미달'
print('당신의 점수는 %d이고, 등급은 %s입니다'%(score,grade))

#p.63 삼항 조건문
#일반 조건문
num = 9
result = 0
if num >= 5 :
    result = num *2
else :
    result = num *2
print('result = ', result)

#3항 연산자(조건문)
result2 = num*2 if num >= 5 else num +2
print('result2 = ',result2)

#p.65 while 반복문
cnt = tot = 0
while cnt <5 :
    cnt += 1
    tot += cnt
    print (cnt, tot)

cnt = tot = 0
dataset = []

while cnt < 100 :
    cnt += 1
    if cnt % 3 == 0 :
        tot += cnt
        dataset.append(cnt)

print('1~100 사이 3의 배수의 합 = %d' % tot)
print ('dataset =',dataset)

#문제
cnt = tot = 0
dataset = []
while cnt < 100 :
    cnt +=1
    if cnt % 5 == 0 and cnt % 3 != 0 :
        tot += cnt
        dataset.append(cnt)

print('1~100 사이에서 5의 배수이면서 3의 배수가 아닌 수의 합 = %d '% tot)
print('dataset = ',dataset)


cnt = tot = 0
cnt2 = -1
cnt3 = 0
dataset = []
while cnt2 < 99 :
    cnt +=1
    cnt2 += 2
        if (cnt2 % 2) != 0 :
            tot += (cnt2*-1)
        else :
            tot += cnt2
            dataset.append(cnt2)

print(tot)
rint('1~100 사이에서 5의 배수이면서 3의 배수가 아닌 수의 합 = %d '% tot)
print('dataset = ',dataset)

cnt = -1
tot = 0
dataset = []
while cnt <99 :
    cnt =+ 2
    if cnt % 2 != 0 :
        tot += (cnt*-1)
    else:
        tot += cnt
        dataset.append(cnt)