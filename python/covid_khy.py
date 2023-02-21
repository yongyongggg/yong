import os.path
from typing import List, Any
import pandas as pd
os.getcwd()
os.chdir('COVID-19-master\COVID-19-master\csse_covid_19_data\csse_covid_19_daily_reports')

data2021 = pd.read_csv('12-31-2021.csv') #2021데이터 호출
data2020 = pd.read_csv('12-31-2020.csv') #2020데이터 호출

covid_data21 = data2021[['Country_Region','Confirmed', 'Deaths']]
covid_data21 #2021년 필요한 column 뽑기
covid_data20 = data2020[['Country_Region','Confirmed', 'Deaths']]
covid_data20 #2020년 필요한 column 뽑기

#올림픽 제거하기
del_olympics = covid_data21[covid_data21['Country_Region'].str.contains('Olympics')].index
del_olympics2 = covid_data20[covid_data20['Country_Region'].str.contains('Olympics')].index
covid_data21.drop(del_olympics, inplace=True)
covid_data20.drop(del_olympics2, inplace=True)

#중복 제거하기
group1=covid_data21.groupby('Country_Region').sum()
group2=covid_data20.groupby('Country_Region').sum()

#총 확진자, 사망자 구하기
tot = group1.sub(group2)
tot
#일평균 확진자, 사망자 구하기
daily = tot/365
daily

#컬럼명 재설정
tot1 = tot.rename(columns={'Confirmed' :'tot_con', 'Deaths' :'tot_dea'})
daily1 = daily.rename(columns={'Confirmed' :'daily_con', 'Deaths' :'daily_dea'})

#합치기
result = pd.concat([tot1,daily1],axis=1)
result

#인덱스 생성하기
result1=result.reset_index()
result1

#micronesia
complement= list(set(covid_data21.index) - set(covid_data20.index))
complement





#문제 2
Ans1 = result1.loc[result1['tot_con']==0]
Ans1
Ans2 = result1[result1['tot_con'].isnull()]
Ans2

lst_country =  pd.concat([Ans1,Ans2],axis=0)
print(lst_country['Country_Region'])


#문제 3
tot_con1 = result1.sort_values('tot_con',ascending=False)
tot_con1.head(20)
tot_dea1 = result1.sort_values('tot_dea',ascending=False)
tot_dea1.head(20)
daily_con1 = result1.sort_values('daily_con',ascending=False)
daily_con1.head(20)
daily_dea1 = result1.sort_values('daily_con',ascending=False)
daily_dea1.head(20)

#문제4
kor_report = result1.loc[result1['Country_Region']=='Korea, South']
kor_report





