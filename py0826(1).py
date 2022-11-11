# comment1  CTRL + / 하면 # 생성
# comment2
# comment3
a = 5 # 입력값은 5
head = 'python'
tail = ' is fun!'
head + tail
head + tail*2
a='python'
a*2
a*3
print(head*3+tail*2)
print("="*50)
print('my program')
a = 'life is too short'
# 파이썬은 0부터 숫자를 센다.
len(a)
a = 'life is too short, you need python'
a[3]
a[4]
a[0]
a[12]
a[-1]
a[-0]
a[-3]
a[-8]
b= a[0]+a[-1]+a[-8]+a[3]
b
# a[0:3] => 0<= a < 3 3을 포함하지 않는다.
a = 'life is too short, you need python'
a[0:5]
a[0:2]
a[12:17]
a[19:]
a[17:]
a[:17]
a[:]
a[19:-7]
a[19:-8]
a[19:-4]
a[18:-7]
a='20010331Rainy'
data = a[:8]
weather=a[8:]
data
weather
year = a[0:4]
day =a[4:8]
weather=a[8:]
year
day
weather
a[4:-5]
# 문자의 요솟값을 변경할수 없기 때문에 슬라이싱으로 만들어야한다.
a='pithon'
a[:1]
a[2:]
b= a[:1] + 'y' +a[2:]
b
# 숫자를 대입할때는 %d 문자열을 대입할때는 %s
# 숫자값을 변수로 대입할때도 %d를 사용한다
# 두개 이상의 값을 대입할때는 %(a,b) 형태롤 대입한다.
# 문자열; %s 문자 1개: %c 정수: %d 부동소수: %f
'I have %s apples' %3
'rate is %s' %3.234
'Error is %d%%' %98
'%10s' %'hi'
'%-10sjane' %'hi'
'%0.4f' %3.42134234
'%10.4f' %3.42134234
#format 함수를 사용한 포매팅
'I eat {0} apples' .format(3)
'i eat {0} apples' .format('five')
number=3
"I eat {0} apples" .format(number)
number=10
day='three'
'I ate {0} apples. so i was sick for {1} days' .format(number,day)
'I ate {number} apples. so I was sick for {day} days' .format(number=10,day=3)
'{0:<10}'.format('hi')
'{0:>10}'.format('hi')
'{0:^10}'.format('hi')
'{0:=^10}'.format("hi")
'{0:!<10}'.format("hi")
y=3.42134234
"{0:0.4f}".format(y)
"{:0.4f}".format(y) ####0 생략가능
"{0:10.4f}".format(y)
"{:1.4f}".format(y) ###그대로 나옴
"{:6.4f}".format(y) ### 그대로 나옴
"{:7.4f}".format(y) ### 한칸 뛰고 나옴
#f문자열 포매팅
name='홍길동'
age=30
f'나의 이름은 {name}입니다. 나이는 {age}입니다.'
f'나는 내년이면 {age+1}이 된다.'
d={'name':'홍길동', 'age':30}
f'나의 이름은 {d["name"]}입니다. 나이는 {d["age"]}입니다.'
f'{"hi":<10}'
f'{"hi":>10}'
f'{"hi":^10}'
f'{"hi":=^10}'
f'{"hi":!<10}'
y=3.42134234
f'{y:0.4f}'
f'{y:10.4f}'
f'{{ and }}'

a ="hobby"
a.count('b')
a='Python is the best choice'
a.find('p')
a.find('P')
a.find('k')
a.find('e')

a='Life is too short'
a.index('t')
a.index('o')
a.index('k')

",".join('abcd')
",".join(['a','b','c','d'])
",".join('a:b:c:d')
a='hi'
a.upper()
a='HI'
a.lower()
a=' hi '
a.rstrip()
a.lstrip()
a.strip()

a='Life is too short'
a.replace('Life','your leg')

a='Life is too short'
a.split()
b='a:b:c:d'
b.split(':')
c='a,b,c,d,e'
c.split(',')
d='a ? b ?c: d'
d.split(' ')

#리스트
a=[1,2,3]
a
a[0]
a[0]+a[2]
a[-2]

a=[1,2,3,['a','b','c']]
a[2]
a[-1]
a[3]
a[3][2]
a[-1][0]

a=[1,2,['a','b',['Life','is']]]
a[2]
a[-1][2]
a[-1][2][1]

a=[1,2,3,4,5]
a[0:2]
b= a[:3]
c= a[3:]
b
c

a=[1,2,3,['a','b','c','d'],4,5]
a[2:5]
a[3][2]
a[-3][3]
a[3][:3]

a=[1,2,3]
b=[4,['c','d'],5]
a+b
b*2
len(b)
len(a)

a=[1,2,3]
str(a[2])+'HI'
a[2]=['a','b','c']
a
a[2][0]
del a[2][2:]
a
a=[1,2,3,4,5]
del a[3:]
a
a=[1,2,3,4,[a,b]]
del a[2:]
a

a=[1,2,3]
a.append(4)
a
a.append([5,6])
a

a=[1,4,3,2]
a.sort()
a
a=['a','c','b']
a.sort()
a
a.reverse()
a
a=[1,2,3]
a.index(3)
a.index(1)

a=[1,2,3]
a.insert(0,4)
a.insert(3,5)
a.insert(3,[5,6])
a
a=[1,2,3,1,2,3]
a.remove(3)
a.remove(3)
a
a=[1,2,3]
a.pop()
a
a.pop(1)
a
a=[1,2,3,1,2,3,1,2]
a.count(1)
a=[1,2,3]
a.extend([4,5])
a
b=[6,7,8]
a.extend(b)
a
a += [4,5,6]
a
a += [1]
a

a= 1
a += 32
a -= 3
a /= 10
a *= 4
a


















