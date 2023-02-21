############애플리케이션 테스트 관리
########김용현

#문항1
y_pred = [0, 1, 0, 0, 1, 0, 1, 0, 0, 1]
y_true = [0, 1, 0, 1, 1, 0, 1, 1, 0, 1]
#1)
from sklearn.metrics import accuracy_score
accuracy_score(y_true, y_pred)
#2)
from sklearn.metrics import precision_score
precision_score(y_true, y_pred, average='macro')
#3)
from sklearn.metrics import recall_score
recall_score(y_true, y_pred, average='macro')
#4)
from sklearn.metrics import f1_score
f1_score(y_true, y_pred, average='macro')
#5)
from sklearn.metrics import fbeta_score
fbeta_score(y_true, y_pred, average='macro', beta=2)

#문항2
y_pred = ["cat", "dog", "cat", "cat", "dog", "bird", "bird"]
y_true = ["dog", "dog", "cat", "cat", "dog", "cat", "bird"]
#1)
from sklearn.metrics import accuracy_score
accuracy_score(y_true, y_pred)
#2)
from sklearn.metrics import precision_score
precision_score(y_true, y_pred, average='macro')
#3)
from sklearn.metrics import recall_score
recall_score(y_true, y_pred, average='macro')
#4)
from sklearn.metrics import f1_score
f1_score(y_true, y_pred, average='macro')
#5)
from sklearn.metrics import fbeta_score
fbeta_score(y_true, y_pred, average='macro', beta=2)

#문항3
y_pred = [1, 8, 5, -2, -1, 2.5, 3, -0.5, 2, 7]
y_true = [0.8, 7.7, 5.2, -1.5, -0.8, 2.5, 3.2, 0.0, 2, 8]
#1)
from sklearn.metrics import r2_score
r2_score(y_true, y_pred)
#2)
from sklearn.metrics import mean_absolute_error
mean_absolute_error(y_true, y_pred)
#3)
from sklearn.metrics import mean_squared_error
mean_squared_error(y_true, y_pred)
#4)
from sklearn.metrics import mean_absolute_percentage_error
mean_absolute_percentage_error(y_true, y_pred)


