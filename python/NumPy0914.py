#p.8 데이터의 부분집한이나 개별요소를 선택하는 법
import numpy as np
arr = np.arange(10)
arr
arr[5]
arr[5:8]
arr[5:8]=12
arr

arr_slice = arr[5:8]
arr_slice

arr_slice[1] =12345
arr

arr_slice[:] = 64
arr

arr[5:8].copy()
arr

arr2d = np.array([[1,2,3],[4,5,6],[7,8,9]])
arr2d[2]

arr2d[0][2]
arr2d[0,2]

arr3d = np.array([[[1,2,3],[4,5,6]],[[7,8,9],[10,11,12]]])
arr3d
arr3d[0] = 42
arr3d

old_values= arr3d[0]
arr3d

arr3d[1,0]

x =arr3d[1]
x
x[0]
arr3d[1][0]

arr
arr[1:6]
arr2d
arr2d[:2]
arr2d[:2,1:]
arr2d[1,:2]
arr2d[:2,2]
arr2d[:,1:]=0
arr2d

#p.10 Boolean indexing
names = np.array(['Bob', 'Joe', 'Will', 'Bob', 'Will', 'Joe', 'Joe'])
data = np.random.randn(7, 4)
names
data

names == 'Bob'
data[names == 'Bob']
data[names == 'Bob',2:]
data[names == 'Bob',3]

names != 'Bob'
data[~(names =='Bob')]

cond = names == 'Bob'
data[~cond]

mask = (names == 'Bob') | (names == 'Will')
mask
data[mask]

data[data < 0] = 0
data

data[names != 'Joe'] = 7
data

#p.11 Fancy indexing
arr = np.empty((8, 4))
for i in range(8):
 arr[i] = i
arr

arr[[4, 3, 0, 6]]
arr[[-3, -5, -7]]

arr = np.arange(32).reshape((8, 4))
arr
arr[[1, 5, 7, 2], [0, 3, 1, 2]]
arr[[1, 5, 7, 2]][:, [0, 3, 1, 2]]

#p.12 Transpoing arrays and swapping axes
arr = np.arange(15).reshape((3, 5))
arr
arr.T

arr = np.random.randn(6, 3)
arr
np.dot(arr.T, arr)

arr = np.arange(16).reshape((2, 2, 4))
arr
arr.transpose((1, 0, 2))

a = np.ones((2,3,4))
a
np.transpose(a, (1,0,2))
np.transpose(a,(1,0,2)).shape
np.transpose(a,(2,1,0))
np.transpose(a,(2,1,0)).shape

arr
arr.swapaxes(1, 2)

#p.13 유니버셜 함수
import numpy as np
arr= np.arange(10)
arr
np.sqrt(arr)
np.exp(arr)

x= np.random.randn(8)
y= np.random.randn(8)
x
y
np.maximum(x,y)

arr = np.random.randn(7)*5
arr
remainder, whole_part = np.modf(arr)
remainder
whole_part

arr
np.sqrt(arr)
np.sqrt(arr,arr)
arr

#p.16 백터화
points =np.arange(-5,5,0.01)
xs, ys = np.meshgrid(points,points)
xs
ys
z= np.sqrt(xs**2 + ys**2)
z

# matplotlib 이용 2 차원 배열 시각화
import matplotlib.pyplot as plt
plt.imshow(z, cmap=plt.cm.gray); plt.colorbar()
plt.title("Image plot of $\sqrt{x^2 + y^2}$ for a grid of values")
plt.draw()
plt.close('all')


xarr = np.array([1.1, 1.2, 1.3, 1.4, 1.5])
yarr = np.array([2.1, 2.2, 2.3, 2.4, 2.5])
cond = np.array([True, False, True, True, False])
result = [(x if c else y) for x, y, c in zip(xarr, yarr, cond)]
result
result = np.where(cond, xarr, yarr)
result

arr = np.random.randn(4, 4)
arr
arr > 0
np.where(arr > 0, 2, -2)

np.where(arr > 0, 2, arr)
arr

###################reshpe
arr= np.arange(32).reshape(-1,4)
arr

