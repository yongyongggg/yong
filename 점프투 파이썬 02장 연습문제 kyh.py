#연습문제
#김용현
#Q1
a=80
b=75
c=55
(a+b+c)/3

#Q2
1 % 2
2 % 2
3 % 2
13 % 2
# 2로 나누었을 때 나머지가 0이면 짝수 1이면 홀수이다.
# 13을 2로 나누면 나머지가 1이기 떄문에 13은 홀수이다.

#Q3
id = '881120-1068234'
YYYYMMDD=id[:6]
YYYYMMDD
number= id[7:]
number

#Q4
pin= '881120-1068234'
sex = pin[7]
sex

#Q5
a = 'a:b:c:d'
a= a.replace(':','#')
a

#Q6
a= [1,3,5,4,2]
a.sort(reverse=True)
a

#Q7
a = ['Life','is','too','short']
' '.join(a)

#Q8
a = (1,2,3)
a= a + (4,)
a
a += (4,)
#Q9
a =dict()
a
#1
a['name'] = 'python'
a
#2
a[('a',)]= 'python'
a
#3
a[[1]] = 'python'
a
#4
a[250] ='python'
a
#답:3, 리스트형 자료는 변할 수 있기 때문에 딕셔너리에 들어갈 수 없다.

#Q10
a ={'A':90 , 'B':80, 'C':70}
print(a.pop('B'))

#Q11
a= [1,1,1,2,2,3,3,3,4,4,5]
a= set(a)
a
a =list(a)
a
#리스트로 다시 변환해줘야한다.
#Q12
a = b = [1,2,3]
a[1] =4
print(b)
a is b
#b도 변하는 것을 볼 수 있는데 이는 a is b 가 True에서 볼 수 있듯이
#서로 같은 객체를 가리키고 있기 때문이다.



