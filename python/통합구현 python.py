#단순 선형 회귀모델#####################################################
#패키지 import
import pandas as pd
import numpy as np
from SyncRNG import SyncRNG
from sklearn import linear_model
from sklearn.metrics import mean_squared_error, r2_score
import math

#데이터 로드
data = pd.read_csv('product.csv', encoding='cp949')

#데이터 전처리
v=list(range(1,len(data)+1))
s=SyncRNG(seed=42)
ord=s.shuffle(v)
idx=ord[:round(len(data)*0.7)]

for i in range(0,len(idx)):
        idx[i]=idx[i]-1

train= data.loc[idx]
test= data.drop(idx)

x_train = train[['제품_적절성']]
y_train = train[['제품_만족도']]
x_test = test[['제품_적절성']]
y_test = test[['제품_만족도']]


#단순 선형회귀 모델 생성
reg = linear_model.LinearRegression()
reg.fit(x_train, y_train)

#기울기
reg.coef_
#절편
reg.intercept_

# 테스트 데이터 예측
pred = reg.predict(x_test)

#평가
mse=mean_squared_error(pred, y_test)
math.sqrt(mse)
r2_score(y_test, pred)
#rmse = 0.5585512221771916
#r2_score = 0.4955793112661778


#다중선형 회귀#######################################################
#패키지 import
import pandas as pd
import numpy as np
from SyncRNG import SyncRNG
from sklearn import linear_model
from sklearn.metrics import mean_squared_error, r2_score
import math

#데이터 로드
data = pd.read_csv('product.csv', encoding='cp949')

# seed 고정, test/train 분류
from SyncRNG import SyncRNG
v=list(range(1,len(data)+1))
s=SyncRNG(seed=42)
ord=s.shuffle(v)
idx=ord[:round(len(data)*0.7)]

for i in range(0,len(idx)):
        idx[i]=idx[i]-1

train= data.loc[idx]
test= data.drop(idx)

#데이터 전처리
x_train = data[['제품_적절성','제품_친밀도']]
y_train = data[['제품_만족도']]
x_test = data[['제품_적절성','제품_친밀도']]
y_test = data[['제품_만족도']]


#다중선형 회귀 모델 생성
reg = linear_model.LinearRegression()
reg.fit(x_train, y_train)

#기울기
reg.coef_
#절편
reg.intercept_

#테스트 데이터 예측
pred =reg.predict(x_test)

#평가
mse=mean_squared_error(pred, y_test)
math.sqrt(mse)
r2_score(y_test, pred)


#로지스틱###########################################################
import warnings
warnings.filterwarnings(action='ignore')
import pandas as pd
#데이터를 불러옵니다.
data = pd.read_csv('./titanic/train.csv')

#데이터의 길이 살펴보기
print('train:'+str(len(data))+'행')
#데이터의 결측치 살펴보기
data.isna().sum()
#train데이터는 Age, Cabin, Embarked에 결측치가 존재

#데이터가 완성되지 않은 Age, Cabin은 변수에서 제거
data1 = data.drop(['Age', 'Cabin'], axis = 1)
#train0에서 Embarked가 결측인 두 행을 제거
data2 = data1.dropna()
#제거 여부 확인
data2.isna().sum()

#Name변수와 Ticket 변수를 제거
data2 = data2.drop(['Name', 'Ticket'], axis = 1)

#Sex데이터를 숫자형으로 변환
data2['Sex'] = data2['Sex'].map( {'female': 1, 'male': 0} ).astype(int)
#Embarked 데이터를 숫자형으로 변환합니다.
data2['Embarked'] = data2['Embarked'].map( {'C': 0, 'Q': 1, 'S':2} ).astype(int)

data2 = data2.reset_index()
# seed 고정, test/train 분류
from SyncRNG import SyncRNG
v=list(range(1,len(data2)+1))
s=SyncRNG(seed=42)
ord=s.shuffle(v)
idx=ord[:round(len(data2)*0.7)]

for i in range(0,len(idx)):
        idx[i]=idx[i]-1

train= data2.loc[idx]
test= data2.drop(idx)


#모델의 훈련을 위하여 설명변수와 반응변수를 분리
X_train = train.drop(["PassengerId","Survived"], axis=1)
Y_train = train["Survived"]
X_test  = test.drop(["PassengerId","Survived"], axis=1).copy()
Y_test  = test[["Survived"]]
X_train.shape, Y_train.shape, X_test.shape, Y_test.shape

from sklearn.linear_model import LogisticRegression
#로지스틱 모델 생성
clf = LogisticRegression()
clf.fit(X_train, Y_train)


pred = clf.predict(X_test)
pred
#clf.score(X_test, Y_pred)

from sklearn.metrics import accuracy_score
accuracy_score(Y_test, pred)


