#p.66 무한 루프
numData = []
while True :
    num = int(input('숫자 입력 : '))

    if num % 10 == 0 :
        print('프로그램 종료')
        break
    else:
        print(num)
        numData.append(num)

#p.67 random 관련 함수 1예
#랜덤 모듈 추가
import random
help(random)
#random 모듈의 함수 도움말
help(random.random)

#0~1사이 난수 실수
r = random.random()
print('r = ',r)

cnt=0
while True :
    r = random.random()
    print(random.random())
    if r<0.01:
        break
    else:
        cnt += 1
print('난수 갯수 = ',cnt)

#random 관련 함수2
help(random.randint)

#list 전체 이름, 특정이름 출력
names = ['홍길동','이순신','유관순']
print(names)
print(names[2])

if '유관' in names :
    print('유관순 있음')
else:
    print('유관순 없음')

idx= random.randint(0,2)
print(names[idx])
random.seed(12)
a=[1,2,3.4,4,5,6,7,8,9,10,11,12,14,13,1]
type(a)
random.choice(a)
random.choices(a,k=2)
random.randint(4,11)
random.random()
random.sample(a,2)
random.uniform(4,9)
random.normalvariate(30,2)
help(random.choices)