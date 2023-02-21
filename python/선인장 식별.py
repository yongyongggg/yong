import pandas as pd
import os
PATH = "C:\\Users\\tj-bu\\PycharmProjects\\pythonProject\\aerial-cactus-identification"
os.chdir(PATH)
labels = pd.read_csv('train.csv')
submission = pd.read_csv('sample_submission.csv')

import torch # 파이토치
import random
import numpy as np
import os
import warnings
warnings.filterwarnings(action='ignore')
# 시드값 고정
seed = 50
os.environ['PYTHONHASHSEED'] = str(seed)
random.seed(seed)                # 파이썬 난수 생성기 시드 고정
np.random.seed(seed)             # 넘파이 난수 생성기 시드 고정
torch.manual_seed(seed)          # 파이토치 난수 생성기 시드 고정 (CPU 사용 시)
torch.cuda.manual_seed(seed)     # 파이토치 난수 생성기 시드 고정 (GPU 사용 시)
torch.cuda.manual_seed_all(seed) # 파이토치 난수 생성기 시드 고정 (멀티GPU 사용 시)
torch.backends.cudnn.deterministic = True # 확정적 연산 사용
torch.backends.cudnn.benchmark = False    # 벤치마크 기능 해제
torch.backends.cudnn.enabled = False      # cudnn 사용 해제

if torch.cuda.is_available():
    device = torch.device('cuda')
else:
    device = torch.device('cpu')

device

from sklearn.model_selection import train_test_split
# 훈련 데이터, 검증 데이터 분리
train, valid = train_test_split(labels,  test_size=0.2, stratify=labels['has_cactus'], random_state=50)
print('훈련 데이터 개수:', len(train))
print('검증 데이터 개수:', len(valid))

import cv2  # OpenCV 라이브러리
from torch.utils.data import Dataset  # 데이터 생성을 위한 클래스


class ImageDataset(Dataset):
    # 초기화 메서드(생성자)
    def __init__(self, df, img_dir='./', transform=None):
        super().__init__()  # 상속받은 Dataset의 생성자 호출
        # 전달받은 인수들 저장
        self.df = df
        self.img_dir = img_dir
        self.transform = transform

    # 데이터셋 크기 반환 메서드
    def __len__(self):
        return len(self.df)

    # 인덱스(idx)에 해당하는 데이터 반환 메서드
    def __getitem__(self, idx):
        img_id = self.df.iloc[idx, 0]  # 이미지 ID
        img_path = self.img_dir + img_id  # 이미지 파일 경로
        image = cv2.imread(img_path)  # 이미지 파일 읽기
        image = cv2.cvtColor(image, cv2.COLOR_BGR2RGB)  # 이미지 색상 보정
        label = self.df.iloc[idx, 1]  # 이미지 레이블(타깃값)

        if self.transform is not None:
            image = self.transform(image)  # 변환기가 있다면 이미지 변환
        return image, label

from torchvision import transforms # 이미지 변환을 위한 모듈
transform = transforms.ToTensor()

dataset_train = ImageDataset(df=train, img_dir='train/', transform=transform)
dataset_valid = ImageDataset(df=valid, img_dir='train/', transform=transform)

from torch.utils.data import DataLoader # 데이터 로더 클래스
loader_train = DataLoader(dataset=dataset_train, batch_size=32, shuffle=True)
loader_valid = DataLoader(dataset=dataset_valid, batch_size=32, shuffle=False)

import torch.nn as nn # 신경망 모듈
import torch.nn.functional as F # 신경망 모듈에서 자주 사용되는 함수


