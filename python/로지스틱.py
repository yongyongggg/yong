import warnings
warnings.filterwarnings(action='ignore')
import pandas as pd
#데이터를 불러옵니다.
data = pd.read_csv('./titanic/train.csv')

#데이터 전처리
from SyncRNG import SyncRNG
v=list(range(1,len(data)+1))
s=SyncRNG(seed=42)
ord=s.shuffle(v)
idx=ord[:round(len(data)*0.7)]

for i in range(0,len(idx)):
        idx[i]=idx[i]-1

train= data.loc[idx]
test= data.drop(idx)

#데이터의 앞부분 살펴보기
train.head()
test.head()
#데이터의 길이 살펴보기
print('train:'+str(len(train))+'행','test:'+str(len(test))+'행')
#데이터의 결측치 살펴보기
train.isna().sum()
#train데이터는 Age, Cabin, Embarked에 결측치가 존재
test.isna().sum()
#test데이터는 Age, Cabin, Fare에 결측치가 존재

#데이터가 완성되지 않은 Age, Cabin은 변수에서 제거
train0 = train.drop(['Age', 'Cabin'], axis = 1)
test0 = test.drop(['Age', 'Cabin'], axis = 1)
#train0에서 Embarked가 결측인 두 행을 제거
train0 = train0.dropna()
#제거 여부 확인
train0.isna().sum()

#test0에서 결측된 Fare값을 평균으로 대체
test0 = test0.fillna(test0.mean())
#처리 여부를 확인
test0.isna().sum()

#Name변수와 Ticket 변수를 제거
train1 = train0.drop(['Name', 'Ticket'], axis = 1)
test1 = test0.drop(['Name', 'Ticket'], axis = 1)

#Sex데이터를 숫자형으로 변환
train1['Sex'] = train1['Sex'].map( {'female': 1, 'male': 0} ).astype(int)
test1['Sex'] = test1['Sex'].map( {'female': 1, 'male': 0} ).astype(int)
#Embarked 데이터를 숫자형으로 변환합니다.
train1['Embarked'] = train1['Embarked'].map( {'C': 0, 'Q': 1, 'S':2} ).astype(int)
test1['Embarked'] = test1['Embarked'].map( {'C': 0, 'Q': 1, 'S':2} ).astype(int)
#train 확인하기
train1

#모델의 훈련을 위하여 설명변수와 반응변수를 분리
X_train = train1.drop(["PassengerId","Survived"], axis=1)
Y_train = train1["Survived"]
X_test  = test1.drop(["PassengerId","Survived"], axis=1).copy()
Y_test  = test1[["Survived"]]
X_train.shape, Y_train.shape, X_test.shape, Y_test.shape

from sklearn.linear_model import LogisticRegression
clf = LogisticRegression()
clf.fit(X_train, Y_train)
Y_pred = clf.predict(X_test)
Y_pred

from sklearn.metrics import accuracy_score
accuracy_score(Y_test, Y_pred)