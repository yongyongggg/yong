from sklearn.tree import export_graphviz

# iris 데이터 로딩
from sklearn.datasets import load_iris
iris = load_iris()

# DecisionTreeClassifier
from sklearn.tree import DecisionTreeClassifier
model = DecisionTreeClassifier()

# Define x and y
x_train, x_test, y_train, y_test = train_test_split(iris.data, iris.target, test_size=0.2, random_state=30)
