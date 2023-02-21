#######김용현

#선택정렬 오름 차순
dataset = [3,5,2,1,4]
n=len(dataset)
for i in range(0,n-1):
    for j in range(i+1,n):
        min = dataset[j]
        if dataset[i] > dataset[j]:
            for z in range(j,n): #최솟값 찾기
                if min > dataset[z]:
                    min =dataset[z]
            dataset[dataset.index(min)] = dataset[i]
            dataset[i] = min
            print(dataset)

print(dataset)

#선택 정렬 내림 차순
dataset = [3,5,2,1,4]
n = len(dataset)
for i in range(0,n-1):
    for j in range(i+1,n):
        max = dataset[j]
        if dataset[i] < dataset[j]:
            for z in range(j,n) :
                if max < dataset[j]:
                    max = dataset[j]
            dataset[dataset.index(max)] = dataset[i]
            dataset[i] = max
            print(dataset)

print(dataset)

#버블 정렬 오름 차순
dataset = [3,5,1,2,4]
n = len(dataset)
for i in range(0,n) :
    for j in range (0,n-1) :
        if dataset[j] > dataset[j+1] :
            dataset[j],dataset[j+1] =dataset[j+1],dataset[j]
            print(dataset)


print(dataset)

#버블 정렬 내림차순
dataset = [3,5,1,2,4]
n = len(dataset)
for i in range(0,n) :
    for j in range (0,n-1) :
        if dataset[j] < dataset[j+1] :
            dataset[j],dataset[j+1] =dataset[j+1],dataset[j]
            print(dataset)

print(dataset)