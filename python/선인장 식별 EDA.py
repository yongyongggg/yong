import pandas as pd
import os
PATH = "C:\\Users\\tj-bu\\PycharmProjects\\pythonProject\\aerial-cactus-identification"
os.chdir(PATH)

labels = pd.read_csv('train.csv')
submission = pd.read_csv('sample_submission.csv')

labels.head()
submission.head()

import matplotlib as mpl
import matplotlib.pyplot as plt
mpl.rc('font', size=15)
plt.figure(figsize=(7, 7))
# 타깃값 레이블
label = ['Has cactus', 'Hasn\'t cactus']
# 타깃값 분포 파이 그래프
plt.pie(labels['has_cactus'].value_counts(), labels=label, autopct='%.1f%%')

from zipfile import ZipFile
# 훈련 이미지 데이터 압출 풀기
with ZipFile('train.zip') as zipper:
    zipper.extractall()

# 테스트 이미지 데이터 압출 풀기
with ZipFile('test.zip') as zipper:
    zipper.extractall()

num_train = len(os.listdir('train/'))
num_test = len(os.listdir('test/'))

print(f'훈련 데이터 개수: {num_train}')
print(f'테스트 데이터 개수: {num_test}')

import matplotlib.gridspec as gridspec
import cv2 # OpenCV
mpl.rc('font', size=7)
plt.figure(figsize=(15, 6))    # 전체 Figure 크기 설정
grid = gridspec.GridSpec(2, 6) # 서브플롯 배치(2행 6열로 출력)

# 선인장을 포함하는 이미지 파일명(마지막 12개)
last_has_cactus_img_name = labels[labels['has_cactus']==1]['id'][-12:]

# 이미지 출력
for idx, img_name in enumerate(last_has_cactus_img_name):
    img_path = 'train/' + img_name                 # 이미지 파일 경로
    image = cv2.imread(img_path)                   # 이미지 파일 읽기
    image = cv2.cvtColor(image, cv2.COLOR_BGR2RGB) # 이미지 색상 보정
    ax = plt.subplot(grid[idx])
    ax.imshow(image)                               # 이미지 출력

image.shape