#의사결정나무#################################################################
import pandas as pd
import numpy as np

#데이터 전처리
df= pd.read_csv('wisc_bc_data.csv')
df.head()
df = df.drop('id', axis=1)
df.head()
df['diagnosis'] = df['diagnosis'].apply(lambda x : 1 if x== "M" else 0)

from SyncRNG import SyncRNG
v=list(range(1,len(df)+1))
s=SyncRNG(seed=42)
ord=s.shuffle(v)
idx=ord[:round(len(df)*0.7)]

for i in range(0,len(idx)):
        idx[i]=idx[i]-1

train= df.loc[idx]
test= df.drop(idx)


x_train = train.drop(['diagnosis'], axis=1)
y_train = train[['diagnosis']]
x_test = test.drop(['diagnosis'], axis=1)
y_test = test[['diagnosis']]


#데이터 전처리
from sklearn.tree import DecisionTreeRegressor, plot_tree
tree_model = DecisionTreeRegressor(random_state=1)
tree = tree_model.fit(x_train, y_train)

import matplotlib.pyplot as plt
fig = plt.figure(figsize=(12,5))
explt_vars = df.columns
decisiontree = plot_tree(tree_model,feature_names =explt_vars,filled=True)

tree.score(x_test,y_test)

pred= tree.predict(x_test)
pred = np.where( pred > 0.5 , 1 , 0)
from sklearn.metrics import accuracy_score
accuracy_score(y_test, pred)

#튜닝 모델
#데이터 전처리
from sklearn.tree import DecisionTreeRegressor, plot_tree
tree_model = DecisionTreeRegressor(min_samples_leaf=2, min_samples_split=2, random_state=1)
tree = tree_model.fit(x_train, y_train)

pred= tree.predict(x_test)
pred = np.where( pred > 0.5 , 1 , 0)
from sklearn.metrics import accuracy_score
accuracy_score(y_test, pred)

#Return the coefficient of determination of the prediction.

#인공신경망####################################################################
import pandas as pd
import numpy as np

#데이터 전처리
df= pd.read_csv('wisc_bc_data.csv')
df.head()
df = df.drop('id', axis=1)
df.head()
df['diagnosis'] = df['diagnosis'].apply(lambda x : 1 if x== "M" else 0)

from SyncRNG import SyncRNG
v=list(range(1,len(df)+1))
s=SyncRNG(seed=42)
ord=s.shuffle(v)
idx=ord[:round(len(df)*0.7)]

for i in range(0,len(idx)):
        idx[i]=idx[i]-1

train= df.loc[idx]
test= df.drop(idx)


x_train = train.drop(['diagnosis'], axis=1)
y_train = train[['diagnosis']]
x_test = test.drop(['diagnosis'], axis=1)
y_test = test[['diagnosis']]

from sklearn.neural_network import MLPClassifier
#인공신경망 모델 생성
clf = MLPClassifier(random_state=1).fit(x_train, y_train.values.ravel())

#predict 생성
pred=clf.predict(x_test)


from sklearn.metrics import accuracy_score
#정확도
accuracy_score(y_test, pred)

#수정
#인공신경망 모델 생성
from sklearn.neural_network import MLPClassifier
clf = MLPClassifier(epsilon = 2.823905e-05, max_iter = 1000, random_state=1).fit(x_train, y_train.values.ravel())

#predict 생성
pred=clf.predict(x_test)


from sklearn.metrics import accuracy_score
#정확도
accuracy_score(y_test, pred)

#SVM###################################################################################
import pandas as pd
import numpy as np

#데이터 전처리
df= pd.read_csv('wisc_bc_data.csv')
df.head()
df = df.drop('id', axis=1)
df.head()
df['diagnosis'] = df['diagnosis'].apply(lambda x : 1 if x== "M" else 0)

from SyncRNG import SyncRNG
v=list(range(1,len(df)+1))
s=SyncRNG(seed=42)
ord=s.shuffle(v)
idx=ord[:round(len(df)*0.7)]

for i in range(0,len(idx)):
        idx[i]=idx[i]-1

train= df.loc[idx]
test= df.drop(idx)


x_train = train.drop(['diagnosis'], axis=1)
y_train = train[['diagnosis']]
x_test = test.drop(['diagnosis'], axis=1)
y_test = test[['diagnosis']]

from sklearn import svm
#SVM 모델 생성
clf = svm.SVC(kernel = "linear", C=1, random_state=1) #, kernel= 'poly')
clf.fit(x_train,y_train.values.ravel())

from sklearn.metrics import confusion_matrix    # confusion_matrix라이브러리
#predict 생성
pred = clf.predict(x_test)                         # 학습데이터 분류예측
confusion_matrix(y_test, pred)
predict1=pred.astype(float)

from sklearn.metrics import accuracy_score
#정확도
accuracy_score(y_test, pred)

