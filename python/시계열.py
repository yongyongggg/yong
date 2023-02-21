#시계열################################
import pandas as pd
import numpy as np
weather_station_location = pd.read_csv("./archive/Weather Station Locations.csv")
weather = pd.read_csv("./archive/Summary of Weather.csv")

weather_station_location = weather_station_location.loc[:,['WBAN',"NAME","STATE/COUNTRY ID"]]
weather = weather.loc[:,['STA','Date','MeanTemp']]
weather_station_location.head()
weather.head()

import warnings
warnings.filterwarnings(action='ignore')
#BINDUKURI에 해당하는 데이터 출력
weather_station_id = weather_station_location[weather_station_location.NAME == 'BINDUKURI'].WBAN
weather_bin = weather[weather.STA == int(weather_station_id)]
weather_bin['Date'] = pd.to_datetime(weather_bin['Date'])

#데이터 확인
import matplotlib.pyplot as plt
plt.figure(figsize=(22,8))
plt.plot(weather_bin.Date, weather_bin.MeanTemp)
plt.title("Mean Temperature of Bindukuri Area")
plt.xlabel('Date')
plt.ylabel('Mean Temperature')
plt.show()

#시계열 형태의 ts 데이터 생성
timeseries = weather_bin.loc[:,['Date','MeanTemp']]
timeseries.index = timeseries.Date
ts = timeseries.drop('Date',axis=1)

from statsmodels.tsa.seasonal import seasonal_decompose
result = seasonal_decompose(ts['MeanTemp'], model='additive', period= 7)

fig = result.plot()
fig.set_size_inches(20,15)

#패턴을 보이기 때문에 정상성 의심
import statsmodels.api as sm

fig = plt.figure(figsize=(20,8))
ax1= fig.add_subplot(211)
fig = sm.graphics.tsa.plot_acf(ts, lags=20, ax=ax1)
#ACF값이 천천히 감소하는 것은 정상성을 만족하지 않는다.

from statsmodels.tsa.stattools import adfuller
result = adfuller(ts)
print('ADF Statisic: %f' % result[0])
print('p-value: %f' % result[1])
print('Critical values:')
for key, value in result[4].items() :
        print('\t%s: %.3f' % (key, value))
#p-value가 0.05를 넘기므로 정상성을 만족하지 못한다.

#1차차분
ts_diff = ts - ts.shift()
plt.figure(figsize=(22,8))
plt.plot(ts_diff)
plt.title("Differecing method")
plt.xlabel('Date')
plt.ylabel('Differecing Mean Temperature')
plt.show()

result = adfuller(ts_diff[1:])
print('ADF Statisic: %f' % result[0])
print('p-value: %f' % result[1])
print('Critical values:')
for key, value in result[4].items() :
        print('\t%s: %.3f' % (key, value))
#p-value가 0.05보다 작기 때문에 정상성을 만족한다.

#정상성을 만족하는 차분된 데이터로 ACF와 PACF 그래프를 그려 ARIMA 모형의 p와 q를 결정
import statsmodels.api as sm
fig = plt.figure(figsize=(20,8))
ax1= fig.add_subplot(211)
fig = sm.graphics.tsa.plot_acf(ts_diff[1:], lags=20, ax=ax1)
ax2= fig.add_subplot(212)
fig = sm.graphics.tsa.plot_pacf(ts_diff[1:], lags=20, ax=ax2)
#ACF와 PACF 모두 금방 0에 수렴하고, 2번째 lag 이후 0에 수렴한다.
#ARIMA(2,1,2), ARIMA(2,1,1), ARIMA(1,1,2), ARIMA(1,1,1)을 실행

from statsmodels.tsa.arima.model import ARIMA
from pandas import datetime
model = ARIMA(ts , order=(2,1,2))
model_fit= model.fit()
print(model_fit.summary())

#start_index = datetime(1944, 6, 25)
#end_index = datetime(1945,5,31)
#forecast = model_fit.predict(start=start_index, end=end_index, typ='levels')

mod = sm.tsa.SARIMAX(ts, order=(2, 1, 2), trend='c')
res =mod.fit()
print(res.forecast())
fcast_res1 = res.get_forecast(steps=500)
print(fcast_res1.summary_frame())
fcast = fcast_res1.summary_frame()
fcast.index = pd.period_range('1945-05-31', periods=500  ,freq='D')
fig, ax = plt.subplots(figsize=(15, 5))
plt.plot(weather_bin.Date, weather_bin.MeanTemp, label = 'original')
fcast['mean'].plot(ax=ax, style='k--')
ax.fill_between(fcast.index, fcast['mean_ci_lower'], fcast['mean_ci_upper'], color='k', alpha=0.1)

fig = plt.figure(figsize=(22,8))
plt.plot(weather_bin.Date, weather_bin.MeanTemp, label = 'original')
plt.plot(forecast, label ='predicted')
plt.legend()

#잔차분석을 통해 모델에 문제가 없는지 확인
resi = np.array(weather_bin[weather_bin.Date>=start_index].MeanTemp) -np.array(forecast)
fig = plt.figure(figsize=(22,8))
plt.plot(weather_bin.Date[weather_bin.Date>=start_index], resi)
plt.legend()
#잔차에 패턴이 없는 것을 확인

#ACF 그래프
fig = plt.figure(figsize=(20,8))
ax1= fig.add_subplot(211)
fig = sm.graphics.tsa.plot_acf(resi, lags=20, ax=ax1)
#0에 수렴

result = adfuller(resi)
print('ADF Statisic: %f' % result[0])
print('p-value: %f' % result[1])
print('Critical values:')
for key, value in result[4].items() :
        print('\t%s: %.3f' % (key, value))
#p-value 값이 작은 것을 확인할 수있음

from sklearn import metrics
def scoring(y_true, y_pred):
    r2 = round(metrics.r2_score(y_true, y_pred) * 100, 3)
    #     mae = round(metrics.mean_absolute_error(y_true, y_pred),3)
    corr = round(np.corrcoef(y_true, y_pred)[0, 1], 3)
    mape = round(
        metrics.mean_absolute_percentage_error(y_true, y_pred) * 100, 3)
    rmse = round(metrics.mean_squared_error(y_true, y_pred, squared=False), 3)

    df = pd.DataFrame({
        'R2': r2,
        "Corr": corr,
        "RMSE": rmse,
        "MAPE": mape
    },
                      index=[0])
    return df
scoring(np.array(weather_bin[weather_bin.Date>=start_index].MeanTemp),np.array(forecast))