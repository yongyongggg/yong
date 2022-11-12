#####2장 연습문제
###김용현

#Q1
su =5
dan =800
price = su* dan
print('su 주소 : ', id(su) )
print('dan 주소 : ', id(dan))
print('금액 = ', price)

#Q2
x=2
y= 2.5*(x**2)+3.3*x+6
print('2차 방정식 결과 = ', y)

#Q3
fat = int(input('지방의 그램을 입력하세요 :'))
carbohydrate = int(input('탄수화물의 그램을 입력하세요 :'))
protein = int(input('단백질의 그램을 입력하세요 :'))
total = fat*9 + protein*4 + carbohydrate*4
print('총 칼로리 : ', format(total,'3,d'),'cal')
#3,d 와 0,d는 똑같다 총 자리수를 나태냄
#Q4
word1 = input('첫번째 단어 :')
word2 = input('두번째 단어 :')
word3 = input('세번째 단어 :')
word4 = input('네번째 단어 :')
print('='*20)
abbr = word1[0]+word2[0]+word3[0]
print('약자 :', abbr)

#Q4-2
abbr1 =word2[6].upper()+word3[0].lower()+word4[0].lower()+word1[3]
print('약자 : ',abbr1 )

word1 = 'Korea'
word2 = 'Baseball'
word3 = 'Orag'
word4 = 'Victory'