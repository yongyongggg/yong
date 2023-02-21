#B4(양정연, 신정훈, 김용현, 조성운) 코드

'''2. 위스콘신 유방암 데이터셋을 대상으로 분류기법 2개를 적용하여 기법별 결과를
비교하고 시각화하시오. (R과 python 버전으로 모두 실행)
-종속변수는diagnosis: Benign(양성), Malignancy(악성)'''

#import packages------------------------------------------------------------------------
import pandas as pd
import numpy as np
from  sklearn.model_selection import train_test_split
import matplotlib.pyplot as plt

#xgboost
import xgboost as xgb
from xgboost import plot_importance

#randomforest
from sklearn.metrics import confusion_matrix, classification_report
from sklearn.ensemble import RandomForestClassifier


#xgboost------------------------------------------------------------------------------------------------
#데이터 불러오기
df= pd.read_csv('wisc_bc_data.csv')
df.head()
#데이터 전처리
df = df.drop('id', axis=1)
df.head()
df['diagnosis'] = df['diagnosis'].apply(lambda x : 1 if x== "M" else 0)

x_train, x_test, y_train, y_test = train_test_split(df.iloc[:,1:], df['diagnosis'],test_size=0.3,random_state=11)

dtrain = xgb.DMatrix(data=x_train, label=y_train)
dtest = xgb.DMatrix(data=x_test, label=y_test)
params = {'max_depth' : 2,'eta' : 1,  'objective' : 'multi:softmax', 'num_class' :2,
                               'eval_metric' : 'merror', 'early_stoppings' : 100}
xgb_model = xgb.train(params = params, dtrain = dtrain, num_boost_round = 400,
                      early_stopping_rounds = 100, evals=[(dtrain,'train'),(dtest,'dtest')])

# 예측하기, 확률값으로 반환됨
y_pred = xgb_model.predict(dtest)
#성능 평가
print(confusion_matrix(y_test, y_pred))
print(classification_report(y_test, y_pred))
#시각화
#%matplotlib inline

fig, ax = plt.subplots(figsize=(10, 12))
plot_importance(xgb_model, ax=ax)

#random forest------------------------------------------------------------------------------------------------------
#데이터 불러오기
df= pd.read_csv('wisc_bc_data.csv')
df.head()
#데이터 전처리
df = df.drop('id', axis=1)
df.head()
df['diagnosis'] = df['diagnosis'].apply(lambda x : 1 if x== "M" else 0)
x_train, x_test, y_train, y_test = train_test_split(df.iloc[:,1:], df['diagnosis'],test_size=0.3,random_state=11)

#모델생성
model = RandomForestClassifier(n_estimators=100)
model.fit(x_train, y_train)

#분류모델 평가
ypred1 = model.predict(x_test)
print("훈련 세트 정확도: {:.3f}".format(model.score(x_train,y_train)))
print("테스트 세트 정확도: {:.3f}".format(model.score(x_test,y_test)))

#중요변수 확인
feat_labels = df.iloc[:,1:].columns
importances = model.feature_importances_
indices = np.argsort(importances)
for f in range(df.iloc[:,1:].shape[1]) :
        print('%2d) %-*s %f' %
        (f+1,30,feat_labels[indices[f]],importances[indices[f]]))

#중요변수 시각화
plt.title('Feature Importance')
plt.bar(range(df.iloc[:,1:].shape[1]),importances[indices],align='center')
plt.xticks(range(df.iloc[:,1:].shape[1]), feat_labels[indices], rotation=90)
plt.xlim([-1,x_train.shape[1]])
plt.tight_layout()
plt.show()

#-------------------------------------------------------------------------------------------
'''3. mlbench패키지 내 BostonHousing 데이터셋을 대상으로 예측기법 2개를 적용하여
기법별 결과를 비교하고 시각화하시오. (R과 python 버전으로 모두 실행)
-종속변수는MEDV 또는CMEDV를사용'''

#import packages----------------------------------------------------------------------------
import numpy as np
import pandas as pd
from sklearn.datasets import load_boston
from sklearn.model_selection import train_test_split

#의사결정나무
from sklearn.tree import DecisionTreeRegressor
from sklearn.tree import export_graphviz

#선형회귀분석
from sklearn.linear_model import LinearRegression
import statsmodels.api as sm
import random
from sklearn.tree import plot_tree
import matplotlib.pyplot as plt
import os
from graphviz import *
os.environ['PATH'] += os.pathsep + "C:/Program Files (x86)/Graphviz2.38/bin/"

#의사결정나무----------------------------------------------------------------------------------
#데이터 가져오기
boston_raw = load_boston()
def sklearn_to_df(sklearn_dataset):
    df = pd.DataFrame(sklearn_dataset.data, columns=sklearn_dataset.feature_names)
    df['target'] = pd.Series(sklearn_dataset.target)
    return df
