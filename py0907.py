#####7장 정규표현식
#P.195 문자열 찾기
import re #이러한 방식으로 하면 re.findall 형식으로 해야한다
from re import findall
from re import findall
st1 = '1234 abc홍길동 ABC_555_6 이사도시'

# 숫자 찾기
print(findall('1234',st1))
print(findall('[0-9]',st1))
print(findall('[0-9]{3}',st1))
print(findall('[0-9]{3,}',st1))
print(findall('\\d{3,}',st1))

#문자열 찾기
print(findall('[가-힣]{3,}',st1))
print(findall('[a-z]{3}',st1))
print(findall('[a-z|A-Z]{3}',st1))

#특정 위치의 문자열 찾기
st2 = 'test1abcABC 123mbc 45test'

# 접두어/ 접미어
print(findall('^test',st2))
print(findall('st$',st2))

#종료문자 찾기
print(findall('.bc',st2))

#시작문자 찾기
print(findall('t.',st2))

#단어찾기(//) - 대문자+영문+숫자
st3 = 'test^홍길동 abc 대한*민국 123$tbc'
words = findall('\\w{3,}',st3)
print(words)

#문자열 제외 x+ (x가 1개 이상 반복)
print(findall('[^^*$]*',st3))

#p.197 문자열 검사
from re import match
#패턴과 일치하는 경우
jumin = '123456-3234567'
result = match('[0-9]{6}-[1-4][0-9]{6}',jumin)
print(result)

if result:
    print('주민번호 일치')
else:
    print('잘못된 주민번호')

#패턴과 불일치된 경우
jumin = '123456-5234567'
result = match('[0-9]{6}-[1-4][0-9]{6}',jumin)
print(result)

if result:
    print('주민번호 일치')
else:
    print('잘못된 주민번호')

#p.198 문자열 치환
from re import sub
st3 = 'test^홍길동 abc 대한*민국 132$tbc'

#특수문자 제거
text1= sub('[\^*$]+','',st3)
print(text1)

#숫자 제거
text2= sub('[0-9]','',text1)
print(text2)

#p.199 올바른 문장 선택

from re import split, match, compile
multi_line = """http://www.naver.com
http://www.daum.net
www.hongkildong.com"""

#구분자를 이용하여 문자열 분리하기
web_site = split('\n',multi_line)
print(web_site)
#패턴 객체 만들기
pat = compile('http://')
#패턴 객체를 이용하여 정상 웹주소 선택하기
sel_site = [site for site in web_site if match(pat, site)]
print(sel_site)

#p.201 자연어 전처리
from re import findall, sub

texts= [' 우리나라  대한민국, 우리나라%$ 만세','비아그&라 500GRM 정력 최고!',
        '나는 대한민국사람', '보험료 15000원에 평생 보장 마감 임박','나는 홍길동']

#단계 1 소문자 변경
texts_rel = [t.lower() for t in texts]
print(texts_rel)
#단계 2 숫자 제거
texts_rel2 = [sub('[0-9]','',text) for text in texts_rel]
print(texts_rel2)
#단계 3 문장부호 제거
texts_rel3 = [sub('[,.?!:;]','',text) for text in texts_rel2]
print(texts_rel3)
#단계 4 특수문자 제거 : re.sub() 사용
spec_str ='[@#$%^&*()]'
texts_rel4 =[sub(spec_str,'',text) for text in texts_rel3]
print(texts_rel4)
#단계 5 영문자 제거
texts_rel5= [''.join(findall('[^a-z]',text)) for text in texts_rel4]
print(texts_rel5)
#단계 6 공백 제거
texts_rel6 = [''.join(text.split()) for text in texts_rel5]
print(texts_rel6)

#p.203 전처리 함수 예
from re import findall, sub
texts= [' 우리나라  대한민국, 우리나라%$ 만세','비아그&라 500GRM 정력 최고!',
        '나는 대한민국사람', '보험료 15000원에 평생 보장 마감 임박','나는 홍길동']

