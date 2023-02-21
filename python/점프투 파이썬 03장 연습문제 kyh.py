#점프투 파이썬 03장 연습문제
#김용현

#문제1
a = "Life is too short, you need python"

if "wife" in a:
    print("wife")
elif "python" in a and "you" not in a:
    print("python")
elif "shirt" not in a:
    print("shirt")
elif "need" in a:
    print("need")
else:
    print("none")

#shirt를 출력한다.

#문제 2
cnt = tot =0
while cnt<1000 :
    cnt += 1
    if cnt % 3 == 0 :
        tot += cnt

print(tot)

#문제3
cnt = 0
while cnt <5 :
    cnt += 1
    print('*'*cnt)

#문제4
list = []
for i in range(1,101) :
    list.append(i)

print(list)

#문제5
grade = [70,60,55,75,95,90,80,80,85,100]
tot = 0
for i in grade :
    tot += i

print('평균 = ',tot/len(grade))

#문제6
numbers = [1,2,3,4,5]
result = []
result = [n*2 for n in numbers if n % 2 ==1]
print(result)









