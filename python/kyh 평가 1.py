#########평가 1
###### 김용현

#######문제 1
a= 3
b= 3
print(a is b)

#######문제 2
a=(1,2,3)
a=a[:2]+(4,)+a[2:]
print(a)

########문제 3
a= f'{"== pyth":<7}'+f'{"on3! ==":>7}'
print(a)

########문제 4
a= '홍길동 씨의 주민등록번호는 000101-1023456이다.'
b= a[:3]+a[4:7]+'생일은 '+a[-15:-13]+'월 '+a[-13:-11]+'일이다.'
print(b)

########문제 5
Chr1= 'ABCDEFG'
Chr2='HIJKLMN'
Chr3='OPQRST'
Chr4='UVWXYZ'

name = Chr4[-2]+Chr3[0].lower()+Chr2[-1].lower()+Chr1[-1].lower()+' '+Chr2[0]+Chr4[-2].lower()+Chr1[-3].lower()+Chr3[0].lower()+Chr2[-1].lower()+' '+Chr2[-4]+Chr2[1].lower()+Chr2[-2].lower()
print(name)