#08장 연습 문제
#김용현
import os

#문제1
os.chdir('C:\\Users\\tj-bu\\PycharmProjects\\pythonProject')
file = open('ch8_data/ch8_data/data/ftest.txt',mode='r')

lines= file.readlines()
docs = []
words = []
for line in lines:
    docs.append(line.strip())

for word in docs:
    words.extend(word.split(' '))

print('문장내용\n',docs)
print('문장 수 :',len(docs))
print('단어내용\n',words)
print('단어 수:',len(words))

#문제2
import pandas as pd

emp = pd.read_csv('ch8_data/ch8_data/data/emp.csv',encoding='utf-8')
print(emp.info())
No= emp.No
Name = emp.Name
Pay = emp.Pay
print('관측치 길이 :',len(No))
mean = sum(Pay)/len(No)
print('전체 평균 급여 :', mean)

for i in range(len(No)) :
    if Pay[i] == min(Pay) :
        print('최저 급여 :'+format(Pay[i])+', 이름 :'+format(Name[i]))
    if Pay[i] == max(Pay) :
        print('최고 급여 :'+str(Pay[i])+', 이름 :'+str(Name[i]))

dic ={}
for i in range(len(No)) :
    dic[Name[i]] = Pay[i]

print(dic)
max(dic.values())

dic['홍길동']