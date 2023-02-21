import torch # 파이토치
import random
import numpy as np
import os
import torch.nn as nn
import torch.optim as optim
from torch.autograd import Variable

# 시드값 고정
seed = 50
os.environ['PYTHONHASHSEED'] = str(seed)
random.seed(seed)
np.random.seed(seed)
torch.manual_seed(seed)
torch.cuda.manual_seed(seed)
torch.cuda.manual_seed_all(seed)
#torch.backends.cudnn.deterministic = True
#torch.backends.cudnn.benchmark = False
#torch.backends.cudnn.enabled = False

import warnings
warnings.filterwarnings(action='ignore')

device = torch.device('cuda' if torch.cuda.is_available() else 'cpu')

import pandas as pd
import os
PATH = "C:\\Users\\tj-bu\\PycharmProjects\\pythonProject\\aerial-cactus-identification"
os.chdir(PATH)
labels = pd.read_csv('train.csv')
submission = pd.read_csv('sample_submission.csv')

from sklearn.model_selection import train_test_split
# 훈련 데이터, 검증 데이터 분리
train, valid = train_test_split(labels, test_size=0.1,stratify=labels['has_cactus'],random_state=50)

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

# 훈련 데이터용 변환기
transform_train = transforms.Compose([transforms.ToTensor(),
                                      transforms.Pad(32, padding_mode='symmetric'),
                                      transforms.RandomHorizontalFlip(),
                                      transforms.RandomVerticalFlip(),
                                      transforms.RandomRotation(10),
                                      transforms.Normalize((0.485, 0.456, 0.406),
                                                           (0.229, 0.224, 0.225))])

# 검증 및 테스트 데이터용 변환기
transform_test= transforms.Compose([transforms.ToTensor(),
                                    transforms.Pad(32, padding_mode='symmetric'),
                                    transforms.Normalize((0.485, 0.456, 0.406),
                                                         (0.229, 0.224, 0.225))])

dataset_train = ImageDataset(df=train, img_dir='train/', transform=transform_train)
dataset_valid = ImageDataset(df=valid, img_dir='train/', transform=transform_test)
from torch.utils.data import DataLoader # 데이터 로더 클래스
loader_train = DataLoader(dataset=dataset_train, batch_size=32, shuffle=True)
loader_valid = DataLoader(dataset=dataset_valid, batch_size=32, shuffle=False)

import torch.nn as nn  # 신경망 모듈
import torch.nn.functional as F  # 신경망 모듈에서 자주 사용되는 함수

