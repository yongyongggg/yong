######김용현
#문제1
#단계1
lst = [10,1,5,2]
result = lst *2
print(result)
#단계2
a=lst[0]*2
result.append(a)
print(result)
#단계3
result2=result[1::2]
print(result2)

#문제2
#A형
import random
list=[]
vector =int(input('vector 수 : '))
for i in range(vector) :
    r= random.randint(1,10)
    list.append(r)
    print(r)

print(len(list))

#B형
import random
list=[]
vector =int(input('vector 수 : '))
for i in range(vector) :
    r= random.randint(1,10)
    list.append(r)
    print(r)

vector1=int(input('찾을값  : '))
if vector1 in list :
    print ('YES')
else:
    print("NO")

#문제3
#A형
message = ['spam','ham','spam','ham','spam']
dummy = [1 if i=='spam' else 0 for i in message ]
print(dummy)

#B형
message = ['spam','ham','spam','ham','spam']
spam_list = [ i for i in message if i =='spam' ]


print(spam_list)

#문제4
position = ['과장','부장','대리','사장','대리','과장']
a= list(set(position))
print('중복되지 않은 직위 : ',a)
wc = {}
for key in position :
    wc[key] = wc.get(key,0) +1
print('각 직위별 빈도수 : ',wc)