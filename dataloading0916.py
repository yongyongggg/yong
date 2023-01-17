#3 data_loading
#환경 설정
import numpy as np
import pandas as pd
np.random.seed(12345)
import matplotlib.pyplot as plt
plt.rc('figure', figsize=(10, 6))
np.set_printoptions(precision=4, suppress=True)
import os.path
os.getcwd()
os.chdir('pandas_dataset2/pandas_dataset2')
#p.3
df = pd.read_csv('ex1.csv')
df
#구분자를 쉼표로 지정
pd.read_table('ex1.csv',sep=',')


pd.read_csv('ex2.csv',header=None)
pd.read_csv('ex2.csv',names=['a','b','c','d','message'])
names = ['a', 'b', 'c', 'd', 'message']
pd.read_csv('ex2.csv', names=names, index_col='message')

names = ['a', 'b', 'c', 'd', 'message']
pd.read_csv('ex2.csv', names=names, index_col='message')

parsed = pd.read_csv('csv_mindex.csv', index_col=['key1', 'key2'])
parsed

list(open('ex3.txt'))
result = pd.read_table('ex3.txt', sep='\s+')
result

pd.read_csv('ex4.csv', skiprows=[0, 2, 3])

result = pd.read_csv('ex5.csv')
result
pd.isnull(result)

result = pd.read_csv('ex5.csv', na_values=['NULL'])
result

sentinels = {'message': ['foo', 'NA'], 'something': ['two']}
pd.read_csv('ex5.csv', na_values=sentinels)

#p.5 Reading Text Files in Pieces
pd.options.display.max_rows = 10
#pd.options.display.max_rows = None 을하면 설정 해제

result = pd.read_csv('ex6.csv')
result

pd.read_csv('ex6.csv', nrows=5)

chunker = pd.read_csv('ex6.csv', chunksize=1000)
chunker = pd.read_csv('ex6.csv', chunksize=1000)

tot = pd.Series([])
for piece in chunker:
 tot = tot.add(piece['key'].value_counts(), fill_value=0)
tot = tot.sort_values(ascending=False)
tot[:10]

#p.6 Writing Data to Text Format
data = pd.read_csv('ex5.csv')
data
data.to_csv('out.csv')

import sys
data.to_csv(sys.stdout, sep='|')
data.to_csv(sys.stdout, na_rep='NULL')
data.to_csv(sys.stdout, index=False, header=False)
data.to_csv(sys.stdout, index=False, columns=['a', 'b', 'c'])

dates = pd.date_range('1/1/2000', periods=7)
ts = pd.Series(np.arange(7), index=dates)
ts.to_csv('tseries.csv')

#p.6 Working with Delimited Formats
import csv
f = open('ex7.csv')
reader = csv.reader(f)
for line in reader:
        print(line)

with open('ex7.csv') as f:
 lines = list(csv.reader(f))
header, values = lines[0], lines[1:]

data_dict = {h: v for h, v in zip(header, zip(*values))}
data_dict

class my_dialect(csv.Dialect):
    lineterminator = '\n'
    delimiter = ';'
    quotechar = '"'
    quoting = csv.QUOTE_MINIMAL

reader = csv.reader('ex7.csv', dialect=my_dialect)
reader = csv.reader('ex7.csv', delimiter='|')

with open('mydata.csv', 'w') as f:
 writer = csv.writer(f, dialect=my_dialect)
 writer.writerow(('one', 'two', 'three'))
 writer.writerow(('1', '2', '3'))
 writer.writerow(('4', '5', '6'))
 writer.writerow(('7', '8', '9'))




