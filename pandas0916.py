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
#p.16 Function Application and Mapping
frame = pd.DataFrame(np.random.randn(4, 3), columns=list('bde'),
                    index=['Utah', 'Ohio', 'Texas', 'Oregon'])
frame
np.abs(frame)

f= lambda x : x.max() -x.min()
frame.apply(f)

frame.apply(f,axis='columns')
def f(x) :
    return pd.Series([x.min(), x.max()],index=['min','max'])
frame.apply(f)

format = lambda x : '%.2f' % x
frame.applymap(format)

frame['e'].map(format)

#p.17 orting and Ranking
obj = pd.Series(range(4), index=['d', 'a', 'b', 'c'])
obj.sort_index()

frame = pd.DataFrame(np.arange(8).reshape((2, 4)),index=['three', 'one'],
                                columns=['d', 'a', 'b', 'c'])
frame
frame.sort_index()
frame.sort_index(axis=0)
frame.sort_index(axis=1)

frame.sort_index(axis=1, ascending=False)

obj=pd.Series([4,7,-3,2])
obj
obj.sort_values()

obj = pd.Series([4,np.nan,7,np.nan,-3,2])
obj
obj.sort_values()

frame = pd.DataFrame({'b':[4,7,-3,2],'a':[0,1,0,1]})
frame
frame.sort_values(by='b')
frame.sort_values(by=['a', 'b'])

obj = pd.Series([7, -5, 7, 4, 2, 0, 4])
obj
obj.rank()
obj.rank(method='first')
obj.rank(ascending=False, method='max')

frame = pd.DataFrame({'b': [4.3, 7, -3, 2], 'a': [0, 1, 0, 1],
                                 'c': [-2, 5, 8, -2.5]})
frame
frame.rank(axis='columns')

#p.18 Axis Indexes with Duplicate Labels 중복색인

obj = pd.Series(range(5),index=['a','a','b','b','c'])
obj
obj.index.is_unique

obj['a']
obj['b']

df = pd.DataFrame(np.random.rand(4,3),index=['a','a','b','b'])
df
df.loc['b']

#P.19 Summarizing and Computing Descriptive Statistics
df = pd.DataFrame([[1.4, np.nan], [7.1, -4.5],[np.nan, np.nan], [0.75, -1.3]],
             index=['a', 'b', 'c', 'd'],columns=['one', 'two'])
df
df.sum()
df.sum(axis='columns')
df.mean(axis='columns',skipna=False)
df.idxmax()
df.idxmin()
df.cumsum()
df.describe()

obj = pd.Series(['a','a','b','c'])
obj.describe()

#p.20 Correlation and Covariance
price = pd.read_pickle('yahoo_price.pkl')


import pandas_datareader.data as web
all_data = {ticker: web.get_data_yahoo(ticker)
 for ticker in ['AAPL', 'IBM', 'MSFT', 'GOOG']}
price = pd.DataFrame({ticker: data['Adj Close'] for ticker, data in
all_data.items()})
volume = pd.DataFrame({ticker: data['Volume'] for ticker, data in
all_data.items()})
returns = price.pct_change()
returns.tail()
returns['MSFT'].corr(returns['IBM'])
returns['MSFT'].cov(returns['IBM'])
returns.MSFT.corr(returns.IBM)
returns.corr()
returns.cov()
returns.corrwith(returns.IBM)
returns.corrwith(volume)

#p.21 Unique Values, Value Counts, and Membership
obj = pd.Series(['c', 'a', 'd', 'a', 'a', 'b', 'b', 'c', 'c'])
obj
uniques = obj.unique()
uniques
obj.values
obj.value_counts()
pd.value_counts(obj.values, sort=False)

obj
mask = obj.isin(['b', 'c'])
mask
obj[mask]

to_match = pd.Series(['c', 'a', 'b', 'b', 'c', 'a'])
unique_vals = pd.Series(['c', 'b', 'a'])
pd.Index(unique_vals).get_indexer(to_match)

data = pd.DataFrame({'Qu1': [1, 3, 4, 3, 4],'Qu2': [2, 3, 1, 2, 3],
                                'Qu3': [1, 5, 2, 4, 4]})
data
result = data.apply(pd.value_counts).fillna(0)
result