df_boston = sklearn_to_df(boston_raw)
df_boston = df_boston.rename({"target": "MEDV"}, axis='columns')
print(df_boston.head(3))

# 종속변수 및 독립변수 데이터 셋으로 분리
y_target = df_boston['MEDV']
X_data = df_boston.drop(['MEDV'], axis = 1, inplace=False)

x_train, x_test, y_train, y_test = train_test_split(X_data, y_target, test_size=0.3, random_state = 295)

tree_model = DecisionTreeRegressor(max_depth=3 )
tree = tree_model.fit(x_train, y_train)
# Predict
pred = tree.predict(x_test)

print('정확도 : ', tree.score(x_train, y_train))

#fig = plt.figure(figsize=(10,8))
explt_vars = boston_raw.feature_names
decisiontree = plot_tree(tree_model,feature_names = explt_vars,filled=True)


#선형회귀분석-----------------------------------------------------------------------------------------
data = load_boston()
data
x = pd.DataFrame(data.data, columns=data.feature_names)
y = pd.DataFrame(data.target, columns=['MEDV'])
df = pd.concat([x, y], axis=1)
df.head(10)

# linear regressive analysis
x = df.drop(['MEDV'], axis=1)
y = df[['MEDV']]

var = x.columns.tolist()
var

selected = var
sl_remove = 0.05

sv_per_step = []
adjusted_r_squared = []
steps = []
step = 0

while len(selected) > 0:
    X = sm.add_constant(df[selected])
    p_vals = sm.OLS(y, X).fit().pvalues[1:]
    max_pval = p_vals.max()

    if max_pval >= sl_remove:
        remove_variable = p_vals.idxmax()
        selected.remove(remove_variable)
        step += 1
        steps.append(step)
        adj_r_squared = sm.OLS(y, sm.add_constant(df[selected])).fit().rsquared_adj
        adjusted_r_squared.append(adj_r_squared)
        sv_per_step.append(selected.copy())
    else:
        break

selected

x = df.drop(["INDUS","AGE","MEDV"], axis=1)
xtrain, xtest, ytrain, ytest = train_test_split(x, y, train_size=0.7, test_size=0.3,random_state=295)
mlr = LinearRegression()
mlr.fit(xtrain, ytrain)
pred = mlr.predict(xtest)

print(mlr.coef_)  # 변수 계수
mlr.fit(pred.reshape(-1, 1), ytest)
print(mlr.score(pred, ytest))

plt.rc('font', family='Malgun Gothic')
plt.plot(pred, ytest, 'o')
plt.xlabel('예측 값')
plt.ylabel('실제 값')
plt.plot(pred, mlr.predict(pred.reshape(-1, 1)))

#---------------------------------------------------------------------------------------------
'''6. R의 ggplot2 패키지 내 함수와 python의 matplotlib 패키지 내 함수를 사용하여
막대 차트(가로, 세로), 누적막대 차트, 점 차트, 원형 차트, 상자 그래프, 히스토그램,
산점도, 중첩자료 시각화, 변수간의 비교 시각화, 밀도그래프를 수업자료pdf 내 데이터를
이용하여 각각 시각화하고 비교하시오.'''

#import packages----------------------------------------------------------------------------
import matplotlib.pylab as plt
import seaborn as sns

#matplotlib 을 이용한 시각화
iris = sns.load_dataset('iris') # 데이터
iris_mean = iris.groupby('species').mean() # 평균데이터
iris_mean

# 막대차트(세로)
iris_mean.plot(kind='bar')

# 가로
iris_mean.plot(kind='barh')

# 누적막대 차트
iris_mean.plot(kind='bar',stacked = True)

# 점 차트
plt.scatter(iris_mean.index, iris_mean['sepal_length'])
plt.scatter(iris_mean.index, iris_mean['sepal_width'])
plt.scatter(iris_mean.index, iris_mean['petal_length'])
plt.scatter(iris_mean.index, iris_mean['petal_width'])
plt.legend(loc = (0.6, 0.7), labels = ['sepal_length', 'sepal_width', 'petal_length','petal_width'],title = 'species')

# 원형 차트
# sepal_length
plt.pie(iris_mean['sepal_length'],labels = iris_mean.index,autopct = '%.1f%%', wedgeprops = {'width':0.7, 'edgecolor':'w', 'linewidth' : 3})
plt.title('sepal_length')
plt.legend(loc = (0.9, 0.20), title = 'species')

# sepal_width
plt.pie(iris_mean['sepal_width'],labels = iris_mean.index,autopct = '%.1f%%',wedgeprops = {'width':0.7, 'edgecolor':'w', 'linewidth' : 3})
plt.title('sepal_width')
plt.legend(loc = (0.9, 0.25), title = 'species')

