#2.pandas_n1
import pandas as pd
# Series 와 DataFrame 은 로컬 네임스페이스로 인포트
from pandas import Series, DataFrame
# 환경설정
import numpy as np
np.random.seed(12345)
import matplotlib.pyplot as plt
plt.rc('figure', figsize=(10, 6))
PREVIOUS_MAX_ROWS = pd.options.display.max_rows
pd.options.display.max_rows = 20
np.set_printoptions(precision=4, suppress=True)
pd.options.display.max_rows = PREVIOUS_MAX_ROWS

#p.2
obj = pd.Series([4, 7, -5, 3])
obj
obj.values
obj.index

obj2 = pd.Series([4, 7, -5, 3], index=['d', 'b', 'a', 'c'])
obj2
obj2.index

obj2['a']
obj2['d'] = 6
obj2[['c', 'a', 'd']]

obj2[obj2 > 0]
obj2 * 2
np.exp(obj2)
obj2

'b' in obj2
'e' in obj2

sdata = {'Ohio': 35000, 'Texas': 71000, 'Oregon': 16000, 'Utah': 5000}
obj3 = pd.Series(sdata)
obj3
states = ['California', 'Ohio', 'Oregon', 'Texas']
obj4 = pd.Series(sdata, index=states)
obj4

pd.isnull(obj4)
pd.notnull(obj4)
obj4.isnull()

obj3
obj4
obj3 + obj4

obj4.name = 'population'
obj4.index.name = 'state'
obj4

obj
obj.index = ['Bob', 'Steve', 'Jeff', 'Ryan']
obj

#p.4 dataframe
data = {'state': ['Ohio', 'Ohio', 'Ohio', 'Nevada', 'Nevada', 'Nevada'],
 'year': [2000, 2001, 2002, 2001, 2002, 2003],
 'pop': [1.5, 1.7, 3.6, 2.4, 2.9, 3.2]}
data
frame = pd.DataFrame(data)
frame
frame.head()
pd.DataFrame(data, columns=['year','state','pop'])

frame2 = pd.DataFrame(data, columns=['year', 'state', 'pop', 'debt'],
 index=['one', 'two', 'three', 'four','five', 'six'])
frame2
frame2.columns

frame2['state']
frame2.year

frame2.loc['three']














