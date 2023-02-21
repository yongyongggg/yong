import pandas as pd
import numpy as np
from  sklearn.model_selection import train_test_split
from sklearn.ensemble import RandomForestClassifier
import xgboost as xgb
from sklearn.metrics import confusion_matrix, classification_report
from xgboost import plot_importance
import matplotlib.pyplot as plt

#데이터 불러오기
df= pd.read_csv('wisc_bc_data.csv')
df.head()
#데이터 전처리
df = df.drop('id', axis=1)
df.head()
df['diagnosis'] = df['diagnosis'].apply(lambda x : 1 if x== "M" else 0)
x_train, x_test, y_train, y_test = train_test_split(df.iloc[:,1:], df['diagnosis'],test_size=0.3,random_state=11)

#의사결정나무
#모델만들기
model = RandomForestClassifier(n_estimators=100)
#적용
model.fit(x_train, y_train)
#예측
ypred1 = model.predict(x_test)
print("훈련 세트 정확도: {:.3f}".format(model.score(x_train,y_train)))
print("테스트 세트 정확도: {:.3f}".format(model.score(x_test,y_test)))
#시각화
feat_labels = df.iloc[:,1:].columns
importances = model.feature_importances_
indices = np.argsort(importances)

for f in range(df.iloc[:,1:].shape[1]) :
  print('%2d) %-*s %f' % (f+1,30,feat_labels[indices[f]],importances[indices[f]]))
plt.title('Feature Importance')
plt.bar(range(df.iloc[:,1:].shape[1]),importances[indices],align='center')
plt.xticks(range(df.iloc[:,1:].shape[1]), feat_labels[indices], rotation=90)
plt.xlim([-1,x_train.shape[1]])
plt.tight_layout()
plt.show()

#xgboost
dtrain = xgb.DMatrix(data=x_train, label=y_train)
dtest = xgb.DMatrix(data=x_test, label=y_test)
params = {'max_depth' : 2,'eta' : 1,  'objective' : 'multi:softmax', 'num_class' :2,
                               'eval_metric' : 'merror', 'early_stoppings' : 100}
xgb_model = xgb.train(params = params, dtrain = dtrain, num_boost_round = 400,
                      early_stopping_rounds = 100, evals=[(dtrain,'train'),(dtest,'dtest')])
#예측
# 예측하기, 확률값으로 반환됨
y_pred_probs = xgb_model.predict(dtest)
#성능 평가
print(confusion_matrix(y_test, y_preds))
print(classification_report(y_test, y_preds))
#시각화
%matplotlib inline

fig, ax = plt.subplots(figsize=(10, 12))
plot_importance(xgb_model, ax=ax)