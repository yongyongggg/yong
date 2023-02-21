#########튜플
#리스트는 수정이 가능하나 튜플은 수정이 불가능하다.
#튜플에서 요소가 하나이면 꼭 ,를 써줘야한다.
t1=()
t2=(1,)
t3=(1,2,3)
t4=1,2,3
t5=('a','b',('ab','cd'))
#인덱싱하기
t1=(1,2,'a','b')
t1[0]
t1[3]
#슬라이싱하기
t1 = (1,2,'a','b')
t1[1:]
#튜플 더하기
t1=(1,2,'a','b')
t2=(3,4)
t1+t2
#튜플 곱하기
t2=(3,4)
t2*3
#튜플 길이 구하기
t1=(1,2,'a','b')
len(t1)

########딕셔너리 자료형
#인덱스를 사용할 수 없다.
#중괄호를 사용한다.
#사전처럼 단어를 정의하는것 key는 변하지 않는값
#value는 변하는 것 아닌것 둘다 사용가능

#딕셔너리 만들기
dic= {'name':'pey','phone':'0104564848','birth':'0110'}
a={1:'hi'}
a
a= {'a':[1,2,3]}
a
#딕셔너리 쌍 추가하기
a={1:'a'}
a[2]='b'
a
a['name'] ='pey'
a
a[3]=[1,2,3]
a
#딕셔너리 요소 삭제하기
del a[1]
a
#딕셔너리 사용하기
{"김연아":"피겨스케이팅", "류현진":"야구", "박지성":"축구", "귀도":"파이썬"}
#딕셔너리에서 key 사용해 value 얻기
grade ={'pey':10,'julliet':99}
grade['pey']
grade['julliet']
a ={1:'a',2:'b'}
a[1]
a[2]

a={'a':1,'b':2}
a['a']
a['b']

dic= {'name':'pey','phone':'0104564848','birth':'0110'}
dic['name']

#만들떄 유의 할점 같은 key가 존재할 경우 나머지가 무시된다. 랜덤
a={1:'a',1:'b'}
a
# 딕셔너리 관련 함수들
#key 리스트 만들기
a= {'name':'pey','phone':'0104564848','birth':'0110'}
a.keys()
#리스트로 변환
list(a.keys())
#value 리스트 만들기
a.values()
#쌍 얻기
#튜플 형태로 나옴
a.items()
#쌍 모두 지우기
a.clear()
a
#key로 value 얻기
a= {'name':'pey','phone':'0104564848','birth':'0110'}
a.get('name')

#딕셔너리에서 찾으려는 key값이 없을 경우 미리 정해둔 디폴트값을
# 가져오게 하고 싶을 때는 get(x,'디폴트값')을 사용한다.
a.get('foo','bar')
#해당 key가 딕셔너리 안에 있는지 조사하기
a= {'name':'pey','phone':'0104564848','birth':'0110'}
'name' in a
'email' in a
#key값에 튜플은 들어갈 수 있다.
t1=(5,)
a={t1:'a'}
a
#key값에는 리스트, 딕셔너리가 들어갈 수 없다.
t2=[1,2,3]
a={t2:'a'}
t3={'a':1,'b':2}
a={t3:'a'}



#########집합 자료형
#특징: 중복을 허용하지 않는다. 순서가 없다.
s1 = set([1,2,3])
s1
s2 = set('Hello')
s2
s1 = set([1,2,3,1,2,3,1,2,3])
l1=list(s1)
l1
l1[0]
t1=tuple(s1)
t1
t1[0]

#교집합
s1 = set([1,2,3,4,5,6])
s2 = set([4,5,6,7,8,9])
s1 & s2
s1.intersection(s2)
s2.intersection(s1)
#합집합
s1|s2
s1.union(s2)
s2.union(s1)
#차집합
s1-s2
s2-s1
s1.difference(s2)
s2.difference(s1)
#값 1개 추가하기
s1=set([1,2,3])
s1.add(4)
s1
#값 여러개 추가하기
s1=set([1,2,3])
s1.update([4,5,6])
s1
#특정 값 제거하기
s1=set([1,2,3])
s1.remove(2)
s1

######불 자료형
##참과 거짓 두가지만 존재
a=True
b=False
type(a)
type(b)
1 == 1
2>1
14<13

a=[1,2,3,4]
while a :
    print(a.pop())
if []:
     print('참')
else:
     print('거짓')
if [1,2,3]:
     print('참')
else:
    print('거짓')

#불 연산
bool('python')
bool('cenhjf')
bool('')
bool([1,2,3])
bool([])
bool(0)
bool(3)

######자료형의 값을 저장하는 공간, 변수
a=[1,2,3]
id(a)










