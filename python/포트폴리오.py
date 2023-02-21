###########문제1
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from SyncRNG import SyncRNG

data=pd.read_csv('product.csv',encoding='cp949')
v=list(range(1,len(data)+1))
s=SyncRNG(seed=42)
ord=s.shuffle(v)
idx=ord[:round(len(data)*0.7)]

for i in range(0,len(idx)):
   idx[i]=idx[i]-1
train=data.loc[idx]
test=data.drop(idx)
x_train = np.array(train.제품_적절성)
y_train = np.array(train.제품_만족도)
x_test = np.array(test.제품_적절성)
y_test = np.array(test.제품_만족도)

class Neuron :
    def __init__(self):
        self.w = 1.0
        self.b = 1.0
    def forpass(self, x):
        y_hat = x * self.w + self.b
        return y_hat
    def backprop(self, x, err):
        w_grad = x * err
        b_grad = 1 * err
        return w_grad, b_grad

    def fit(self, x, y, lr, epochs=400) :
        for i in range(epochs) :
            for x_i, y_i in zip(x, y) :
                n = len(x)
                y_hat = self.forpass(x_i) # 정방향 계산
                err = -(2/n) *(y_i - y_hat)      # 오차 계산
                w_grad, b_grad = self.backprop(x_i, err)
                self.w -= w_grad*lr       # 가중치 업데이트
                self.b -= b_grad*lr       # 절편 업데이트


print(neuron.w, neuron.b)
neuron = Neuron()
neuron.fit(x_train, y_train,0.01)
predict =[]
predict = x_test*neuron.w+neuron.b
from sklearn.metrics import mean_squared_error
mse=mean_squared_error(predict, y_test)
import math
math.sqrt(mse)

plt.scatter(x_train, y_train)
plt.scatter(x_test, predict)
pt1 =(1, 1*neuron.w+neuron.b)
pt2 =(5, 5*neuron.w+neuron.b)
plt.plot([pt1[0],pt2[0]],[pt1[1],pt2[1]])
plt.xlabel('x')
plt.ylabel('y')
plt.show()

########문항2
import numpy as np
import pandas as pd
from SyncRNG import SyncRNG
data=pd.read_csv('weather.csv',encoding='cp949')
df=data.drop(['Date','Sunshine','WindGustDir','WindDir','RainToday'],axis=1)
df['RainTomorrow'] = df['RainTomorrow'].apply(lambda x : 1 if x== "Yes" else 0)
df=df.dropna()
np.sum(df.isnull(),axis=0)
df= df.reset_index()

#세트나누기
v=list(range(1,len(df)+1))
s=SyncRNG(seed=42)
ord=s.shuffle(v)
idx=ord[:round(len(df)*0.7)]
for i in range(0,len(idx)):
   idx[i]=idx[i]-1
train=df.loc[idx]
test=df.drop(idx)
x_train = np.array(train.iloc[:,1:10])
y_train = np.array(train.iloc[:,-1])
x_test = np.array(test.iloc[:,1:10])
y_test = np.array(test.iloc[:,-1])

class LogisticNeuron:

    def __init__(self):
        self.w = None
        self.b = None

    def forpass(self, x):
        z = np.sum(x * self.w) + self.b  # 직선 방정식을 계산합니다
        return z

    def backprop(self, x, err):
        w_grad = x * err  # 가중치에 대한 그래디언트를 계산합니다
        b_grad = 1 * err  # 절편에 대한 그래디언트를 계산합니다
        return w_grad, b_grad

    def activation(self, z):
        z = np.clip(z, -100, None)  # 안전한 np.exp() 계산을 위해
        a = 1 / (1 + np.exp(-z))  # 시그모이드 계산
        return a

    def fit(self, x, y, epochs=1000):
        self.w = np.ones(x.shape[1])  # 가중치를 초기화합니다.
        self.b = 0  # 절편을 초기화합니다.
        for i in range(epochs):  # epochs만큼 반복합니다
            n = len(x)
            for x_i, y_i in zip(x, y):  # 모든 샘플에 대해 반복합니다
                z = self.forpass(x_i)  # 정방향 계산
                a = self.activation(z)  # 활성화 함수 적용
                err = -(1/n) *(y_i - a)  # 오차 계산
                w_grad, b_grad = self.backprop(x_i, err)  # 역방향 계산
                self.w -= w_grad  # 가중치 업데이트
                self.b -= b_grad  # 절편 업데이트
    def predict(self, x):
        z = [self.forpass(x_i) for x_i in x]  # 정방향 계산
        a = self.activation(np.array(z))  # 활성화 함수 적용
        return a > 0.5
neuron = LogisticNeuron()
neuron.fit(x_train, y_train)
np.mean(neuron.predict(x_test) == y_test)


#문제3
from sklearn.datasets import load_iris
import numpy as np
import pandas as pd
from SyncRNG import SyncRNG
iris = load_iris()
iris.feature_names
df = pd.DataFrame(iris.data, columns=iris.feature_names)
df['target'] = iris['target']

v=list(range(1,len(df)+1))
s=SyncRNG(seed=38)
ord=s.shuffle(v)
idx=ord[:round(len(df)*0.7)]
for i in range(0,len(idx)):
   idx[i]=idx[i]-1
train=df.loc[idx]
test=df.drop(idx)
x_train = np.array(train.iloc[:,:4])
y_train = np.array(train.iloc[:,-1])
x_test = np.array(test.iloc[:,:4])
y_test = np.array(test.iloc[:,-1])
import tensorflow as tf
from tensorflow.keras import Sequential
from tensorflow.keras.layers import Dense
y_train_encoded = tf.keras.utils.to_categorical(y_train)
y_val_encoded = tf.keras.utils.to_categorical(y_test)


model = Sequential()
model.add(Dense(3, activation='softmax'))
model.compile(optimizer='sgd', loss='categorical_crossentropy',
              metrics=['accuracy'])
history =model.fit(x_train, y_train_encoded, epochs=100, batch_size=5,
          validation_data=(x_test, y_val_encoded))
print(history.history.keys())

import matplotlib.pyplot as plt
plt.plot(history.history['loss'])
plt.plot(history.history['val_loss'])
plt.ylabel('loss')
plt.xlabel('epoch')
plt.legend(['train_loss', 'val_loss'])
plt.show()

plt.plot(history.history['accuracy'])
plt.plot(history.history['val_accuracy'])
plt.ylabel('accuracy')
plt.xlabel('epoch')
plt.legend(['train_accuracy', 'val_accuracy'])
plt.show()
loss, accuracy = model.evaluate(x_test, y_val_encoded, verbose=0)
print(accuracy)