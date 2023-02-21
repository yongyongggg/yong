array = [9,-1,0]
def solution(array):
    answer = 0
    array= sorted(array)
    if len(array) % 2 == 0 :
        answer = (array[(len(array)//2)-1]+array[(len(array)//2)])/2
    else  :
        answer = array[(len(array)//2)]
    return answer

solution(array)
sorted(array)
(len(array)//2)

array[(len(array)//2)]

n = [1,2,3,4,5]
str(n)
for i in range(5,-1)

answer =[]
n=3
for i in range(0, n):
    answer.append(0)

n = 118372
def solution(n):
    num = str(n)
    for i in range(0,len(num)) :
        for j in range(0,len(num)-1) :
            if int(num[j]) < int(num[j+1]) :
                num[j],num[j+1] = num[j+1],num[j]
            a= int(num)
    return a
solution(n)
a=str(n)
a[0],a[4] = a[4],a[0]
