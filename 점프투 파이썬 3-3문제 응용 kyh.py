#김용현

#문제 3-1 오른쪽 정렬하기
cnt =tot = 0
while cnt <5 :
    cnt += 1
    tot = '*'*cnt
    print(f'{tot:>5}')

for i in range(1,6) :
     tot = '*'*i
     print(f'{tot:>5}')
#문제 3-2 5에서 작아지기
cnt = 6
while cnt > 1 :
    cnt -= 1
    print('*'*cnt)

#문제 3-3 가운데 정렬
cnt = -1
tot = 0
while cnt <11 :
    cnt += 2
    tot = '*'*cnt
    print(f'{tot:^15}')