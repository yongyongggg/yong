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

name[1]= '이순신장군'
print(name)
print(name3)

#점프투 파이썬 02-8 리스트 복사
a = [1,2,3]
b= a[:]
a[1] = 4
print(id(a))
print(id(b))
from copy import copy
b=copy(a)
#자체 모듈 사용
b =a.copy()

#p.104 최댓값/ 최솟값 구하는 알고리즘
import random
dataset = []
for i in range(10) :
    r = random.randint(1,100)
    dataset.append(r)

print(dataset)

vmax = vmin = dataset[0]

for i in dataset :
    if vmax < i :
        vmax = i
    if vmin > i :
        vmin = i

print('vmax =', vmax, 'min =', vmin)

#p.108
dataset = [5,10,18,22,35,55,75,103]
value = int(input('검색할 값 입력 : '))
low= 0
high = len(dataset)-1
loc=0
state = False

while (low <= high) :
    mid = (low+high) //2
    if dataset[mid] >value:
        high = mid -1
    elif dataset[mid] <value :
        low = mid +1
    else:
        loc = mid
        state = True
        break

if state :
    print('찾은 위치 : %d 번째'%(loc+1))
else:
    print('찾는 값은 없습니다.')

#p.116 builtins 함수와 import 함수의 예
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