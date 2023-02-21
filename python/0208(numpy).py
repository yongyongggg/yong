
import cv2
import numpy as np

img = cv2.imread('./img1/girl.jpg')
a = np.empty_like(img)
b = np.zeros_like(img)
c = np.ones_like(img)
d = np.full_like(img, 255)

print(a, a.shape, a.dtype)


import cv2

img = cv2.imread('./img1/blank_500.jpg')  # OpenCV로 이미지 읽기
print( type(img))                   # img의 데이타 타입
print(img.ndim)     # 배열의 차원 수
print( img.shape)   # 각 차원의 크기
print(img.size)     # 전체 요소의 갯수
print( img.dtype)   # 데이타 타입
print(img.itemsize) # 각 요소의 바이트 크기

import numpy as np


a = np.arange(6)
b = a.reshape(2,3)

c = np.arange(24).reshape(2,3,4)
c
d = np.arange(100).reshape(2, -1)
e = np.arange(100).reshape(-1, 5)

e
f = np.ravel(c)
f
g = np.arange(10).reshape(2,-1)

print(a, a.shape)
print(b, b.shape)
print(c, c.shape)
print(d, d.shape)
print(e, e.shape)
print(f, f.shape)
print(g.T)

import matplotlib.pyplot as plt
import numpy as np

x = np.arange(10) # 0,1,2,3,4,5,6,7,8,9
y = x **2         # 0,1,4,9,16,25,36,49,64,81
plt.plot(x,y, 'r')     # plot 생성                     --- ①
plt.show()        # plot 화면에 표시