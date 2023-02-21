# 문제 1에서 100까지의 수에서 5의 배수만 리스트에 담아 출력(for 와 rnage 사용)
# 김용현
list = []
for i in range(1, 101):
    if i % 5 == 0:
        list.append(i)

print(list)

list1= [i for i in range(1,101) if i % 5==0]
print(list1)
