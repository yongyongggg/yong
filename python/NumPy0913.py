#1.NumPy
#p.1
import numpy as np
np.random.seed(12345)
import matplotlib.pyplot as plt
plt.rc('figure', figsize=(10,6))
np.set_printoptions(precision=4,suppress=True)
#p.1 성능차이 확인
import numpy as np
my_arr = np.arange(1000000)
my_list = list(range(1000000))
from datetime import datetime
start1 = datetime.now()
for _ in range(10): my_arr2 = my_arr * 2
print(datetime.now() - start1)
from datetime import datetime
start2 = datetime.now()
for _ in range(10): my_list2 = [x * 2 for x in my_list]
print(datetime.now() - start2)

#p.3 배치계산 처리
import numpy as np
data = np.random.randn(2,3)
data
data * 10
data +data

data.shape
data.dtype

data1 =[6,7.5,8,0,1]
arr1 = np.array(data1)
arr1

data2 = [[1,2,3,4],[5,6,7,8]]
arr2 = np.array(data2)
arr2

arr2.ndim
arr2.shape
arr2.size
len(arr2)

arr1.dtype
arr2.dtype

np.zeros(10)
np.zeros((3, 6))
np.zeros((3, 2, 2))

a=np.empty((2, 3, 2))
a.shape
np.arange(15)

arr1 = np.array([1, 2, 3], dtype=np.float64)
arr2 = np.array([1, 2, 3], dtype=np.int32)
arr1.dtype
arr2.dtype
arr1
arr2

#p.6 Numpy의 자료형
#매서드 사용으로 다른형으로 변환
arr = np.array([1,2,3,4,5])
arr.dtype
float_arr = arr.astype(np.float64)
float_arr.dtype
#부동소수점수를 정수형으로 변환하면 버린다
arr = np.array([3.7,-1.2,-2.6,-0.5,12.9,10.1])
arr
arr.astype(np.int32)
#문자열을 담고 있는 배열을 숫자로 변환
numeric_string = np.array(['1.25','-9.6','42'],dtype=np.string_)
numeric_string.astype(float)

#p.7 다른 배열의 속성이용
int_array = np.arange(10)
int_array
calibers = np.array([.22,.270,.357,.380,.44,.50],dtype=np.float64)
calibers.dtype
int_array.astype(calibers.dtype)

#축약 코드 사용하기
empty_uint32 = np.empty(8,dtype='u4')
empty_uint32

#백터화 산술간의 연산은 배역의 각 원소 단위로 적용
arr = np.array([[1.,2.,3.],[4.,5.,6.]])
arr
arr *arr
arr-arr
#스칼라 인자 적용
1/arr
arr**0.5

#같은 크기를 가지는 배열간의 비교 연산은 불리한 배열을 반환
arr2 = np.array([[0.,4.,1.],[7.,2.,12.]])
arr2
arr2 >arr

#데이터의 부분집한이나 개별요소를 선택하는 법
arr = np.arange(10)
arr
arr[5]
arr[5:8]
arr










