#4 datacleaning
import numpy as np
import pandas as pd
PREVIOUS_MAX_ROWS = pd.options.display.max_rows
pd.options.display.max_rows = 20
np.random.seed(12345)
import matplotlib.pyplot as plt
plt.rc('figure', figsize=(10, 6))
np.set_printoptions(precision=4, suppress=True)
pd.options.display.max_rows = PREVIOUS_MAX_ROWS

#p.1 Handling Missing Data
string_data = pd.Series(['aardvark', 'artichoke', np.nan, 'avocado'])
string_data

string_data.isnull()
string_data[0] = None
string_data.isnull()

from numpy import nan as NA
data = pd.Series([1, NA, 3.5, NA, 7])
data.dropna()

data[data.notnull()]

data = pd.DataFrame([[1., 6.5, 3.], [1., NA, NA],[NA, NA, NA], [NA, 6.5, 3.]])
cleaned = data.dropna()
data
cleaned

data.dropna(how='all')

data[4] = NA
data
data.dropna(axis=1, how='all')

df = pd.DataFrame(np.random.randn(7, 3))
df.iloc[:4, 1] = NA
df.iloc[:2, 2] = NA
df
df.dropna()
df.dropna(thresh=2)

df.fillna(0)
df.fillna({1: 0.5, 2: 0})

_ = df.fillna(0, inplace=True)
df

df = pd.DataFrame(np.random.randn(6, 3))
df
df.iloc[2:, 1] = NA
df.iloc[4:, 2] = NA
df
df.fillna(method='ffill')
df.fillna(method='ffill', limit=2)

data = pd.Series([1., NA, 3.5, NA, 7])
data.fillna(data.mean())

data = pd.DataFrame({'k1': ['one', 'two'] * 3 + ['two'],'k2': [1, 1, 2, 3, 3, 4, 4]})
data
data.duplicated()
data.drop_duplicates()

data['v1'] = range(7)
data
data.drop_duplicates(['k1'])

data.drop_duplicates(['k1', 'k2'], keep='last')

data = pd.DataFrame({'food': ['bacon', 'pulled pork', 'bacon',
                 'Pastrami', 'corned beef', 'Bacon',
                 'pastrami', 'honey ham', 'nova lox'],
                 'ounces': [4, 3, 12, 6, 7.5, 8, 3, 5, 6]})
data
meat_to_animal = {'bacon': 'pig','pulled pork': 'pig','pastrami': 'cow',
 'corned beef': 'cow','honey ham': 'pig','nova lox': 'salmon'}
data

lowercased = data['food'].str.lower()
lowercased
data['animal'] = lowercased.map(meat_to_animal)
data

data['food'].map(lambda x: meat_to_animal[x.lower()])












