########평가2 프로그래밍 언어 응용 평가
####김용현

#문항1
message2 =['ham','ham','spam','ham','spam','spam','ham']
spam_list = [i for i in message2 if i =='ham']
print(spam_list)

#문항2
cnt = tot= num =0
while cnt <200 :
    cnt += 2
    num += 1
    if num % 2 != 0:
        tot += cnt
    else:
        tot += (cnt*-1)

print('숫자의 합 :',tot)

#문항3
cnt = -1
tot= num = 0
list = []
while num <100 :
    cnt += 2
    num += 1
    tot = '*'*cnt
    list.append(cnt)
    print(f'{tot:^199}')

print('50층의 별의 갯수 :',list[49])
a=list[49]*'*'
floor=f'{a:^199}'
b=floor.find('*')
print('50층에서 왼쪽 공백의 수 : ',b)


#문항4
def Account(balance,deposit,withdraw) :
    bal =balance
    depo =deposit
    wit =withdraw
    update = bal +depo -wit
    def getbal() :
        return update
    def tot() :
        total = update*0.13
        return total
    return getbal, tot

getb, tot1 = Account(200,50,190)
getbal=getb()
tot2=tot1()
print('업데이트된 잔고는',getbal,'원 입니다.')
print("월 이자액은 %.2f원 입니다."%tot2)
#print('이자액 :', round(r,2))
##0.13%이기 때문에 0.0013을 곱해줘야한다.
#%와 %포인트 구별하기