class Model(nn.Module):
    # 신경망 계층 정의
    def __init__(self):
        super().__init__()  # 상속받은 nn.Module의 __init__() 메서드 호출

        # 첫 번째 합성곱 계층
        self.conv1 = nn.Conv2d(in_channels=3, out_channels=32,
                               kernel_size=3, padding=2)
        # 두 번째 합성곱 계층
        self.conv2 = nn.Conv2d(in_channels=32, out_channels=64,
                               kernel_size=3, padding=2)
        # 최대 풀링 계층
        self.max_pool = nn.MaxPool2d(kernel_size=2)
        # 평균 풀링 계층
        self.avg_pool = nn.AvgPool2d(kernel_size=2)
        # 전결합 계층
        self.fc = nn.Linear(in_features=64 * 4 * 4, out_features=2)

    # 순전파 출력 정의
    def forward(self, x):
        x = self.max_pool(F.relu(self.conv1(x)))
        x = self.max_pool(F.relu(self.conv2(x)))
        x = self.avg_pool(x)
        x = x.view(-1, 64 * 4 * 4)  # 평탄화
        x = self.fc(x)
        return x

model = Model().to(device)
model
# 손실함수
criterion = nn.CrossEntropyLoss()
# 옵티마이저
optimizer = torch.optim.SGD(model.parameters(), lr=0.01)
import math
math.ceil(len(train) / 32)
len(loader_train)

epochs = 10  # 총 에폭
# 총 에폭만큼 반복
for epoch in range(epochs):
    epoch_loss = 0  # 에폭별 손실값 초기화

    # '반복 횟수'만큼 반복
    for images, labels in loader_train:
        # 이미지, 레이블 데이터 미니배치를 장비에 할당
        images = images.to(device)
        labels = labels.to(device)

        # 옵티마이저 내 기울기 초기화
        optimizer.zero_grad()
        # 순전파 : 이미지 데이터를 신경망 모델의 입력값으로 사용해 출력값 계산
        outputs = model(images)
        # 손실 함수를 활용해 outputs와 labels의 손실값 계산
        loss = criterion(outputs, labels)
        # 현재 배치에서의 손실 추가
        epoch_loss += loss.item()
        # 역전파 수행
        loss.backward()
        # 가중치 갱신
        optimizer.step()

    # 훈련 데이터 손실값 출력
    print(f'에폭 [{epoch + 1}/{epochs}] - 손실값: {epoch_loss / len(loader_train):.4f}')

from sklearn.metrics import roc_auc_score # ROC AUC 점수 계산 함수 임포트
# 실제값과 예측 확률값을 담을 리스트 초기화
true_list = []
preds_list = []

model.eval()  # 모델을 평가 상태로 설정

with torch.no_grad():  # 기울기 계산 비활성화
    for images, labels in loader_valid:
        # 이미지, 레이블 데이터 미니배치를 장비에 할당
        images = images.to(device)
        labels = labels.to(device)

        # 순전파 : 이미지 데이터를 신경망 모델의 입력값으로 사용해 출력값 계산
        outputs = model(images)
        preds = torch.softmax(outputs.cpu(), dim=1)[:, 1]  # 예측 확률
        true = labels.cpu()  # 실제값
        # 예측 확률과 실제값을 리스트에 추가
        preds_list.extend(preds)
        true_list.extend(true)

# 검증 데이터 ROC AUC 점수 계산
print(f'검증 데이터 ROC AUC : {roc_auc_score(true_list, preds_list):.4f}')

dataset_test = ImageDataset(df=submission, img_dir='test/', transform=transform)
loader_test = DataLoader(dataset=dataset_test, batch_size=32, shuffle=False)

model.eval()  # 모델을 평가 상태로 설정
preds = []  # 타깃 예측값 저장용 리스트 초기화

with torch.no_grad():  # 기울기 계산 비활성화
    for images, _ in loader_test:
        # 이미지 데이터 미니배치를 장비에 할당
        images = images.to(device)

        # 순전파 : 이미지 데이터를 신경망 모델의 입력값으로 사용해 출력값 계산
        outputs = model(images)
        # 타깃값이 1일 확률(예측값)
        preds_part = torch.softmax(outputs.cpu(), dim=1)[:, 1].tolist()
        # preds에 preds_part 이어붙이기
        preds.extend(preds_part)

submission['has_cactus'] = preds
submission.to_csv('submission.csv', index=False)