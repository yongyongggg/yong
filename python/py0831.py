#p.69 break, continue
import audioop

i=0
while i < 10:
    i += 1
    if i == 3:
        continue
    if i == 6:
        break
    print(i, end=' ')

#p.70 for
string = '홍길동'
print(len(string))
for s in string :
    print(s)

lstest =[1,2,3,4,5]
dataset = []
for e in lstest :
    e *= 2
    dataset.append(e)
    print('원소 : ', e)

print(dataset)

#p.72 range
num1 = range(10)
print('num1 : ', num1)

num2 = range(1, 10)
print('num2 : ',num2)

num3 = range(1,10,2)
print('num3 : ', num3)

for n in num1 :
    print(n , end= ' ')

for n in num2 :
    print(n , end= ' ')

for n in num3 :
    print(n , end= ' ')

#p.73 list 자료구조 예
import random
lst = []
for i in range(10) :
    r = random.randint(1,10)
    lst.append(r)

print('lst : ', lst)

for i in range(10) :
   print(lst[i]*0.25,end=' ')

#p.74 구구단
for i in range(2, 10) :
    print('~~~ {}단 ~~~'.format(i))
    for j in range(1,10) :
        print('%d * %d = %d'%(i,j,i*j))

#p.75 문장과 단어 추출
string = '''나는 홍길동 입니다.
주소는 서울시 입니다.
나이는 35세 입니다.'''

sents = []
words = []
for sen in string.split(sep='\n') :
    sents.append(sen)
    for word in sen.split() :
        words.append(word)

print('문장 : ', sents)
print('문장수 : ',len(sents))
print('단어 :', words)
print('단어수 : ',len(words))

#p.83 str 클라스 객체 예
str_var=str(object='string')
print(str_var)
print(type(str_var))
print(str_var[0])
print(str_var[-1])

str_var2='string'
print(str_var2)
print(type(str_var2))
print(str_var2[0])
print(str_var2[-1])

#p.85
lst =[1,2,3,4,5]
print(lst)
print(type(lst))

for i in lst :
    print(lst[:i])

#p.86
x=list(range(1,11))
print(x)
print(x[:5])
print(x[::2])

#p.87
a=['a','b','c']
b=[10,20,a,5,True,'문자열']
print(b[2])
print(b[2][0])

#p.88 추가 삭제 수정 삽입 예
num = ['one','two','three','four']
print(len(num))
num.append('five')
print(num)
num.remove(num[3])
print(num)
num[3]='4'
print(num)
num.insert(0,'zero')
print(num)

#p.89
x=[1,2,3,4]
y=[1.5,2.5]
z=x+y
print(z)
a=y+x
print(a)
x.extend(y)
print(x)
x.append(y)
print(x)
lst=[1,2,3,4]
result=lst *2
print(result)

#p.90 요소 검사
print(result)
result.sort()
print(result)
result.sort(reverse=True)
print(result)

import random
r = []
for i in range(5) :
    r.append(random.randint(1,5))

print(r)
if 4 in r :
    print('있음')
else:
    print('없음')

#p.92 리스트 내포 예
#형식 1 변수 = [실행문 for 변수 in 열거형 객체]
x=[2,4,1,5,7]
lst = [i**2 for i in x]
print(lst)
#형식2 변수 = [실행문 for 변수 in 열거형객체 if 조건식]
num = list(range(1,11))
lst2 = [i*2 for i in num if i %2 ==0 ]
print(lst2)
#형식3 변수 = [값1 if 조건 else 값2 for 변수 in 열거형객체]
lst3 =[i*2 if i % 2 ==0 else i*0 for i in range(1,11)]
print(lst3)

#p.93 튜플 객체
t = (10,)
print(t)

t2=(1,2,3,4,5,3)
print(t2)

print(t2[0],t2[1:4],t2[-1])

for i in t2 :
    print(i, end=' ')
if 6 in t2 :
    print("있음")
else:
    print("없음")

#p.95 튜플 관련 함수
lst = list(range(1,6))
t3=tuple(lst)
print(t3)

print(len(t3),type(t3))
print(t3.count(4))
print(t3.index(1))

#p.96 set 집합
s = {1,3,5,3,1}
print(len(s))
print(s)

for d in s :
    print(d, end=' ')

s2= {3,6}
print(s.union(s2))
print(s.difference(s2))
print(s.intersection(s2))

s3={1,3,5}
s3.add(7)
print(s3)
s3.discard(3)
print(s3)

#p.98 중복제거
gender = ['남','여','남','여']
sgender=set(gender)
lgender=list(sgender)
print(lgender)

# p.99 dict 딕트객체 예
dic = dict(key1=100,key2=200,key3=300)
print(dic)

person = {'name':'hong','age':35,'address':'서울시'}
print(person)
print(person['age'])

person['age'] = 45
print(person)
del person['address']
print(person)

person['pay'] = 350
print(person)

print('age' in person)
for key in person.keys() :
    print(key)
for v in person.values() :
    print(v)
for i in person.items() :
    print(i)

#p.101 요소검사
charset = ['abc','code','band','band','abc']
wc = {}
for key in charset :
    wc[key] = wc.get(key,0) +1
print(wc)

for key in charset :
    if key in wc :
       wc[key] +=1
    else:
        wc[key] =1

print(wc)

#p.102 객체 주소 복사
name = ['홍길동','이순신','강감찬']
print('name adress =',id(name))
name2 = name
print('name2 adress =',id(name2))

name2[0] = '김길동'
import copy
name3= copy.deepcopy(name)
print('name adress =',id(name))
print('name3 adress =',id(name3))
print('name2 adress =',id(name2))




