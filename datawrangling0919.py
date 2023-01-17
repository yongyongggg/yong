# ch8 Data Wrangling: Join, Combine
import numpy as np
import pandas as pd
pd.options.display.max_rows = 20
np.random.seed(12345)
import matplotlib.pyplot as plt
plt.rc('figure', figsize=(10, 6))
np.set_printoptions(precision=4, suppress=True)
import os.path
os.getcwd()
os.chdir('pandas_dataset2/pandas_dataset2')
#p.1  Hierarchical Indexing
data = pd.Series(np.random.randn(9),
                 index=[['a','a','a','b','b','c','c','d','d'],
                        [1,2,3,1,3,1,2,2,3]])
data
data.index
data['b']
data['b':'c']
data.loc[['b','d']]
data.loc[:,2]

data.unstack()
data.unstack().stack()

frame = pd.DataFrame(np.arange(12).reshape((4, 3)),
                index=[['a', 'a', 'b', 'b'], [1, 2, 1, 2]],
                columns=[['Ohio', 'Ohio', 'Colorado'],
                 ['Green', 'Red', 'Green']])
frame
frame.index.names = ['key1', 'key2']
frame.columns.names = ['state', 'color']
frame
frame['Ohio']
MultiIndex = data.index
data
MultiIndex
MultiIndex.from_arrays([['Ohio', 'Ohio', 'Colorado'], ['Green', 'Red', 'Green']],
                     names=['state', 'color'])
MultiIndex

#p.2 Reordering and Sorting Levels
frame.swaplevel('key1', 'key2')
frame.sort_index(level=1)
frame.sort_index(level=0)
frame.swaplevel(0, 1).sort_index(level=0)

frame
frame.sum(level='key2')
frame.sum(level='color', axis=1)

frame = pd.DataFrame({'a': range(7), 'b': range(7, 0, -1),
         'c': ['one', 'one', 'one', 'two', 'two','two', 'two'],
            'd': [0, 1, 2, 0, 1, 2, 3]})

frame
frame2 = frame.set_index(['c', 'd'])
frame2
frame.set_index(['c', 'd'], drop=False)
frame2.reset_index()

df1 = pd.DataFrame({'key': ['b', 'b', 'a', 'c', 'a', 'a', 'b'],
                    'data1': range(7)})
df2 = pd.DataFrame({'key': ['a', 'b', 'd'],'data2': range(3)})

df1
df2
pd.merge(df1, df2)
pd.merge(df1, df2, on='key')

df3 = pd.DataFrame({'lkey': ['b', 'b', 'a', 'c', 'a', 'a', 'b'],
                         'data1': range(7)})
df4 = pd.DataFrame({'rkey': ['a', 'b', 'd'],'data2': range(3)})
df3
df4
pd.merge(df3, df4, left_on='lkey', right_on='rkey')
pd.merge(df1, df2, how='outer')

df1 = pd.DataFrame({'key': ['b', 'b', 'a', 'c', 'a', 'b'],
                     'data1': range(6)})
df2 = pd.DataFrame({'key': ['a', 'b', 'a', 'b', 'd'],
                        'data2': range(5)})
df1
df2
pd.merge(df1, df2, on='key', how='left')
pd.merge(df1, df2, how='inner')

left = pd.DataFrame({'key1': ['foo', 'foo', 'bar'],
            'key2': ['one', 'two', 'one'], 'lval': [1, 2, 3]})
right = pd.DataFrame({'key1': ['foo', 'foo', 'bar', 'bar'],
     'key2': ['one', 'one', 'one', 'two'], 'rval': [4, 5, 6, 7]})
pd.merge(left, right, on=['key1', 'key2'], how='outer')
pd.merge(left, right, on='key1')
pd.merge(left, right, on='key1', suffixes=('_left', '_right'))

#p.6 Merging on Index
left1 = pd.DataFrame({'key': ['a', 'b', 'a', 'a', 'b', 'c'],
                            'value': range(6)})
right1 = pd.DataFrame({'group_val': [3.5, 7]}, index=['a', 'b'])
left1
right1
pd.merge(left1,right1,left_on='key',right_index=True)
pd.merge(left1,right1,left_on='key',right_index=True,how='outer')

lefth = pd.DataFrame({'key1':['Ohio','Ohio','Ohio','Nevada','Nevada'],
                      'key2' :[2000,2001,2002,2001,2002],
                      'data': np.arange(5.)})
righth = pd.DataFrame(np.arange(12).reshape((6, 2)),
        index=[['Nevada', 'Nevada', 'Ohio', 'Ohio','Ohio', 'Ohio'],
        [2001, 2000, 2000, 2000, 2001, 2002]],columns=['event1', 'event2'])
lefth
righth

pd.merge(lefth,righth,left_on=['key1','key2'],right_index=True)
pd.merge(lefth,righth,left_on=['key1','key2'],right_index=True,how='outer')

left2 = pd.DataFrame([[1., 2.], [3., 4.], [5., 6.]],index=['a', 'c', 'e'],
                         columns=['Ohio', 'Nevada'])
right2 = pd.DataFrame([[7., 8.], [9., 10.], [11., 12.], [13, 14]],
        index=['b', 'c', 'd', 'e'],columns=['Missouri', 'Alabama'])
