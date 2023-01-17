#p.49 당뇨병 데이터 준비하기
from sklearn.datasets import load_diabetes
diabetes = load_diabetes()

#p.50 입력 데이터와 타깃 데이터의 크기확인
print(diabetes.data.shape, diabetes.target.shape)
#입력데이터 자세히보기
diabetes.data[0:3]
#타깃데이터
diabetes.target[:3]

#p.52 산점도 그리기
import matplotlib.pyplot as plt
plt.scatter(diabetes.data[:,2],diabetes.target)
plt.xlabel('x')
plt.ylabel('y')
plt.show()
#훈련 데이터 준비
x= diabetes.data[:,2]
y= diabetes.target

#p.56 w와 b초기화 하기
w= 1.0
b= 1.0
#첫번째 샘플 데이터로 y_hat 얻기
y_hat = x[0]*w + b
print(y_hat)
#타깃과 예측 데이터 비교하기
print(y[0])
#w값 조절해 예측값 바꾸기
w_inc = w + 0.1
y_hat_inc = x[0]*w_inc + b
print(y_hat)
#w값 조정 후 예측값 증가 정도 확인하기
w_rate = (y_hat_inc - y_hat) / (w_inc - w)
print(w_rate)
#가중치 업데이트
w_new = w + w_rate
print(w_new)
#변화율로 절편 업데이트하기
b_inc = b + 0.1
y_hat_inc = x[0]*w + b_inc
print(y_hat_inc)
b_rate = (y_hat_inc - y_hat) / (b_inc - b)
print(b_rate)
#변화율이 1이므로 단순히 1을 더해준다.
b_new = b+1
print(b_new)

#p.61 오차 역전파
#오차와 변화율을 곱하여 가중치 업데이트하기
err = y[0] - y_hat
w_new = w + w_rate*err
b_new = b + 1*err
print(w_new, b_new)
#x[1]을 사용하여 오차구하기
y_hat = x[1]*w_new + b_new
err = y[1] - y_hat
w_rate = x[1]
w_new = w_new + w_rate*err
b_new = b_new + 1*err
print(w_new, b_new)
#전체 샘플 반복하기
for x_i, y_i in zip(x, y) :
    y_hat = x_i*w + b
    err = y_i - y_hat
    w_rate = x_i
    w = w + w_rate*err
    b = b + 1*err
print(w, b)
#그래프로 확인하기
plt.scatter(x, y)
pt1 =(-0.1, -0.1*w+b)
pt2 =(0.15, 0.15*w+b)
plt.plot([pt1[0],pt2[0]],[pt1[1],pt2[1]])
plt.xlabel('x')
plt.ylabel('y')
plt.show()
#여러 에포크를 반복하기
for i in range(1, 100) :
    for x_i, y_i in zip(x, y):
        y_hat = x_i * w + b
        err = y_i - y_hat
        w_rate = x_i
        w = w + w_rate * err
        b = b + 1 * err
print(w, b)
#에포크 후 그래프 그리기
plt.scatter(x, y)
pt1 =(-0.1, -0.1*w+b)
pt2 =(0.15, 0.15*w+b)
plt.plot([pt1[0],pt2[0]],[pt1[1],pt2[1]])
plt.xlabel('x')
plt.ylabel('y')
plt.show()
#모델로 예측하기
x_new = 0.18
y_pred = x_new * w + b
print(y_pred)
#산점도 위에 나타내기
plt.scatter(x, y)
plt.scatter(x_new, y_pred)
plt.xlabel('x')
plt.ylabel('y')
plt.show()

#P.67 오차 역전파
y_hat = x_i * w + b
err = y_i - y_hat
w_rate = x_i
w = w + w_rate * err
#절편에 대하여 제곱 오차 미분하기
err = y_i - y_hat
b = b + 1*err


#p.69 선형 회귀 뉴런
def __init__(self) :
    self.w = 1.0
    self.b = 1.0

def forpass(self, x) :
    y_hat = x * self.w + self.b
    return y_hat

def backprop(self, x, err) :
    w_grad = x * err
    b_grad = 1 * err
    return w_grad, b_grad

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

    def fit(self, x, y, epochs=100) :
        for i in range(epochs) :
            for x_i, y_i in zip(x, y) :
                n = len(x)
                y_hat = self.forpass(x_i) # 정방향 계산
                err = -(2/n) *(y_i - y_hat)      # 오차 계산
                w_grad, b_grad = self.backprop(x_i, err)
                self.w -= w_grad       # 가중치 업데이트
                self.b -= b_grad       # 절편 업데이트

neuron = Neuron()
neuron.fit(x,y)

plt.scatter(x, y)
pt1 =(-0.1, -0.1*neuron.w+neuron.b)
pt2 =(0.15, 0.15*neuron.w+neuron.b)
plt.plot([pt1[0],pt2[0]],[pt1[1],pt2[1]])
plt.xlabel('x')
plt.ylabel('y')
plt.show()




