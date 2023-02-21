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
#p.5 Replacing values
data = pd.Series([1., -999., 2., -999., -1000., 3.])
data

data.replace(-999,np.nan)
data.replace([-999,-1000],np.nan)
data.replace([-999,-1000],[np.nan,0])
data.replace({-999:np.nan, -1000:0})

#p.5 Renaming Axis Indexes
data = pd.DataFrame(np.arange(12).reshape((3, 4)),
                    index=['Ohio', 'Colorado', 'New York'],
                    columns=['one', 'two', 'three', 'four'])
data

transform = lambda x :x[:4].upper()
data.index.map(transform)

data.index = data.index.map(transform)
data

data.rename(index=str.title, columns=str.upper)

data.rename(index={'OHIO':'INDIANA'}, columns={'three':'peekaboo'})
data #원본이 유지된다.

data.rename(index={'OHIO':'INDIANA'},inplace=True)
data #원본이 수정된다.
#원본을 수정하는 형태보다는 다른 곳에 저장하는 것이 좋은 방법임

#p.6 Discretization and binning
ages = [20,22,25,27,21,23,37,31,61,45,41,32]
bins = [18,25,35,60,100]
cats = pd.cut(ages, bins)
cats
cats.codes
cats.categories
pd.value_counts(cats)

pd.cut(ages,[18,26,36,61,100],right= False)

group_names = ['Youth','youngAdult','MiddleAged','Senior']
cat2=pd.cut(ages,bins,labels=group_names)
pd.value_counts(cat2)

data = np.random.rand(20)
pd.cut(data,4,precision=2)#소수점 아래 2자리까지 표시

data = np.random.randn(1000)
cats = pd.qcut(data, 4) #같은 크기의 그룹으로 나늘때는 qcut 사용
cats

pd.value_counts(cats)
pd.qcut(data,[0,0.1,0.5,0.9,1.])

#p.7 이상값을 제외하거나 다른 값으로 대체
data = pd.DataFrame(np.random.randn(1000,4))
data.describe()
data
col = data[2]
col[np.abs(col)>3]
data[(np.abs(data) > 3).any(1)]

data[np.abs(data)>3] = np.sign(data)*3
data.describe()
np.sign(data).head()
#np.sign(data)는 data의 값이 양수 음수에 따라 1,-1이 담기 배열을 반환함

#p.8 Permutation and Random Sampling
df = pd.DataFrame(np.arange(5*4).reshape((5,4)))
df
sampler = np.random.permutation(5)
sampler

df
df.take(sampler)
df.sample(n=3)

choices = pd.Series([5,7,-1,6,4])
draws = choices.sample(n=10,replace=True)
draws

#p.9 Computing Indicator/Dummy Variables
df = pd.DataFrame({'key': ['b', 'b', 'a', 'c', 'a', 'b'],'data1': range(6)})
pd.get_dummies(df['key'])

dummies =pd.get_dummies(df['key'],prefix='key')
df_with_dummy = df[['data1']].join(dummies)
df_with_dummy

import os.path
os.getcwd()
os.chdir('pandas_dataset2/pandas_dataset2')
mnames = ['movie_id', 'title', 'genres']
movies = pd.read_table('movies.dat', sep='::',header=None, names=mnames)
movies[:10]

all_genres = []
for x in movies.genres:
 all_genres.extend(x.split('|'))
genres = pd.unique(all_genres)
genres

zero_matrix = np.zeros((len(movies), len(genres)))
dummies = pd.DataFrame(zero_matrix, columns=genres)

gen=movies.genres[0]
gen.split('|')
dummies.columns.get_indexer(gen.split('|'))

for i, gen in enumerate(movies.genres) :
    indices = dummies.columns.get_indexer(gen.split('|'))

dummies.iloc[i,indices] =1

movies_windic = movies.join(dummies.add_prefix('Genre_'))
movies_windic.iloc[0]

np.random.seed(12345)
values = np.random.rand(10)
values
bins = [0, 0.2, 0.4, 0.6, 0.8, 1]
pd.get_dummies(pd.cut(values, bins))

#p.11 String Object Methods
val = 'a,b, guido'
val.split(',')
pieces = [x.strip() for x in val.split(',')]
pieces

first, second, third = pieces
first + '::' + second + '::' + third
'::'.join(pieces)

'guido' in val
val.index(',')
val.find(':')
val.index(':') #없으면 예외 발생한다
val.count(',')
val.replace(',','::')
val.replace(',','')

import re
text = 'foo  bar\t baz  \tqux'
re.split('\s+',text)
regex = re.compile('\s+')
regex.split(text)
regex.findall(text)

text = """Dave dave@google.com
Steve steve@gmail.com
Rob rob@gmail.com
Ryan ryan@yahoo.com
"""
pattern = r'[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}'
regex = re.compile(pattern, flags=re.IGNORECASE) #flags는 조건을 추가할떄 사용
regex.findall(text)

m = regex.search(text)
m
text[m.start():m.end()]

print(regex.match(text))
print(regex.sub('REDACTED', text))

pattern = r'([A-Z0-9._%+-]+)@([A-Z0-9.-]+)\.([A-Z]{2,4})'
regex = re.compile(pattern, flags=re.IGNORECASE)
m = regex.match('wesm@bright.net')
m.groups()
regex.findall(text)
print(regex.sub(r'Username: \1, Domain: \2, Suffix: \3', text))



