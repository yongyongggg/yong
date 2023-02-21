import numpy as np
import pandas as pd

a= 123
a=-78
a = 1.2
a=3
b=5
a+b
a/b
a**b
a % b
b//a

say = '"Python is very easy." he says'
food='Pytho\'s favorite food is perl'
multiline = "Life is too short\nyou need python"
multiline = '''
life is too short
you need python
'''
print(multiline)

a="{{ and,or }}".format().0
d = {'name':'홍길동', 'age':30}
f'나의 이름은 {d["name"]}입니다. 나이는 {d["age"]+1}입니다.'

prompt = '''
1. Add
2. Del
3. List
4. Quit

Enter number:'''

number=0
while number != 4:
    print(prompt)
    number = int(input())

coffee = 10
while True:
    money = int(input("돈을 넣어 주세요: "))
    if money == 300:
        print("커피를 줍니다.")
        coffee = coffee -1
    elif money > 300:
        print("거스름돈 %d를 주고 커피를 줍니다." % (money -300))
        coffee = coffee -1
    else:
        print("돈을 다시 돌려주고 커피를 주지 않습니다.")
        print("남은 커피의 양은 %d개 입니다." % coffee)
    if coffee == 0:
        print("커피가 다 떨어졌습니다. 판매를 중지 합니다.")
        break

coffee = 10
while True:
    money = int(input("돈을 넣어 주세요: "))
    if money == 300:
        print("커피를 줍니다.")
        coffee = coffee -1
        print("남은 커피의 양은 %d개 입니다." % coffee)
    elif money > 300:
            if money < 600 :
                print("거스름돈 %d를 주고 커피를 줍니다." % (money -300))
                coffee = coffee -1
            elif money >= 600 :
                print("거스름돈 %d를 주고 커피 %d개를 줍니다."%(money%300,money//300))
                coffee = coffee - (money//300)
                print("남은 커피의 양은 %d개 입니다." % coffee)
    else :
        print("돈을 다시 돌려주고 커피를 주지 않습니다.")
        print("남은 커피의 양은 %d개 입니다." % coffee)
    if coffee == 0:
        print("커피가 다 떨어졌습니다. 판매를 중지 합니다.")
        break

 while True:
     print("Ctrl+C를 눌러야 while문을 빠져나갈 수 있습니다.")

a = [(1,2), (3,4), (5,6)]
for (first, last) in a:
    print(first + last)


import pandas as pd
obj = pd.Series([4.5,7.2,-5.3,3.6], index=['d','b','a','c'])
obj
obj2 = obj.reindex(['a','b','c','d','e'])
obj2

code = {'s':'0011','D':'1234','d':'0000','y':'9999'}
ss = 's always love y'
ss= ss.replace('s',code[ss.split()[0]])
ss= ss.replace('y',code[ss.split()[-1]])
ss
codebook = {"Steve" : '0011', "David":'1234', "Satah" : '0000', "Yuna" : '9999' }
ss = "Steve always love Yuna"
ss = ss.replace("Steve", codebook[ss.split()[0]])
ss= ss.replace('Yuna', codebook[ss.split()[-1]])
ss