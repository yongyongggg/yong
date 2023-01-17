#1. 제품적절성이 제품만족도에 미치는 영향 주제로 R을 이용한 단순 선형 회귀분석을
#실시하고, 딥러닝 교재 3장에서 사용된 인공신경망을 이용한 선형 회귀분석을
#python으로 실행하여 결과를 비교하시오.
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from SyncRNG import SyncRNG
import math
from sklearn.metrics import mean_squared_error, r2_score

#데이터 호출
raw_data = pd.read_csv('E:/GoogleDrive/A5팀 프로젝트 자료(12월22일)/dataset/product.csv',encoding='cp949')

v=list(range(1,len(raw_data)+1))
s=SyncRNG(seed=42)
ord=s.shuffle(v)
idx=ord[:round(len(raw_data)*0.7)]

for i in range(0,len(idx)):
   idx[i]=idx[i]-1

train=raw_data.loc[idx]
test=raw_data.drop(idx)

x_train = train.제품_적절성
y_train = train.제품_만족도
x_test = test.제품_적절성
y_test = test.제품_만족도
#모델생성
class Neuron:
   def __init__(self):
       self.w = 1  # 가중치를 초기화합니다
       self.b = 1 # 절편을 초기화합니다

   def forpass(self, x):
       y_hat = x * self.w + self.b  # 직선 방정식을 계산합니다
       return y_hat

   def backprop(self, x, err):
       w_grad = x * err  # 가중치에 대한 그래디언트를 계산합니다
       b_grad = 1 * err  # 절편에 대한 그래디언트를 계산합니다
       return w_grad, b_grad

   def fit(self, x, y,lr, epochs=400):
       for i in range(epochs):  # 에포크만큼 반복합니다
           for x_i, y_i in zip(x, y):  # 모든 샘플에 대해 반복합니다
               n=len(x)
               y_hat = self.forpass(x_i)  # 정방향 계산
               err = -(2/n)*(y_i - y_hat)  # 오차 계산
               w_grad, b_grad = self.backprop(x_i, err)  # 역방향 계산
               self.w -= w_grad*lr  # 가중치 업데이트
               self.b -= b_grad*lr # 절편 업데이트

neuron = Neuron()
neuron.fit(x_train, y_train,0.1)
print(neuron.w)
print(neuron.b)
#모델 예측 및 평가
predict=[]
predict = x_test * neuron.w + neuron.b
mse=mean_squared_error(predict, y_test)
math.sqrt(mse)
r2_score(y_test, predict)
#시각화
plt.scatter(x_train, y_train)
plt.scatter(x_test, predict)
pt1 =(1, 1*neuron.w+neuron.b)
pt2 =(5, 5*neuron.w+neuron.b)
plt.plot([pt1[0],pt2[0]],[pt1[1],pt2[1]],color='orange')
plt.xlabel('x')
plt.ylabel('y')
plt.show()