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
#p.4 dataframe
data = {'state': ['Ohio', 'Ohio', 'Ohio', 'Nevada', 'Nevada', 'Nevada'],
 'year': [2000, 2001, 2002, 2001, 2002, 2003],
 'pop': [1.5, 1.7, 3.6, 2.4, 2.9, 3.2]}
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

frame2['debt']=16.5
frame2
frame2['debt']=np.arange(6.)
frame2

val = pd.Series([-1.2,-1.5,-1.7],index=['two','four','five'])
frame2['debt']=val
frame2

frame2['eastern'] = frame2.state == 'Ohio'
frame2

del frame2['eastern']
frame2

#p.5 중첩된 사전을 이용하여 데이터 생성
pop = {'Nevada': {2001: 2.4, 2002: 2.9},
 'Ohio': {2000: 1.5, 2001: 1.7, 2002: 3.6}}

frame3 = pd.DataFrame(pop)
frame3
frame3.T

pd.DataFrame(pop,index=[2001,2002,2003])

pdata = {'Ohio': frame3['Ohio'][:-1],'Nevada': frame3['Nevada'][:2]}
pd.DataFrame(pdata)

frame3.index.name = 'year' ; frame3.columns.name ='state'
frame3

frame3.values
frame2.values

#p.7 index objects
obj= pd.Series(range(3),index=['a','b','c'])
index = obj.index
index
index[1:]
# index[1] = 'd' 색인 객체는 변경이 불가능하다

labels = pd.Index(np.arange(3))
labels
obj = pd.Series([1.5,-2.5,0],index=labels)
obj
obj.index is labels

frame3
frame3.columns
'Ohio' in frame3.columns
2003 in frame3.index

#pandas의 인덱스는 중복되는 값을 허용한다
dup_labels = pd.Index(['foo','foo','bar','bar'])
dup_labels

#p.9 Reindexing
obj= pd.Series([4.5,7.2,-5.3,3.6],index=['d','b','a','c'])
obj

obj2 = obj.reindex(['a','b','c','d','e'])
obj2

obj3 = pd.Series(['blue','purple','yellow'],index=[0,2,4])
obj3
obj3.reindex(range(6),method='ffill')

#DataFrame 에 대한 reindex 는 로우(새긴), 컬럼 또는 둘다 변경 가능
frame = pd.DataFrame(np.arange(9).reshape((3,3)),
                     index=['a','b','c'],
                     columns=['Ohio','Texas','California'])
frame
frame2 = frame.reindex(['a','b','c','d'])
frame2

states = ['Texas','Utah','California']
frame3=frame2.reindex(columns=states)
frame3
frame3.loc[['a','c','b','d'],states]

#p.10 Dropping Entries from an Axis
obj= pd.Series(np.arange(5.),index=['a','b','c','d','e'])
obj
new_obj= obj.drop('c')
new_obj
obj.drop(['d','c'])

data = pd.DataFrame(np.arange(16).reshape((4, 4)),
               index=['Ohio', 'Colorado', 'Utah', 'New York'],
               columns=['one', 'two', 'three', 'four'])
data
data.drop(['Colorado','Ohio'])
data.drop('two',axis=1)
data.drop(['two','four'],axis='columns')

# 새로운 객체를 반환하는 대신 원본 객체를 변경한다.
obj.drop('c', inplace=True)
obj

#p.11
obj = pd.Series(np.arange(4.), index=['a', 'b', 'c', 'd'])
obj
obj['b']
obj[1]
obj[2:4]
obj[['b', 'a', 'd']]
obj[[1, 3]]
obj[obj < 2]

# 라벨 이름으로 슬라이싱하면 시작점과 끝점을 포함한다는 것이
# 일반 파이썬에서의 슬라이싱과 다른점.
obj['b':'c']
obj['b':'c'] = 5
obj

# 색인으로 DataFrame 에서 하나 이상의 컬럼 값을 가져올 수 있음.
data = pd.DataFrame(np.arange(16).reshape((4, 4)),
                 index=['Ohio', 'Colorado', 'Utah', 'New York'],
                 columns=['one', 'two', 'three', 'four'])
data
data['two']
data[['three', 'one']]

data[:2]
data[data['three'] > 5]

data < 5
data[data < 5] = 0
data

#p.12 Selection with loc and iloc
data
data.loc['Colorado', ['two', 'three']]
data.iloc[2, [3, 0, 1]]
data.iloc[2]
data.iloc[[1, 2], [3, 0, 1]]
# loc & iloc 함수는 슬라이스 지원 및 단일 라벨이나 라벨 리스트 지원
data.loc[:'Utah', 'two']
data.iloc[:, :3][data.three > 5]

#p.13 Arithmetic and Data Alignment
s1 = pd.Series([7.3, -2.5, 3.4, 1.5], index=['a', 'c', 'd', 'e'])
s2 = pd.Series([-2.1, 3.6, -1.5, 4, 3.1], index=['a', 'c', 'e', 'f', 'g'])
s1
s2
s1 +s2

df1 = pd.DataFrame(np.arange(9.).reshape((3, 3)), columns=list('bcd'),
                  index=['Ohio', 'Texas', 'Colorado'])
df2 = pd.DataFrame(np.arange(12.).reshape((4, 3)), columns=list('bde'),
                  index=['Utah', 'Ohio', 'Texas', 'Oregon'])
df1
df2
df1 + df2

df1 = pd.DataFrame({'A': [1, 2]})
df2 = pd.DataFrame({'B': [3, 4]})
df1
df2
df1-df2

df1 = pd.DataFrame(np.arange(12.).reshape((3, 4)),columns=list('abcd'))
df2 = pd.DataFrame(np.arange(20.).reshape((4, 5)),columns=list('abcde'))
df2.loc[1,'b'] = np.nan
df1
df2
df1+df2
df1.add(df2,fill_value=0)

1/df1
df1.rdiv(1)

df1.reindex(columns=df2.columns,fill_value=0)

arr = np.arange(12.).reshape((3, 4))
arr
arr[0]
arr-arr[0]

frame = pd.DataFrame(np.arange(12.).reshape((4, 3)),columns=list('bde'),
                      index=['Utah', 'Ohio', 'Texas', 'Oregon'])
serise = frame.iloc[0]
frame
serise
frame - serise

series2 = pd.Series(range(3), index=['b', 'e', 'f'])
series2
frame +series2

frame
serise3 = frame['d']
serise3
frame.sub(serise3,axis='index')