def clean_text (text) :
    text_re1 = text.lower()
    text_re2 = sub('[0-9]','',text_re1)
    text_re3 = sub('[,.?!:;]','',text_re2)
    text_re4 = sub('[@#$%^&*()]','',text_re3)
    text_re5 = sub('[a-z]','',text_re4)
    text_re6 = ''.join(text_re5.split())
    return text_re6

#함수 호출
texts_result = [clean_text(text) for text in texts]
print(texts_result)




############점프투 파이썬
####07-1 정규 표현식 살펴보기
data = """
park 800905-1049118
kim  700905-1059119
"""

result = []
for line in data.split("\n"):
    word_result = []
    for word in line.split(" "):
        if len(word) == 14 and word[:6].isdigit() and word[7:].isdigit():
            word = word[:6] + "-" + "*******"
        word_result.append(word)
    result.append(" ".join(word_result))
print("\n".join(result))

import re
data = """
park 800905-1049118
kim  700905-1059119
"""

pat= re.compile('(\d{6})[-]\d{7}]')
print(pat.sub('\g<1>-*******',data))

###########07-2 정규 표현식 시작하기
#[a-zA-z] : 알파벳 모두

#Dot(.)
#정규 표현식에서 Dot 메타 문자는 줄바꿈 문자인 \n을 제외하고 모든문자와 매치됨
#a.b
#a[.]b는 문자열과 매치되고 a0b 같은 문자열과는 매치되지 않는다.

#반복(*) 0이상 반복
#ca*t
#ct match T
#cat match T
#caaaat match T

#반복(+) 최소 1번이상 반복
# ca+t
# ct match F
# cat match T
# caaat match T

#반복({m,n},?)
#ca{2}t
#cat match F
#caat match T

#?메타 문자가 의미하는 것은 {0,1}을 의미


#파이썬에서 정규 표현식을 지원하는 re 모듈
import re
p= re.compile('[a-z]+')
p = re.compile('[a-z]+')

# method	목적
# group()	매치된 문자열을 돌려준다.
# start()	매치된 문자열의 시작 위치를 돌려준다.
# end()	매치된 문자열의 끝 위치를 돌려준다.
# span()	매치된 문자열의 (시작, 끝)에 해당하는 튜플을 돌려준다.

m= p.match('python')
m.group()
m.end()
m.span()

m= p.search('3 python')
m.group()
m.start()
m.end()
m.span()

#컴파일 옵션
# DOTALL(S) - . 이 줄바꿈 문자를 포함하여 모든 문자와 매치할 수 있도록 한다.
# IGNORECASE(I) - 대소문자에 관계없이 매치할 수 있도록 한다.
# MULTILINE(M) - 여러줄과 매치할 수 있도록 한다.
# (^, $ 메타문자의 사용과 관계가 있는 옵션이다)
# VERBOSE(X) - verbose 모드를 사용할 수 있도록 한다.
# (정규식을 보기 편하게 만들수 있고 주석등을 사용할 수 있게된다.)


import re
p = re.compile('a.b')
m = p.match('a\nb')
print(m)

#\n을 매치하기위해서는 re.DOTALL을 사용해야한다
p = re.compile('a.b',re.DOTALL)
m = p.match('a\nb')
print(m)

#IGNORECASE
p = re.compile('[a-z]+',re.I)
p.match('python')
p.match('Python')
p.match('PYTHON')

#MULTILINE
import re
p = re.compile("^python\s\w+")

data = """python one
life is too short
python two
you need python
python three"""

print(p.findall(data))

p = re.compile("^python\s\w+",re.MULTILINE)

data = """python one
life is too short
python two
you need python
python three"""

print(p.findall(data))

#VERBOSE
charref = re.compile(r'&[#](0[0-7]+|[0-9]+|x[0-9a-fA-F]+);')

