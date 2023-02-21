#########평가 4
######김용현

#문제1
import numpy
import pandas
from pandas import Series,DataFrame
numpy.random.seed(1357)

#문제2
import pandas as pd
data = {'state': ['Ohio', 'Ohio', 'Ohio', 'Nevada', 'Nevada', 'Nevada'],
                    'year': [2000, 2001, 2002, 2001, 2002, 2003],
                     'pop': [1.5, 1.7, 3.6, 2.4, 2.9, 3.2]}

frame2 = pd.DataFrame(data, columns=['year', 'state', 'pop', 'debt'],
                 index=['one', 'two', 'three', 'four','five', 'six'])

frame2.debt
#'debt'컬럼은 모두 NaN이기 때문에 Null이라고 할 수 있다.

#문제3
import  pandas as pd
import numpy as np
string_data = pd.Series(['aardvark','artichoke', np.nan ,'avocado'] )
string_data

#문제4
import  pandas as pd
import numpy as np
data = pd.DataFrame(np.arange(16).reshape((4, 4)),
                index=['Ohio', 'Colorado', 'Utah', 'New York'],
                columns=['one', 'two', 'three', 'four'])

data[data['three'] > 5]

#문제5
del data['four']
data

#문제6
data1 =data.drop('Utah')
data1

#문제7
import  pandas as pd
import numpy as np
frame = pd.DataFrame(np.arange(8).reshape((2, 4)),index=['three', 'one'],
                                    columns=['d', 'a', 'b', 'c'])
frame.sort_index(axis=0,ascending=False)

#문제8
frame.sort_index(axis=1)

#문항9
import  pandas as pd
import numpy as np
obj = pd.Series([1.,np.nan,3.5,np.nan,7])
obj

#문항10
obj1=obj.fillna(obj.mean())
obj1

#문항11
import  pandas as pd
import numpy as np
np.random.seed(1234)
data = pd.DataFrame(np.random.randn(1000, 4))
data[2]

#문항12
data.describe()

#문항13
data[np.abs(data) >= 3] = np.abs(data) * 3
data

#문항14
import  pandas as pd
df = pd.DataFrame({'key': ['foo', 'bar', 'baz'],'A': [1, 2, 3],
                                'B': [4, 5, 6],'C': [7, 8, 9]})
melted = pd.melt(df,['key'])
melted

#문항15
reshaped = melted.pivot('key', 'variable', 'value')
reshaped1=reshaped.reset_index()
reshaped1

