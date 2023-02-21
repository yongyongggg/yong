#Data Aggregation and Group Operations
import numpy as np
import pandas as pd
PREVIOUS_MAX_ROWS = pd.options.display.max_rows
pd.options.display.max_rows = 20
np.random.seed(12345)
import matplotlib.pyplot as plt
plt.rc('figure', figsize=(10, 6))
np.set_printoptions(precision=4, suppress=True)
import os.path
os.getcwd()
os.chdir('pandas_dataset2/pandas_dataset2')

#p.2 GroupBy Mechanics
df = pd.DataFrame({'key1' : ['a', 'a', 'b', 'b', 'a'],
         'key2' : ['one', 'two', 'one', 'two', 'one'],
         'data1' : np.random.randn(5),'data2' : np.random.randn(5)})
df
grouped = df['data1'].groupby(df['key1'])
grouped
grouped.mean()

means = df['data1'].groupby([df['key1'],df['key2']]).mean()
means

means.unstack()

states = np.array(['Ohio', 'California', 'California', 'Ohio', 'Ohio'])
years = np.array([2005, 2005, 2006, 2005, 2006])
df['data1'].groupby([states,years]).mean()

df.groupby('key1').mean()
df.groupby(['key1','key2']).mean()

df.groupby(['key1', 'key2']).size()

for name, group in df.groupby('key1'):
                    print(name)
                    print(group)

for (k1, k2), group in df.groupby(['key1', 'key2']):
 print((k1, k2))
 print(group)

pieces = dict(list(df.groupby('key1')))
pieces['b']

df.dtypes
grouped = df.groupby(df.dtypes, axis=1)

for dtype, group in grouped:
 print(dtype)
 print(group)

df.groupby('key1')['data1']
df.groupby('key1')[['data2']]

df['data1'].groupby(df['key1'])
df[['data2']].groupby(df['key1'])

df.groupby(['key1', 'key2'])[['data2']].mean()

s_grouped = df.groupby(['key1', 'key2'])['data2']
s_grouped
s_grouped.mean()

#p.4 Grouping with Dicts and Series
people = pd.DataFrame(np.random.randn(5, 5),
                    columns=['a', 'b', 'c', 'd', 'e'],
                    index=['Joe', 'Steve', 'Wes', 'Jim', 'Travis'])
people
people.iloc[2:3,[1,2]] =np.nan
people

mapping = {'a': 'red', 'b': 'red', 'c': 'blue',
                    'd': 'blue', 'e': 'red', 'f' : 'orange'}
by_column = people.groupby(mapping, axis=1)
by_column.sum()

map_series = pd.Series(mapping)
map_series
people.groupby(map_series, axis=1).count()