charref = re.compile(r"""
 &[#]                # Start of a numeric entity reference
 (
     0[0-7]+         # Octal form
   | [0-9]+          # Decimal form
   | x[0-9a-fA-F]+   # Hexadecimal form
 )
 ;                   # Trailing semicolon
""", re.VERBOSE)

#백슬래시
p = re.compile('\section')
print(p)

######07-3 강력한 정규표현식
#\A 문자열의 처음과 매치로 ^ 메타 문자와 동일한 의미
#re.MULTILINE옵션을 사용한 경우 다르게 해석
#\A는 줄과 상관없이 전체 문자열의 처음과만 매치됨.

#\Z $와 같지만 re.MULTILINE을 사용하연 전체 문자열의 끝만 반환

#\B
p = re.compile(r'\Bclass\B')
print(p.search('no class at all'))
print(p.search('the declassified algorithm'))
print(p.search('one subclass is'))

#그루핑
p = re.compile('(ABC)+')
m = p.search('ABCABCABC OK?')
print(m)

p = re.compile(r"\w+\s+\d+[-]\d+[-]\d+")
m = p.search('park 010-1234-1234')

p = re.compile(r"(\w+)\s+\d+[-]\d+[-]\d+")
m = p.search('park 010-1234-1234')
print(m.group(1))

p = re.compile(r"(\w+)\s+(\d+[-]\d+[-]\d+)")
m = p.search('park 010-1234-1234')
print(m.group(2))

p = re.compile(r"(\w+)\s+((\d+)[-]\d+[-]\d+)")
m = p.search('park 010-1234-1234')
print(m.group(3))

#그루핑된 문자열 재참조하기
p = re.compile(r'(\b\w+)\s+\1')
p.search('Paris in the the spring').group()

#그루핑된 문자열에 이름 붙이기
p =re.compile(r'(?P<name>\w+)\s+((\d+)[-]\d+[-]\d)')
m= p.search('park 010-1234-1324')
print(m.group('name'))

p=re.compile(r'(?P<word>\b\w+)\s+(?P=word)')
p.search('Paris in the the spring').group()

#전방 탐색
p = re.compile('.+:')
m = p.search('http://google.com')
print(m.group())

#긍정형 전방 탐색
p = re.compile('.+(?=:)')
m = p.search('http://google.com')
print(m.group())

#긍정형 전방탐색의 확장자
# .*[.][^b].*$
# .*[.]([^b]..|.[^a].|..[^t])$
# .*[.]([^b].?.?|.[^a]?.?|..?[^t]?)$

#부정형 전방 탐색
# .*[.](?!bat$).*$
# .*[.](?!bat$|exe$).*$

#문자열 바꾸기
p = re.compile('(blue|white|red)')
p.sub('colour','blue socks and red shoes')

p.sub('colour', 'blue socks and red shoes', count=1)

p = re.compile('(blue|white|red)')
p.subn( 'colour', 'blue socks and red shoes')

#sub 메서드 사용 시 참조 구문 사용하기
p = re.compile(r"(?P<name>\w+)\s+(?P<phone>(\d+)[-]\d+[-]\d+)")
print(p.sub("\g<phone> \g<name>", "park 010-1234-1234"))

#sub 매서드의 매개 변수로 함수 넣기
#16진수로 변환하기
def hexrepl(match) :
    value = int(match.group())
    return hex(value)

p = re.compile(r'\d+')
p.sub(hexrepl, 'Call 65490 for printing, 49152 for user code.')

# Greedy(탐욕스러운) vs Non-Greedy
s = '<html><head><title>Title</title>'
len(s)
print(re.match('<.*>',s).span())
print(re.match('<.*>',s).group())
#?를 사용하면 하나만 출력할수 있다.
print(re.match('<.*?>',s).group())
#?는 *?, +?, ??, {m,n}?와 같이 사용가능