clf = svm.SVC(kernel = 'poly', C=1, random_state=1,gamma=0.01234568, tol = 0.001, coef0=3)
clf.fit(x_train,y_train.values.ravel())

#predict 생성
pred = clf.predict(x_test)
#정확도
accuracy_score(y_test, pred)
#앙상블##################################################################################
import pandas as pd
import numpy as np

#데이터 전처리
df= pd.read_csv('wisc_bc_data.csv')
df.head()
df = df.drop('id', axis=1)
df.head()
df['diagnosis'] = df['diagnosis'].apply(lambda x : 1 if x== "M" else 0)

from SyncRNG import SyncRNG
v=list(range(1,len(df)+1))
s=SyncRNG(seed=42)
ord=s.shuffle(v)
idx=ord[:round(len(df)*0.7)]

for i in range(0,len(idx)):
        idx[i]=idx[i]-1

train= df.loc[idx]
test= df.drop(idx)


x_train = train.drop(['diagnosis'], axis=1)
y_train = train[['diagnosis']]
x_test = test.drop(['diagnosis'], axis=1)
y_test = test[['diagnosis']]

from sklearn.ensemble import AdaBoostClassifier
#앙상블 모델 생성
clf = AdaBoostClassifier(random_state=1)
clf.fit(x_train,y_train.values.ravel())

#predict 생성
pred = clf.predict(x_test)

from sklearn.metrics import accuracy_score
#정확도
accuracy_score(y_test, pred)

clf.score(x_test,y_test)
#Return the mean accuracy on the given test data and labels.

#앙상블 모델 생성
clf = AdaBoostClassifier(random_state=1, n_estimators = 100, algorithm='SAMME')
clf.fit(x_train,y_train.values.ravel())

#predict 생성
pred = clf.predict(x_test)

from sklearn.metrics import accuracy_score
#정확도
accuracy_score(y_test, pred)
#랜덤포레스트##############################################################################
import pandas as pd
import numpy as np

#데이터 전처리
df= pd.read_csv('wisc_bc_data.csv')
df.head()
df = df.drop('id', axis=1)
df.head()
df['diagnosis'] = df['diagnosis'].apply(lambda x : 1 if x== "M" else 0)

from SyncRNG import SyncRNG
v=list(range(1,len(df)+1))
s=SyncRNG(seed=42)
ord=s.shuffle(v)
idx=ord[:round(len(df)*0.7)]

for i in range(0,len(idx)):
        idx[i]=idx[i]-1

train= df.loc[idx]
test= df.drop(idx)


x_train = train.drop(['diagnosis'], axis=1)
y_train = train[['diagnosis']]
x_test = test.drop(['diagnosis'], axis=1)
y_test = test[['diagnosis']]

from sklearn.ensemble import RandomForestClassifier
clf = RandomForestClassifier(random_state=1,max_depth=3)
clf.fit(x_train, y_train.values.ravel())

#predict 생성
pred = clf.predict(x_test)

from sklearn.metrics import accuracy_score
#정확도
accuracy_score(y_test, pred)

clf.score(x_test,y_test)
# Return the mean accuracy on the given test data and labels.

from sklearn.ensemble import RandomForestClassifier
clf = RandomForestClassifier(random_state=1, n_estimators=500 ,max_depth=55,min_samples_leaf=1)
clf.fit(x_train,y_train.values.ravel())

#predict 생성
pred = clf.predict(x_test)

from sklearn.metrics import accuracy_score
#정확도
accuracy_score(y_test, pred)


#xgboost##########################################################################
import pandas as pd
import numpy as np

#데이터 전처리
df= pd.read_csv('wisc_bc_data.csv')
df.head()
df = df.drop('id', axis=1)
df.head()
df['diagnosis'] = df['diagnosis'].apply(lambda x : 1 if x== "M" else 0)

from SyncRNG import SyncRNG
v=list(range(1,len(df)+1))
s=SyncRNG(seed=42)
ord=s.shuffle(v)
idx=ord[:round(len(df)*0.7)]

for i in range(0,len(idx)):
        idx[i]=idx[i]-1

train= df.loc[idx]
test= df.drop(idx)


x_train = train.drop(['diagnosis'], axis=1)
y_train = train[['diagnosis']]
x_test = test.drop(['diagnosis'], axis=1)
y_test = test[['diagnosis']]

import xgboost as xgb
model = xgb.XGBClassifier()
xgb_model = model.fit(x_train,y_train)

pred = xgb_model.predict(x_test)

from sklearn.metrics import accuracy_score
accuracy_score(y_test, pred)

import matplotlib.pyplot as plt
from xgboost import plot_importance
fig, ax = plt.subplots(figsize = (10, 12))
plot_importance(xgb_model, ax=ax)

