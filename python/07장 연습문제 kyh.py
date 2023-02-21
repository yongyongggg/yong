########07장 연습문제
#####김용현
import re

#문제1
email = """hong@12.com
you2@naver.com
12kang@hanmail.net
kimjs@gmail.com"""

from re import findall, match

for e in email.split(sep='\n') :
    mail = match('^[a-z]\\w{3,}[@][a-z]\\w{2,}[.][a-z]\\w{,2}',e)
    if mail :
        print(e)


#문제2
from re import findall
emp = ['2014홍길동220','2002이순신300','2010유관순260']
def name_pro(emp) :
    r= findall('[가-힣]{3}',emp[0])
    d= findall('[가-힣]{3}',emp[1])
    p= findall('[가-힣]{3}',emp[2])
    z = r+d+p
    return z
names =name_pro(emp)
print('names =',names)

#문제3
from re import findall
from statistics import mean

emp = ['2014홍길동220','2020이순신300','2010유관순260']
def pay_pro(emp) :
    r = findall('[0-9]{3}$', emp[0])
    d = findall('[0-9]{3}$', emp[1])
    p = findall('[0-9]{3}$', emp[2])
    a=r+d+p
    z=list(map(int,a))
    z= mean(z)
    return z

pay_mean = pay_pro(emp)
print(pay_mean)
#문제4
from re import findall
from statistics import mean
emp = ['2014홍길동220','2020이순신300','2010유관순260']

def pay_pro(x) :
    from statistics import mean
    import re
    r = findall('[0-9]{3}$', x[0])
    d = findall('[0-9]{3}$', x[1])
    p = findall('[0-9]{3}$', x[2])
    a=r+d+p
    z=list(map(int,a))
    z1= mean(z)
    print('전체 급여 평균 :', z1)
    for i in range(3) :
        if z[i] >= z1 :
            print(findall('[가-힣]{3}',x[i]),'=>',a[i])

pay_pro(emp)

#문제5
from re import findall, sub
texts = ['AFAB54747,asabag?','abTTa $$;a12:2424.','uysfsfA,A1234&***$?']
def clean_text(texts) :
    text_re1 = texts.lower()
    text_re2 = sub('[,.?!;:]','',text_re1)
    text_re3 = sub('[0-9]','',text_re2)
    text_re4 = sub('[@#$%^&*()]','',text_re3)
    text_re5 = ''.join(text_re4.split())
    return text_re5

texts_result = [clean_text(text) for text in texts]
print(texts_result)




