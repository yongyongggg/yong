#03장 연습문제
#김용현

#문제1
#A형
while True :
    num = int(input('짐의 무게는 얼마 입니까? '))

    if num < 10 :
        print ('수수료는 없습니다.')
    else:
        print('수수료는 10,000원 입니다.')

#B형
while True :
    num = int(input('짐의 무게는 얼마 입니까? '))
    if num < 10 :
        print('수수료는 없습니다.')
    else:
        price = (num // 10) * 10000
        print('수수료는 ',format(price,'3,d'),'원 입니다.')
# .format 형태에서는 세자리마다 ,사용이 불가하다.
# print(f'수수료는 {price:,3}원 입니다.')
#문제2
import random
print('>>숫자 맞추기 게임<<')
com = random.randint(1,10)

while True :
    my = int(input('예상 숫자를 입력하시오 :'))
    if my > com :
        print('더 작은수 입력')
    elif my < com :
        print('더 큰수 입력')
    elif my == com :
        print('~~성공~~')
        break


#문제3
tot = 0
dataset = []
for i in range(1,101) :
    if i % 3==0 and i % 2 !=0 :
        dataset.append(i)
        tot += i

print('누적합 = ', tot)
print('수열 = ', dataset)


#문제4
multiline ="""안녕하세요. 파이썬 세계로 오신걸
환영합니다.
파이썬은 비단뱀 처럼 매력적인 언어입니다."""
words = []
sents = []
for sent in multiline.split('\n') :
    sents.append(sent)
    for word in sent.split(' ') :
        words.append(word)
        print(word)
print('단어 개수 : ', len(words))