left2
right2
pd.merge(left2, right2, how='outer', left_index=True, right_index=True)
left2.join(right2, how='outer')
left1.join(right1, on='key')

another = pd.DataFrame([[7., 8.], [9., 10.], [11., 12.], [16., 17.]],
        index=['a', 'c', 'e', 'f'],columns=['New York', 'Oregon'])
another
left2.join([right2, another])
left2.join([right2, another], how='outer')

arr = np.arange(12).reshape((3, 4))
arr
np.concatenate([arr, arr], axis=1)

s1 = pd.Series([0, 1], index=['a', 'b'])
s2 = pd.Series([2, 3, 4], index=['c', 'd', 'e'])
s3 = pd.Series([5, 6], index=['f', 'g'])
s1
s2
s3
pd.concat([s1,s2,s3])
pd.concat([s1,s2,s3],axis=1)

s4=pd.concat([s1,s3])
s1
s4
pd.concat([s1,s4],axis=1)
pd.concat([s1, s4], axis=1, join='inner')
pd.concat([s1, s4], axis=1, join_axes=[['a', 'c', 'b', 'e']])

result = pd.concat([s1, s1, s3], keys=['one', 'two', 'three'])
result
result.unstack()

pd.concat([s1, s2, s3], axis=1, keys=['one', 'two', 'three'])

df1 = pd.DataFrame(np.arange(6).reshape(3, 2), index=['a', 'b', 'c'],
                        columns=['one', 'two'])
df2 = pd.DataFrame(5 + np.arange(4).reshape(2, 2), index=['a', 'c'],
                        columns=['three', 'four'])
df1
df2
pd.concat([df1, df2], axis=1, keys=['level1', 'level2'])
pd.concat({'level1': df1, 'level2': df2}, axis=1)

pd.concat([df1, df2], axis=1, keys=['level1', 'level2'],
                        names=['upper', 'lower'])


df1 = pd.DataFrame(np.random.randn(3, 4), columns=['a', 'b', 'c', 'd'])
df2 = pd.DataFrame(np.random.randn(2, 3), columns=['b', 'd', 'a'])
df1
df2
pd.concat([df1, df2], ignore_index=True)

#p.10 Combining Data with Overlap
a = pd.Series([np.nan, 2.5, np.nan, 3.5, 4.5, np.nan],
                    index=['f', 'e', 'd', 'c', 'b', 'a'])
b = pd.Series(np.arange(len(a), dtype=np.float64),
                    index=['f', 'e', 'd', 'c', 'b', 'a'])
b[-1] = np.nan
a
b
np.where(pd.isnull(a), b, a)
b[:-2].combine_first(a[2:])

df1 = pd.DataFrame({'a': [1., np.nan, 5., np.nan],
                    'b': [np.nan, 2., np.nan, 6.],
                    'c': range(2, 18, 4)})
df2 = pd.DataFrame({'a': [5., 4., np.nan, 3., 7.],
                    'b': [np.nan, 3., 4., 6., 8.]})
df1
df2
df1.combine_first(df2)

#p.11 Reshaping and Pivoting
data = pd.DataFrame(np.arange(6).reshape((2, 3)),
        index=pd.Index(['Ohio', 'Colorado'], name='state'),
        columns=pd.Index(['one', 'two', 'three'], name='number'))
data
result = data.stack()
result
result.unstack()

result.unstack(0)
result.unstack(1)
result.unstack('state')

s1 = pd.Series([0, 1, 2, 3], index=['a', 'b', 'c', 'd'])
s1
s2 = pd.Series([4, 5, 6], index=['c', 'd', 'e'])
s2
data2 = pd.concat([s1, s2], keys=['one', 'two'])
data2
data2.unstack()

data2.unstack()
data2.unstack().stack()
data2.unstack().stack(dropna=False)

df = pd.DataFrame({'left': result, 'right': result + 5},
                columns=pd.Index(['left', 'right'], name='side'))
df
df.unstack('state')
df.unstack('state').stack('side')

data = pd.read_csv('macrodata.csv')
data.head()
periods = pd.PeriodIndex(year=data.year, quarter=data.quarter,
                                        name='date')
columns = pd.Index(['realgdp', 'infl', 'unemp'], name='item')
data = data.reindex(columns=columns)
data.index = periods.to_timestamp('D', 'end')
ldata = data.stack().reset_index().rename(columns={0: 'value'})
ldata[:10]

pivoted = ldata.pivot('date', 'item', 'value')
pivoted

ldata['value2'] = np.random.randn(len(ldata))
ldata[:10]

pivoted = ldata.pivot('date', 'item')
pivoted[:5]
pivoted['value'][:5]

unstacked = ldata.set_index(['date', 'item']).unstack('item')
unstacked[:7]

df = pd.DataFrame({'key': ['foo', 'bar', 'baz'],'A': [1, 2, 3],
                         'B': [4, 5, 6],'C': [7, 8, 9]})
df
melted = pd.melt(df, ['key'])
melted
reshaped = melted.pivot('key', 'variable', 'value')
reshaped
reshaped.reset_index()
pd.melt(df, id_vars=['key'], value_vars=['A', 'B'])
pd.melt(df, value_vars=['A', 'B', 'C'])
pd.melt(df, value_vars=['key', 'A', 'B'])


