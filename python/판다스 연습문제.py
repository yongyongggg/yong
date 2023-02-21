#문제1
import pandas as pd
ds = pd.Series([2,4,8,6,10])
print(ds)

#문제2
import pandas as pd
ds = pd.Series([2, 4, 6, 8, 10])
print("Pandas Series and type")
print(ds)
print(type(ds))
print("Convert Pandas Series to Python list")
print(ds.tolist())
print(type(ds.tolist()))

# 문제3
ds1 = pd.Series([2,4,6,8,10])
ds2 = pd.Series([1,3,5,7,9])
ds1 + ds2
ds1 - ds2
ds1 * ds2
ds1 / ds2

# 문제4
ds1 = pd.Series([2,4,6,8,10])
ds2 = pd.Series([1,3,5,7,9])
ds1 == ds2
ds1 > ds2
ds1 < ds2

# ex5
ds = pd.Series({'a':100,'b':200,'c':300,'d':400,'e':800})
print(ds)
ds1 = pd.Series(ds)
print(ds1)

# ex6
d1 = np.array([10,20,30,40,50])
print(d1)
d2 = pd.Series(d1)
print(d2)

# ex7
d1= pd.Series([100,200,'python',300.12,400])
d1
d2 = pd.to_numeric(d1,errors='coerce')
d2

# Ex8
d = {'col1': [1, 2, 3, 4, 7, 11], 'col2': [4, 5, 6, 9, 5, 0], 'col3': [7, 5, 8, 12, 1,11]}
df = pd.DataFrame(d)
df
s1 = df.Series[:,0]