#p.17 임의의 정규 분포 데이터 생성
arr = np.random.randn(5, 4)
arr
arr.mean()
np.mean(arr)
arr.sum()

arr.mean(axis=0)
arr.sum(axis=1)

arr = np.array([0, 1, 2, 3, 4, 5, 6, 7])
arr.cumsum()
arr.cumprod()

arr = np.array([[0, 1, 2], [3, 4, 5], [6, 7, 8]])
arr
arr.cumsum(axis=0) # 열
arr.cumprod(axis=1)

arr = np.random.randn(100)
(arr > 0).sum()

bools = np.array([False, False, True, False])
bools.any()
bools.all()

#p.18 Sorting
arr = np.random.randn(6)
arr
arr.sort()
arr
#내림차순
arr_desc = arr[::-1]
arr_desc

arr = np.random.randn(5,3)
arr
arr.sort(1)
arr
arr_innerdesc = arr[:,::-1]
arr_innerdesc

large_arr = np.random.randn(1000)
large_arr
large_arr.sort()
large_arr[int(0.05 * len(large_arr))]

#p.19 Unique and Other Set Logic
names = np.array(['Bob', 'Joe', 'Will', 'Bob', 'Will', 'Joe', 'Joe'])
np.unique(names)
ints = np.array([3, 3, 3, 2, 2, 1, 1, 4, 4])
np.unique(ints)
sorted(set(names))
values = np.array([6, 0, 0, 3, 2, 5, 6])
np.in1d(values, [2, 3, 6])

#p.20 File Input and Output with Arrays
arr = np.arange(10)
np.save('some_array', arr)
np.load('some_array.npy')
np.savez('array_archive.npz', a=arr, b=arr)
arch = np.load('array_archive.npz')
arch['b']
np.savez_compressed('arrays_compressed.npz', a=arr, b=arr)

#P.21 Linear Algebra
x = np.array([[1., 2., 3.], [4., 5., 6.]])
y = np.array([[6., 23.], [-1, 7], [8, 9]])
x
y
x.dot(y)
np.dot(x, y)
np.dot(y, x)
y.dot(x)
np.dot(x, np.ones(3))
np.dot(x, np.ones(3))
x @ np.ones(3)

from numpy.linalg import inv, qr
X = np.random.randn(5, 5)
X
mat = X.T.dot(X)
mat
inv(mat)
mat.dot(inv(mat))
q, r = qr(mat)
q
r

#p.23 표준 정규분포
samples = np.random.normal(size=(4, 4))
samples
from random import normalvariate
N = 1000000
from datetime import datetime
start = datetime.now()
samples = [normalvariate(0, 1) for _ in range(N)]
np.random.normal(size=N)
print(datetime.now() - start)

np.random.seed(1234)
rng = np.random.RandomState(1234)
rng.randn(10)

np.random.seed(1234)
np.random.uniform(0, 10, 5)
np.random.rand(3,3)

rng2 = np.random.RandomState(1234)
rng2.uniform(0, 10, 5)
np.random.rand(3,3)

#p.25 계단 오르내리기 1000번
import random
position = 0
walk = [position]
steps = 1000
for i in range(steps):
 step = 1 if random.randint(0, 1) else -1
 position += step
 walk.append(position)
plt.figure()
plt.plot(walk[:100])
#1000번 수행
np.random.seed(12345)
nsteps = 1000
draws = np.random.randint(0, 2, size=nsteps)
steps = np.where(draws > 0, 1, -1)
walk = steps.cumsum()

walk.min()
walk.max()
(np.abs(walk) >= 10).argmax()

#p.25 np.random 함수에 크기가 2 인 튜플을 넘기면 2 차원 배열이 생성
import numpy as np
nwalks=5000
nsteps=1000
draws = np.random.randint(0,2,size=(nwalks,nsteps))
steps = np.where(draws>0,1,-1)
walks = steps.cumsum(1)
walks
walks.max()
walks.min()
hits30 = (np.abs(walks) >= 30).any(1)
hits30
hits30.sum()
crossing_times = (np.abs(walks[hits30]) >= 30).argmax(1)
crossing_times.mean()
# normal 함수 이용
steps = np.random.normal(loc=0, scale=0.25,size=(nwalks, nsteps))
steps