# peta_length
plt.pie(iris_mean['petal_length'],labels = iris_mean.index,autopct = '%.1f%%',wedgeprops = {'width':0.7, 'edgecolor':'w', 'linewidth' : 3})
plt.title('petal_length')
plt.legend(loc = (0.9, 0.25), title = 'species')

# petal_width
plt.pie(iris_mean['petal_width'],labels = iris_mean.index,autopct = '%.1f%%',wedgeprops = {'width':0.7, 'edgecolor':'w', 'linewidth' : 3})
plt.title('petal_width')
plt.legend(loc = (0.9, 0.25), title = 'species')

# 상자 그래프
# sepal_length
data = [iris[iris['species']=="setosa"]['sepal_length'],
        iris[iris['species']=="versicolor"]['sepal_length'],
        iris[iris['species']=="virginica"]['sepal_length']]
plt.boxplot(data, labels=['setosa', 'versicolor', 'virginica'], showmeans=True, patch_artist=True)
plt.title('sepal_length')
a = iris.groupby('species')['sepal_length']
a = iris.groupby('species')['sepal_width']
a = iris.groupby('species')['petal_length']
a = iris.groupby('species')['petal_width']
a.describe()

# sepal_width
data = [iris[iris['species']=="setosa"]['sepal_width'],
        iris[iris['species']=="versicolor"]['sepal_width'],
        iris[iris['species']=="virginica"]['sepal_width']]
plt.boxplot(data, labels=['setosa', 'versicolor', 'virginica'], showmeans=True, patch_artist=True)
plt.title('sepal_width')

# petal_length
data = [iris[iris['species']=="setosa"]['petal_length'],
        iris[iris['species']=="versicolor"]['petal_length'],
        iris[iris['species']=="virginica"]['petal_length']]
plt.boxplot(data, labels=['setosa', 'versicolor', 'virginica'], showmeans=True, patch_artist=True)
plt.title('petal_length')

# petal_width
data = [iris[iris['species']=="setosa"]['petal_width'],
        iris[iris['species']=="versicolor"]['petal_width'],
        iris[iris['species']=="virginica"]['petal_width']]
plt.boxplot(data, labels=['setosa', 'versicolor', 'virginica'], showmeans=True, patch_artist=True)
plt.title('petal_width')

# 히스토그램
plt.hist(iris['sepal_length'],bin=10)
plt.title('sepal_length')
plt.hist(iris['sepal_width'],bin=10)
plt.title('sepal_width')
plt.hist(iris['petal_length'],bin=10)
plt.title('peta_length')
plt.hist(iris['petal_width'],bin=10)
plt.title('petal_width')

# iris_sepal
groups = iris.groupby('species')
fig, ax = plt.subplots()
for name, group in groups:
    ax.plot(group.sepal_length,
            group.sepal_width,
            marker='o',
            linestyle='',
            label=name)
ax.legend(fontsize=12, loc='upper left')
plt.title('iris_sepal', fontsize=20)
plt.xlabel('sepal_length', fontsize=14)
plt.ylabel('sepal_width', fontsize=14)

# iris_petal
groups = iris.groupby('species')
fig, ax = plt.subplots()
for name, group in groups:
    ax.plot(group.petal_length,
            group.petal_width,
            marker='o',
            linestyle='',
            label=name)
ax.legend(fontsize=12, loc='upper left')
plt.title('iris_petal', fontsize=20)
plt.xlabel('Petal Length', fontsize=14)
plt.ylabel('Petal Width', fontsize=14)

# 중첩자료 시각화
# iris_sepal
iris_sepla = iris.groupby(['sepal_length','sepal_width'])
sepal = iris_sepla.size()
sepal = sepal.reset_index(name="count")
plt.scatter(sepal["sepal_length"], sepal["sepal_width"], s=sepal["count"]*100, c=sepal["count"], cmap='Wistia', alpha=0.8)
plt.title('iris_sepal', fontsize=20)
plt.xlabel('sepal_length', fontsize=14)
plt.ylabel('sepal_width', fontsize=14)

# iris_petal
iris_peta = iris.groupby(['petal_length','petal_width'])
petal = iris_peta.size()
petal = petal.reset_index(name="count")
plt.scatter(petal["petal_length"], petal["petal_width"], s=petal["count"]*100, c = petal["count"], cmap='Wistia', alpha =0.8)
plt.title('iris_petal', fontsize=20)
plt.xlabel('Petal Length', fontsize=14)
plt.ylabel('Petal Width', fontsize=14)

# 변수간의 비교 시각화, 밀도그래프
sns.pairplot(iris, hue="species")