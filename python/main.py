num_list = [2,3,4,5,6,7,8,9]
def solution(num_list) :
    answer = []
    for i in range(0,len(num_list)):
            for n in range(2,len(num_list)-1):
                if num_list[i] % n == 0:
                    answer.append(False)
                else:
                    answer.append(True)

    return answer

solution(num_list)
